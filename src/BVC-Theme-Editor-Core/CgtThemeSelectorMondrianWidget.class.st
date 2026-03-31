"
#Theme Selector Mondrian Widget
I am the Mondrian-based concrete renderer for the theme selector UI seam. I render a supplied selector projection and forward user interactions as events without owning selector semantics.
"
Class {
	#name : 'CgtThemeSelectorMondrianWidget',
	#superclass : 'CgtThemeSelectorRendererWidget',
	#instVars : [
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
CgtThemeSelectorMondrianWidget >> initialize [
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
CgtThemeSelectorMondrianWidget >> mondrian [
	^ mondrian
]

{ #category : 'accessing' }
CgtThemeSelectorMondrianWidget >> graphElement [
	^ graphElement
]

{ #category : 'rendering' }
CgtThemeSelectorMondrianWidget >> refreshContents [
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
CgtThemeSelectorMondrianWidget >> buildMondrian [
	| view edgeBuilder |
	view := GtMondrian new.
	view nodes
		stencil: [ :aProjectionNode | self newGraphElementFor: aProjectionNode ];
		with: self orderedNodesForRendering.
	projection relations ifNotEmpty: [
		edgeBuilder := view edges.
		self configureEdgeConnectionsOn: edgeBuilder.
		edgeBuilder
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
CgtThemeSelectorMondrianWidget >> configureEdgeConnectionsOn: anEdgeBuilder [
	| selectors |
	selectors := layoutPolicy edgeConnectionSelectorsForOrientation: layoutPolicy corridorOrientation.
	anEdgeBuilder perform: selectors first.
	anEdgeBuilder perform: selectors second
]




{ #category : 'private - animation' }
CgtThemeSelectorMondrianWidget >> animateStructuralRefreshFor: aLegendElement and: aGraphElement [
	| token startOpacity endOpacity revealOffset duration |
	token := structuralRefreshAnimationToken := structuralRefreshAnimationToken + 1.
	startOpacity := transitionPolicy graphRevealStartOpacity.
	endOpacity := transitionPolicy graphRevealEndOpacity.
	revealOffset := self structuralRefreshRevealOffset.
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
					aGraphElement opacity: currentOpacity.
					self structuralRefreshOffset: revealOffset progress: aProgress on: aGraphElement ] ];
			onFinishedDo: [ self structuralRefreshAnimationToken = token ifTrue: [
				aLegendElement opacity: endOpacity.
				aGraphElement opacity: endOpacity.
				self clearStructuralRefreshOffsetOn: aGraphElement ] ];
			yourself)
]


{ #category : 'private - animation' }
CgtThemeSelectorMondrianWidget >> structuralRefreshRevealOffset [
	projection ifNil: [ ^ 0 @ 0 ].
	transitionPolicy keepsFollowingNodeFixed ifFalse: [
		^ transitionPolicy graphRevealOffsetForOrientation: layoutPolicy corridorOrientation ].
	^ projection hasLeadingCompactedProjectionNode
		ifTrue: [ transitionPolicy graphRevealOffsetForOrientation: layoutPolicy corridorOrientation ]
		ifFalse: [ 0 @ 0 ]
]

{ #category : 'private - animation' }
CgtThemeSelectorMondrianWidget >> structuralRefreshAnchorProjectionNode [
	projection ifNil: [ ^ nil ].
	^ projection followingProjectionNodeAfterLeadingCompaction
		ifNil: [ projection selectedProjectionNode ]
]

{ #category : 'private - animation' }
CgtThemeSelectorMondrianWidget >> structuralRefreshOffset: anOffset progress: aProgress on: anElement [
	| currentOffset leftInset rightInset topInset bottomInset |
	currentOffset := anOffset * (1.0 - aProgress).
	leftInset := (currentOffset x) max: 0.
	rightInset := (currentOffset x negated) max: 0.
	topInset := (currentOffset y) max: 0.
	bottomInset := (currentOffset y negated) max: 0.
	anElement margin: (BlInsets top: topInset right: rightInset bottom: bottomInset left: leftInset)
]

{ #category : 'private - animation' }
CgtThemeSelectorMondrianWidget >> clearStructuralRefreshOffsetOn: anElement [
	anElement margin: (BlInsets all: 0)
]

{ #category : 'accessing' }
CgtThemeSelectorMondrianWidget >> transitionPolicy [
	^ transitionPolicy
]

{ #category : 'accessing' }
CgtThemeSelectorMondrianWidget >> structuralRefreshAnimationToken [
	^ structuralRefreshAnimationToken ifNil: [ 0 ]
]

{ #category : 'rendering' }
CgtThemeSelectorMondrianWidget >> newGraphElementFor: aProjectionNode [
	aProjectionNode isCompactedSection ifTrue: [ ^ self newGapElementFor: aProjectionNode ].
	aProjectionNode isOtherRuleIndicator ifTrue: [ ^ self newOtherRuleIndicatorElementFor: aProjectionNode ].
	^ self newNodeElementFor: aProjectionNode
]

{ #category : 'rendering' }
CgtThemeSelectorMondrianWidget >> newGapElementFor: aProjectionNode [
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
CgtThemeSelectorMondrianWidget >> newOtherRuleIndicatorElementFor: aProjectionNode [
	| indicatorElement |
	indicatorElement := CgtMatcherOtherRuleIndicatorElement new
		projectionNode: aProjectionNode;
		yourself.
	indicatorElement when: CgtMatcherOtherRuleContextToggledEvent do: [ :anEvent | self handleOtherRuleContextToggledEvent: anEvent ].
	^ indicatorElement
]

{ #category : 'rendering' }
CgtThemeSelectorMondrianWidget >> newNodeElementFor: aProjectionNode [
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
CgtThemeSelectorMondrianWidget >> orderedNodesForRendering [
	^ projection nodes asSortedCollection: [ :a :b |
		| aPriority bPriority |
		aPriority := self nodeSortPriorityFor: a.
		bPriority := self nodeSortPriorityFor: b.
		aPriority = bPriority
			ifTrue: [ (a className ifNil: [ '' ]) <= (b className ifNil: [ '' ]) ]
			ifFalse: [ aPriority < bPriority ] ]
]

{ #category : 'rendering' }
CgtThemeSelectorMondrianWidget >> nodeSortPriorityFor: aProjectionNode [
	| visualPolicy priority |
	visualPolicy := CgtMatcherNodeVisualPolicy new.
	priority := visualPolicy nodeSortPriorityFor: aProjectionNode.
	aProjectionNode isInCurrentRule ifTrue: [ ^ priority ].
	aProjectionNode isInOtherRule ifTrue: [ ^ priority + 100 ].
	^ priority + 200
]

{ #category : 'events' }
CgtThemeSelectorMondrianWidget >> forwardNodeSelectedEvent: anEvent [
	self fireEvent: (CgtThemeSelectorNodeSelectedEvent new
		projectionNode: anEvent projectionNode;
		yourself)
]


{ #category : 'events' }
CgtThemeSelectorMondrianWidget >> forwardNodeHoveredEvent: anEvent [
	self fireEvent: (CgtThemeSelectorNodeHoveredEvent new
		projectionNode: anEvent projectionNode;
		yourself)
]

{ #category : 'events' }
CgtThemeSelectorMondrianWidget >> forwardNodeUnhoveredEvent: anEvent [
	self fireEvent: (CgtThemeSelectorNodeUnhoveredEvent new
		projectionNode: anEvent projectionNode;
		yourself)
]



{ #category : 'events' }
CgtThemeSelectorMondrianWidget >> handleNodeIncludedInRuleEvent: anEvent [
	self fireEvent: (CgtThemeSelectorNodeIncludedInRuleEvent new
		projectionNode: anEvent projectionNode;
		yourself)
]

{ #category : 'events' }
CgtThemeSelectorMondrianWidget >> handleNodeExcludedFromRuleEvent: anEvent [
	self fireEvent: (CgtThemeSelectorNodeExcludedFromRuleEvent new
		projectionNode: anEvent projectionNode;
		yourself)
]

{ #category : 'private' }
CgtThemeSelectorMondrianWidget >> preferredIncomingRelationForNode: aProjectionNode [
	| incoming |
	incoming := projection relationsToNode: aProjectionNode.
	^ incoming ifEmpty: [ nil ] ifNotEmpty: [ incoming first ]
]

{ #category : 'private' }
CgtThemeSelectorMondrianWidget >> preferredOutgoingRelationForNode: aProjectionNode [
	| outgoing |
	outgoing := projection relationsFromNode: aProjectionNode.
	^ outgoing ifEmpty: [ nil ] ifNotEmpty: [ outgoing first ]
]

{ #category : 'events' }
CgtThemeSelectorMondrianWidget >> handleClassMatchToggledEvent: anEvent [
	self fireEvent: (CgtThemeSelectorClassMatchChangedEvent new
		projectionNode: anEvent projectionNode;
		shouldMatch: anEvent shouldMatch;
		yourself)
]

{ #category : 'events' }
CgtThemeSelectorMondrianWidget >> handleIdMatchToggledEvent: anEvent [
	self fireEvent: (CgtThemeSelectorIdMatchChangedEvent new
		projectionNode: anEvent projectionNode;
		shouldMatch: anEvent shouldMatch;
		yourself)
]

{ #category : 'events' }
CgtThemeSelectorMondrianWidget >> handleCompactedSectionExpandedEvent: anEvent [
	self fireEvent: (CgtThemeSelectorCompactedSectionExpandedEvent new
		projectionNode: anEvent projectionNode;
		yourself)
]

{ #category : 'events' }
CgtThemeSelectorMondrianWidget >> handleOtherRuleContextToggledEvent: anEvent [
	self fireEvent: CgtThemeSelectorOtherRuleContextToggledEvent new
]


{ #category : 'private' }
CgtThemeSelectorMondrianWidget >> outgoingMatcherRelationForNode: aProjectionNode [
	projection ifNil: [ ^ nil ].
	^ projection relations
		detect: [ :each |
			each fromNode == aProjectionNode
				and: [ each combinator notNil ] ]
		ifNone: [ nil ]
]

{ #category : 'events' }
CgtThemeSelectorMondrianWidget >> handleCombinatorChangedEvent: anEvent [
	self fireEvent: (CgtThemeSelectorCombinatorChangedEvent new
		relation: anEvent relation;
		combinator: anEvent combinator;
		yourself)
]

{ #category : 'private' }
CgtThemeSelectorMondrianWidget >> incomingMatcherRelationForNode: aProjectionNode [
	projection ifNil: [ ^ nil ].
	^ projection relations
		detect: [ :each |
			each kind = #matcher
				and: [ each toNode == aProjectionNode ] ]
		ifNone: [ nil ]
]
