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
		'graphElement'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtThemeMatcherMondrianWidget >> initialize [
	super initialize.
	self
		vFitContent;
		hMatchParent;
		padding: (BlInsets all: 4)
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
	mondrian := self buildMondrian.
	graphElement := mondrian root.
	self addChild: graphElement
]

{ #category : 'rendering' }
CgtThemeMatcherMondrianWidget >> buildMondrian [
	| view |
	view := GtMondrian new.
	view nodes
		stencil: [ :aProjectionNode | self newNodeElementFor: aProjectionNode ];
		with: projection nodes.
	projection relations ifNotEmpty: [
		view edges
			fromCenterBottom;
			toCenterTop;
			stencil: [ :aRelation |
				BlLineElement new
					zIndex: -1;
					border: (BlBorder paint: (self edgeColorFor: aRelation) width: 2) ];
			connect: projection relations
			from: [ :aRelation | aRelation fromNode ]
			to: [ :aRelation | aRelation toNode ] ].
	view layout tree.
	^ view
]

{ #category : 'rendering' }
CgtThemeMatcherMondrianWidget >> newNodeElementFor: aProjectionNode [
	| nodeElement |
	nodeElement := CgtMatcherNodeElement new
		projectionNode: aProjectionNode;
		incomingRelation: (self incomingMatcherRelationForNode: aProjectionNode);
		yourself.
	nodeElement when: CgtMatcherNodeSelectedEvent do: [ :anEvent | self forwardNodeSelectedEvent: anEvent ].
	nodeElement when: CgtMatcherClassMatchToggledEvent do: [ :anEvent | self handleClassMatchToggledEvent: anEvent ].
	nodeElement when: CgtMatcherIdMatchToggledEvent do: [ :anEvent | self handleIdMatchToggledEvent: anEvent ].
	nodeElement when: CgtMatcherCombinatorChangedEvent do: [ :anEvent | self handleCombinatorChangedEvent: anEvent ].
	nodeElement when: CgtMatcherCompactedSectionExpandedEvent do: [ :anEvent | self handleCompactedSectionExpandedEvent: anEvent ].
	^ nodeElement
]

{ #category : 'events' }
CgtThemeMatcherMondrianWidget >> forwardNodeSelectedEvent: anEvent [
	self fireEvent: anEvent
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
		isEditable: false;
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

{ #category : 'rendering' }
CgtThemeMatcherMondrianWidget >> edgeColorFor: aRelation [
	aRelation kind = #compaction ifTrue: [ ^ Color gray alpha: 0.5 ].
	aRelation kind = #context ifTrue: [ ^ Color gray alpha: 0.28 ].
	aRelation kind = #otherRule ifTrue: [ ^ Color orange alpha: 0.5 ].
	(aRelation combinator = #descendant) ifTrue: [ ^ Color darkGray alpha: 0.6 ].
	^ Color black alpha: 0.5
]
