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
		'layoutPolicy',
		'transitionPolicy',
		'structuralRefreshAnimationToken'
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
	relationVisualPolicy := CgtMatcherRelationVisualPolicy new.
	transitionPolicy := CgtMatcherTransitionPolicy new.
	structuralRefreshAnimationToken := 0
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
	| newLegend newGraph shouldAnimate |
	projection ifNil: [
		self removeChildren.
		graphElement := nil.
		mondrian := nil.
		^ self ].
	newLegend := CgtMatcherLegendElement new.
	mondrian := self buildMondrian.
	newGraph := mondrian root.
	newGraph constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	shouldAnimate := self children isNotEmpty.
	self removeChildren.
	self addChild: newLegend.
	self addChild: newGraph.
	graphElement := newGraph.
	shouldAnimate ifTrue: [ self animateStructuralRefreshFor: newLegend and: newGraph ]
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




{ #category : 'private - animation' }
CgtThemeMatcherMondrianWidget >> animateStructuralRefreshFor: aLegendElement and: aGraphElement [
	| token startOpacity endOpacity offsetX duration |
	token := structuralRefreshAnimationToken := structuralRefreshAnimationToken + 1.
	startOpacity := transitionPolicy graphRevealStartOpacity.
	endOpacity := transitionPolicy graphRevealEndOpacity.
	offsetX := transitionPolicy graphRevealOffsetX.
	duration := transitionPolicy structuralRefreshDuration.
	{ aLegendElement. aGraphElement } do: [ :each |
		each opacity: startOpacity ].
	self addAnimation: (BlNumberTransition new
			from: 0.0;
			to: 1.0;
			duration: duration;
			easing: CgtFastInSlowOutEasing new;
			onStepDo: [ :aProgress :aWidget |
				aWidget structuralRefreshAnimationToken = token ifTrue: [
					| currentOpacity |
					currentOpacity := startOpacity + ((endOpacity - startOpacity) * aProgress).
					aLegendElement opacity: currentOpacity.
					aGraphElement opacity: currentOpacity ] ];
			onFinishedDo: [ self structuralRefreshAnimationToken = token ifTrue: [
				aLegendElement opacity: endOpacity.
				aGraphElement opacity: endOpacity ] ];
			yourself)
]

{ #category : 'accessing' }
CgtThemeMatcherMondrianWidget >> transitionPolicy [
	^ transitionPolicy
]

{ #category : 'accessing' }
CgtThemeMatcherMondrianWidget >> structuralRefreshAnimationToken [
	^ structuralRefreshAnimationToken ifNil: [ 0 ]
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
	self fireEvent: anEvent
]

{ #category : 'events' }
CgtThemeMatcherMondrianWidget >> handleNodeExcludedFromRuleEvent: anEvent [
	self fireEvent: anEvent
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
	self fireEvent: anEvent
]

{ #category : 'events' }
CgtThemeMatcherMondrianWidget >> handleIdMatchToggledEvent: anEvent [
	self fireEvent: anEvent
]

{ #category : 'events' }
CgtThemeMatcherMondrianWidget >> handleCompactedSectionExpandedEvent: anEvent [
	self fireEvent: anEvent
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
	self fireEvent: anEvent
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

