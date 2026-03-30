"
#Theme Matcher Mondrian Widget
I render a matcher projection through Mondrian. I am responsible for building a Mondrian graph with custom node stencils from passive projection data and forwarding explicit matcher widget events without taking on selector or editor semantics.
"
Class {
	#name : 'CgtThemeMatcherMondrianWidget',
	#superclass : 'BrVerticalPane',
	#instVars : [
		'projection',
		'mondrian',
		'graphElement',
		'relationVisualPolicy',
		'layoutPolicy'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtThemeMatcherMondrianWidget >> initialize [
	super initialize.
	layoutPolicy := CgtMatcherLayoutPolicy new.
	self
		vFitContent;
		hMatchParent;
		cellSpacing: layoutPolicy widgetCellSpacing;
		padding: layoutPolicy widgetPadding.
	relationVisualPolicy := CgtMatcherRelationVisualPolicy new
]

{ #category : 'accessing' }
CgtThemeMatcherMondrianWidget >> projection [
	^ projection
]

{ #category : 'accessing' }
CgtThemeMatcherMondrianWidget >> projection: aCgtMatcherProjection [
	projection := aCgtMatcherProjection.
	self refreshContents.
	^ self
]

{ #category : 'accessing' }
CgtThemeMatcherMondrianWidget >> mondrian [
	^ mondrian
]

{ #category : 'accessing' }
CgtThemeMatcherMondrianWidget >> graphElement [
	^ graphElement
]

{ #category : 'accessing' }
CgtThemeMatcherMondrianWidget >> currentSelector [
	^ CgtMatcherProjectionSelectorComposer selectorForProjection: projection
]

{ #category : 'rendering' }
CgtThemeMatcherMondrianWidget >> refreshContents [
	self removeChildren.
	projection ifNil: [ ^ self ].
	self addChild: CgtMatcherLegendElement new.
	mondrian := self buildMondrian.
	graphElement := mondrian root.
	graphElement constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	self addChild: graphElement
]

{ #category : 'rendering' }
CgtThemeMatcherMondrianWidget >> buildMondrian [
	| view |
	view := GtMondrian new.
	view nodes
		stencil: [ :aProjectionNode | self newGraphElementFor: aProjectionNode ];
		with: self orderedNodesForRendering.
	projection relations ifNotEmpty: [
		view edges
			fromCenterBottom;
			toCenterTop;
			stencil: [ :aRelation |
				BlLineElement new
					zIndex: -1;
					border: (BlBorder paint: (relationVisualPolicy colorForRelation: aRelation) width: (relationVisualPolicy widthForRelation: aRelation)) ];
			connect: projection relations
			from: [ :aRelation | aRelation fromNode ]
			to: [ :aRelation | aRelation toNode ] ].
	view layout tree.
	^ view
]



{ #category : 'rendering' }
CgtThemeMatcherMondrianWidget >> newGraphElementFor: aProjectionNode [
	aProjectionNode isCompactedSection ifTrue: [ ^ self newGapElementFor: aProjectionNode ].
	^ self newNodeElementFor: aProjectionNode
]

{ #category : 'rendering' }
CgtThemeMatcherMondrianWidget >> newGapElementFor: aProjectionNode [
	| gapElement |
	gapElement := CgtMatcherGapElement new
		projectionNode: aProjectionNode;
		outgoingRelation: (self outgoingMatcherRelationForNode: aProjectionNode);
		yourself.
	gapElement when: CgtMatcherCombinatorChangedEvent do: [ :anEvent | self handleCombinatorChangedEvent: anEvent ].
	gapElement when: CgtMatcherCompactedSectionExpandedEvent do: [ :anEvent | self handleCompactedSectionExpandedEvent: anEvent ].
	^ gapElement
]

{ #category : 'rendering' }
CgtThemeMatcherMondrianWidget >> newNodeElementFor: aProjectionNode [
	| nodeElement |
	nodeElement := CgtMatcherNodeElement new
		projectionNode: aProjectionNode;
		incomingRelation: (self incomingMatcherRelationForNode: aProjectionNode);
		yourself.
	nodeElement when: CgtMatcherNodeSelectedEvent do: [ :anEvent | self forwardNodeSelectedEvent: anEvent ].
	nodeElement when: CgtMatcherNodeHoveredEvent do: [ :anEvent | self forwardNodeHoveredEvent: anEvent ].
	nodeElement when: CgtMatcherNodeUnhoveredEvent do: [ :anEvent | self forwardNodeUnhoveredEvent: anEvent ].
	nodeElement when: CgtMatcherClassMatchToggledEvent do: [ :anEvent | self handleClassMatchToggledEvent: anEvent ].
	nodeElement when: CgtMatcherNodeIncludedInRuleEvent do: [ :anEvent | self handleNodeIncludedInRuleEvent: anEvent ].
	nodeElement when: CgtMatcherNodeExcludedFromRuleEvent do: [ :anEvent | self handleNodeExcludedFromRuleEvent: anEvent ].
	nodeElement when: CgtMatcherIdMatchToggledEvent do: [ :anEvent | self handleIdMatchToggledEvent: anEvent ].
	nodeElement when: CgtMatcherCombinatorChangedEvent do: [ :anEvent | self handleCombinatorChangedEvent: anEvent ].
	nodeElement when: CgtMatcherCompactedSectionExpandedEvent do: [ :anEvent | self handleCompactedSectionExpandedEvent: anEvent ].
	^ nodeElement
]

{ #category : 'rendering' }
CgtThemeMatcherMondrianWidget >> orderedNodesForRendering [
	^ projection nodes asSortedCollection: [ :a :b |
		| aPriority bPriority |
		aPriority := self nodeSortPriorityFor: a.
		bPriority := self nodeSortPriorityFor: b.
		aPriority = bPriority
			ifTrue: [ (a className ifNil: [ '' ]) <= (b className ifNil: [ '' ]) ]
			ifFalse: [ aPriority < bPriority ] ]
]

{ #category : 'rendering' }
CgtThemeMatcherMondrianWidget >> nodeSortPriorityFor: aProjectionNode [
	| visualPolicy priority |
	visualPolicy := CgtMatcherNodeVisualPolicy new.
	priority := visualPolicy nodeSortPriorityFor: aProjectionNode.
	aProjectionNode isInCurrentRule ifTrue: [ ^ priority ].
	aProjectionNode isInOtherRule ifTrue: [ ^ priority + 100 ].
	^ priority + 200
]

{ #category : 'events' }
CgtThemeMatcherMondrianWidget >> forwardNodeSelectedEvent: anEvent [
	self fireEvent: anEvent
]


{ #category : 'events' }
CgtThemeMatcherMondrianWidget >> forwardNodeHoveredEvent: anEvent [
	self fireEvent: anEvent
]

{ #category : 'events' }
CgtThemeMatcherMondrianWidget >> forwardNodeUnhoveredEvent: anEvent [
	self fireEvent: anEvent
]



{ #category : 'events' }
CgtThemeMatcherMondrianWidget >> handleNodeIncludedInRuleEvent: anEvent [
	self includeProjectionNodeInCurrentRule: anEvent projectionNode.
	self refreshContents.
	self fireEvent: anEvent.
	self publishSelectorChanged
]

{ #category : 'events' }
CgtThemeMatcherMondrianWidget >> handleNodeExcludedFromRuleEvent: anEvent [
	self excludeProjectionNodeFromCurrentRule: anEvent projectionNode.
	self refreshContents.
	self fireEvent: anEvent.
	self publishSelectorChanged
]

{ #category : 'private' }
CgtThemeMatcherMondrianWidget >> includeProjectionNodeInCurrentRule: aProjectionNode [
	| incoming outgoing |
	aProjectionNode ifNil: [ ^ self ].
	aProjectionNode isInCurrentRule: true.
	(aProjectionNode matchByClass not and: [ aProjectionNode matchById not ]) ifTrue: [
		aProjectionNode matchByClass: true ].
	incoming := self preferredIncomingRelationForNode: aProjectionNode.
	incoming ifNotNil: [
		incoming kind: #matcher.
		incoming combinator ifNil: [ incoming combinator: #child ] ].
	outgoing := self preferredOutgoingRelationForNode: aProjectionNode.
	outgoing ifNotNil: [
		(outgoing toNode isInCurrentRule or: [ outgoing toNode kind = #selectedElement ]) ifTrue: [
			outgoing kind: #matcher.
			outgoing combinator ifNil: [ outgoing combinator: #child ] ] ]
]

{ #category : 'private' }
CgtThemeMatcherMondrianWidget >> excludeProjectionNodeFromCurrentRule: aProjectionNode [
	| incoming |
	aProjectionNode ifNil: [ ^ self ].
	aProjectionNode kind = #selectedElement ifTrue: [ ^ self ].
	aProjectionNode isInCurrentRule: false.
	incoming := self preferredIncomingRelationForNode: aProjectionNode.
	incoming ifNotNil: [ incoming kind: #context ]
]

{ #category : 'private' }
CgtThemeMatcherMondrianWidget >> preferredIncomingRelationForNode: aProjectionNode [
	| incoming |
	incoming := projection relationsToNode: aProjectionNode.
	^ incoming ifEmpty: [ nil ] ifNotEmpty: [ incoming first ]
]

{ #category : 'private' }
CgtThemeMatcherMondrianWidget >> preferredOutgoingRelationForNode: aProjectionNode [
	| outgoing |
	outgoing := projection relationsFromNode: aProjectionNode.
	^ outgoing ifEmpty: [ nil ] ifNotEmpty: [ outgoing first ]
]

{ #category : 'events' }
CgtThemeMatcherMondrianWidget >> handleClassMatchToggledEvent: anEvent [
	anEvent projectionNode matchByClass: anEvent shouldMatch.
	self refreshContents.
	self fireEvent: anEvent.
	self publishSelectorChanged
]

{ #category : 'events' }
CgtThemeMatcherMondrianWidget >> handleIdMatchToggledEvent: anEvent [
	anEvent projectionNode matchById: anEvent shouldMatch.
	self refreshContents.
	self fireEvent: anEvent.
	self publishSelectorChanged
]

{ #category : 'events' }
CgtThemeMatcherMondrianWidget >> handleCompactedSectionExpandedEvent: anEvent [
	self expandCompactedNode: anEvent projectionNode.
	self refreshContents.
	self fireEvent: anEvent.
	self publishSelectorChanged
]

{ #category : 'events' }
CgtThemeMatcherMondrianWidget >> expandCompactedNode: aProjectionNode [
	| incomingRelations outgoingRelations hiddenNodes previousNode nextNode previousLinkNode outgoingRelation revealedNodes |
	(projection isNil or: [ aProjectionNode isNil or: [ aProjectionNode representedElements isEmpty ] ]) ifTrue: [ ^ self ].
	incomingRelations := projection relationsToNode: aProjectionNode.
	outgoingRelations := projection relationsFromNode: aProjectionNode.
	hiddenNodes := aProjectionNode representedElements collect: [ :each |
		self revealedContextNodeForElement: each ].
	revealedNodes := hiddenNodes asOrderedCollection.
	revealedNodes do: [ :each | projection addNode: each ].
	previousNode := incomingRelations ifEmpty: [ nil ] ifNotEmpty: [ incomingRelations first fromNode ].
	nextNode := outgoingRelations ifEmpty: [ nil ] ifNotEmpty: [ outgoingRelations first toNode ].
	previousLinkNode := previousNode.
	revealedNodes do: [ :eachNode |
		previousLinkNode ifNotNil: [
			projection addRelation: (CgtMatcherProjectionRelation from: previousLinkNode to: eachNode kind: #context) ].
		previousLinkNode := eachNode ].
	outgoingRelation := outgoingRelations ifEmpty: [ nil ] ifNotEmpty: [ outgoingRelations first ].
	(previousLinkNode notNil and: [ nextNode notNil ]) ifTrue: [
		projection addRelation: ((CgtMatcherProjectionRelation from: previousLinkNode to: nextNode kind: outgoingRelation kind)
			combinator: outgoingRelation combinator;
			yourself) ].
	incomingRelations do: [ :each | projection removeRelation: each ].
	outgoingRelations do: [ :each | projection removeRelation: each ].
	projection removeNode: aProjectionNode
]

{ #category : 'private' }
CgtThemeMatcherMondrianWidget >> revealedContextNodeForElement: anElement [
	^ (CgtMatcherProjectionNode kind: (self kindForRevealedContextElement: anElement))
		representedElement: anElement;
		isEditable: true;
		yourself
]

{ #category : 'private' }
CgtThemeMatcherMondrianWidget >> kindForRevealedContextElement: anElement [
	anElement == projection selectedElement ifTrue: [ ^ #selectedElement ].
	(self isAncestor: anElement of: projection selectedElement) ifTrue: [ ^ #upstreamScope ].
	(self isAncestor: projection selectedElement of: anElement) ifTrue: [ ^ #downstreamScope ].
	^ #otherRuleRelated
]

{ #category : 'private' }
CgtThemeMatcherMondrianWidget >> isAncestor: aPossibleAncestor of: anElement [
	| current |
	aPossibleAncestor ifNil: [ ^ false ].
	anElement ifNil: [ ^ false ].
	current := anElement parent.
	[current notNil] whileTrue: [
		current == aPossibleAncestor ifTrue: [ ^ true ].
		current := current parent ].
	^ false
]



{ #category : 'private' }
CgtThemeMatcherMondrianWidget >> outgoingMatcherRelationForNode: aProjectionNode [
	projection ifNil: [ ^ nil ].
	^ projection relations
		detect: [ :each |
			each fromNode == aProjectionNode
				and: [ each combinator notNil ] ]
		ifNone: [ nil ]
]

{ #category : 'events' }
CgtThemeMatcherMondrianWidget >> handleCombinatorChangedEvent: anEvent [
	anEvent relation combinator: anEvent combinator.
	self refreshContents.
	self fireEvent: anEvent.
	self publishSelectorChanged
]

{ #category : 'private' }
CgtThemeMatcherMondrianWidget >> incomingMatcherRelationForNode: aProjectionNode [
	projection ifNil: [ ^ nil ].
	^ projection relations
		detect: [ :each |
			each kind = #matcher
				and: [ each toNode == aProjectionNode ] ]
		ifNone: [ nil ]
]

{ #category : 'events' }
CgtThemeMatcherMondrianWidget >> publishSelectorChanged [
	self fireEvent: (CgtMatcherSelectorChangedEvent new
		projection: projection;
		selector: self currentSelector;
		yourself)
]
