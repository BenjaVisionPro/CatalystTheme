"
#Style Rule Selector Path Widget
I am the hand-built concrete renderer for the style-rule selector path. I render one focused visible selector path from a supplied matcher projection by assembling row, gap, and other-rule indicator elements, while forwarding only selector-facing events and keeping selector semantics in the selector model.
"
Class {
	#name : 'CgtStyleRuleSelectorPathWidget',
	#superclass : 'CgtThemeSelectorRendererWidget',
	#instVars : [
		'layoutPolicy',
		'nodeVisualPolicy',
		'relationVisualPolicy',
		'transitionPolicy',
		'rowsContainer',
		'renderItems',
		'previousRenderItems',
		'renderElementsByKey',
		'previousProjection',
		'structuralRefreshPlan'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtStyleRuleSelectorPathWidget >> initialize [
	super initialize.
	layoutPolicy := CgtMatcherLayoutPolicy new.
	nodeVisualPolicy := CgtMatcherNodeVisualPolicy new.
	relationVisualPolicy := CgtMatcherRelationVisualPolicy new.
	transitionPolicy := CgtMatcherTransitionPolicy new.
	renderItems := OrderedCollection new.
	previousRenderItems := OrderedCollection new.
	renderElementsByKey := Dictionary new.
	previousProjection := nil.
	structuralRefreshPlan := CgtMatcherStructuralRefreshPlan new.
	self
		vFitContent;
		hMatchParent;
		cellSpacing: layoutPolicy widgetCellSpacing;
		padding: layoutPolicy widgetPadding.
	rowsContainer := BrVerticalPane new
		vFitContent;
		hMatchParent;
		cellSpacing: layoutPolicy widgetCellSpacing;
		yourself.
	self addChild: rowsContainer
]

{ #category : 'accessing' }
CgtStyleRuleSelectorPathWidget >> rowsContainer [
	^ rowsContainer
]

{ #category : 'accessing' }
CgtStyleRuleSelectorPathWidget >> renderItems [
	^ renderItems copy
]

{ #category : 'accessing' }
CgtStyleRuleSelectorPathWidget >> structuralRefreshPlan [
	^ structuralRefreshPlan
]

{ #category : 'accessing' }
CgtStyleRuleSelectorPathWidget >> previousProjection [
	^ previousProjection
]

{ #category : 'rendering' }
CgtStyleRuleSelectorPathWidget >> refreshContents [
	previousRenderItems := renderItems ifNil: [ OrderedCollection new ] ifNotNil: [ renderItems copy ].
	structuralRefreshPlan := transitionPolicy
		structuralRefreshPlanFrom: previousProjection
		to: projection
		orientation: layoutPolicy corridorOrientation.
	renderItems := self buildRenderItemsFromProjection.
	self renderItems: renderItems.
	self beginRevealPresentationsForCurrentPlan.
	previousProjection := projection.
	^ self
]

{ #category : 'rendering' }
CgtStyleRuleSelectorPathWidget >> buildRenderItemsFromProjection [
	| items |
	projection ifNil: [ ^ OrderedCollection new ].
	items := self assembleRenderItemsFromOrderedNodes: self orderedVisiblePathNodes.
	projection otherRuleIndicatorNode ifNotNil: [ :anIndicatorNode |
		items := self itemsByInsertingOtherRuleIndicatorFor: anIndicatorNode into: items ].
	^ items
]


{ #category : 'private - assembly' }
CgtStyleRuleSelectorPathWidget >> assembleRenderItemsFromOrderedNodes: orderedNodes [
	| items index |
	items := OrderedCollection new.
	index := 1.
	[index <= orderedNodes size] whileTrue: [
		| node revealedNodes |
		node := orderedNodes at: index.
		node isCompactedSection
			ifTrue: [
				items add: (self newGapRenderItemFor: node).
				index := index + 1 ]
			ifFalse: [
				(self shouldRenderNodeAsRevealedContext: node selected: node == projection selectedProjectionNode)
					ifTrue: [
						revealedNodes := OrderedCollection new.
						[index <= orderedNodes size
							and: [ (orderedNodes at: index) isCompactedSection not
								and: [ self
									shouldRenderNodeAsRevealedContext: (orderedNodes at: index)
									selected: (orderedNodes at: index) == projection selectedProjectionNode ] ] ] whileTrue: [
								revealedNodes add: (orderedNodes at: index).
								index := index + 1 ].
						items add: (self newRevealRenderItemForNodes: revealedNodes) ]
					ifFalse: [
						items add: (self newRowRenderItemFor: node).
						index := index + 1 ] ] ].
	^ items
]

{ #category : 'private - assembly' }
CgtStyleRuleSelectorPathWidget >> itemsByInsertingOtherRuleIndicatorFor: anIndicatorNode into: items [
	| indicatorItem selectedIndex rebuiltItems |
	indicatorItem := self newOtherRuleIndicatorRenderItemFor: anIndicatorNode.
	selectedIndex := items findFirst: [ :each | each isRowItem and: [ each isSelected ] ].
	selectedIndex = 0 ifTrue: [
		items add: indicatorItem.
		^ items ].
	rebuiltItems := OrderedCollection new.
	items doWithIndex: [ :each :anIndex |
		rebuiltItems add: each.
		anIndex = selectedIndex ifTrue: [ rebuiltItems add: indicatorItem ] ].
	^ rebuiltItems
]

{ #category : 'private - assembly' }
CgtStyleRuleSelectorPathWidget >> orderedVisiblePathNodes [
	| selectedNode upstream downstream |
	projection ifNil: [ ^ #() ].
	selectedNode := projection selectedProjectionNode.
	selectedNode ifNil: [ ^ self orderedVisibleNodesFromRoot ].
	upstream := self upstreamVisiblePathNodesBefore: selectedNode.
	downstream := self downstreamVisiblePathNodesAfter: selectedNode.
	^ upstream , (OrderedCollection with: selectedNode) , downstream
]

{ #category : 'private - assembly' }
CgtStyleRuleSelectorPathWidget >> orderedVisibleNodesFromRoot [
	| visibleNodes start ordered current nextNode |
	projection ifNil: [ ^ #() ].
	visibleNodes := projection visibleCorridorNodes asOrderedCollection.
	visibleNodes ifEmpty: [ ^ #() ].
	start := visibleNodes
		detect: [ :each | (self previousVisibleNodeBefore: each) isNil ]
		ifNone: [ visibleNodes first ].
	ordered := OrderedCollection new.
	current := start.
	[current notNil and: [ (ordered includes: current) not ]] whileTrue: [
		ordered add: current.
		nextNode := self nextVisibleNodeAfter: current.
		current := nextNode ].
	^ ordered
]

{ #category : 'private - assembly' }
CgtStyleRuleSelectorPathWidget >> upstreamVisiblePathNodesBefore: aProjectionNode [
	| nodes current previous |
	nodes := OrderedCollection new.
	current := aProjectionNode.
	[(previous := self previousVisibleNodeBefore: current) notNil] whileTrue: [
		nodes addFirst: previous.
		current := previous ].
	^ nodes
]

{ #category : 'private - assembly' }
CgtStyleRuleSelectorPathWidget >> downstreamVisiblePathNodesAfter: aProjectionNode [
	| nodes current next |
	nodes := OrderedCollection new.
	current := aProjectionNode.
	[(next := self nextVisibleNodeAfter: current) notNil] whileTrue: [
		nodes add: next.
		current := next ].
	^ nodes
]

{ #category : 'private - assembly' }
CgtStyleRuleSelectorPathWidget >> previousVisibleNodeBefore: aProjectionNode [
	| relation |
	relation := self visiblePathRelations
		detect: [ :each | each toNode == aProjectionNode ]
		ifNone: [ nil ].
	^ relation ifNil: [ nil ] ifNotNil: [ relation fromNode ]
]

{ #category : 'private - assembly' }
CgtStyleRuleSelectorPathWidget >> nextVisibleNodeAfter: aProjectionNode [
	| relation |
	relation := self visiblePathRelations
		detect: [ :each | each fromNode == aProjectionNode ]
		ifNone: [ nil ].
	^ relation ifNil: [ nil ] ifNotNil: [ relation toNode ]
]

{ #category : 'private - assembly' }
CgtStyleRuleSelectorPathWidget >> visiblePathRelations [
	| visibleNodes |
	projection ifNil: [ ^ #() ].
	visibleNodes := projection visibleCorridorNodes asSet.
	^ projection visibleCorridorRelations select: [ :each |
		(visibleNodes includes: each fromNode) and: [ visibleNodes includes: each toNode ] ]
]

{ #category : 'private - assembly' }
CgtStyleRuleSelectorPathWidget >> newRowRenderItemFor: aProjectionNode [
	| isSelected |
	isSelected := aProjectionNode == projection selectedProjectionNode.
	^ CgtMatcherRowRenderItem new
		projectionNode: aProjectionNode;
		incomingRelation: (self incomingMatcherRelationForNode: aProjectionNode);
		isSelected: isSelected;
		isCurrentRule: aProjectionNode isInCurrentRule;
		isOtherRule: aProjectionNode isInOtherRule;
		isInScope: (isSelected or: [ aProjectionNode isInCurrentRule ]);
		isRevealedContext: (self shouldRenderNodeAsRevealedContext: aProjectionNode selected: isSelected);
		yourself
]


{ #category : 'private - assembly' }
CgtStyleRuleSelectorPathWidget >> shouldRenderNodeAsRevealedContext: aProjectionNode selected: isSelected [
	isSelected ifTrue: [ ^ false ].
	aProjectionNode isCompactedSection ifTrue: [ ^ false ].
	aProjectionNode isOtherRuleIndicator ifTrue: [ ^ false ].
	aProjectionNode isInOtherRule ifTrue: [ ^ false ].
	^ aProjectionNode isInCurrentRule not
]

{ #category : 'private - assembly' }
CgtStyleRuleSelectorPathWidget >> newGapRenderItemFor: aProjectionNode [
	^ CgtMatcherGapRenderItem new
		gapIdentity: aProjectionNode gapIdentity;
		hiddenCount: aProjectionNode hiddenNodeCount;
		direction: (self gapDirectionFor: aProjectionNode);
		yourself
]


{ #category : 'private - assembly' }
CgtStyleRuleSelectorPathWidget >> newRevealRenderItemForNodes: projectionNodes [
	| rowItems direction |
	rowItems := projectionNodes collect: [ :each | self newRowRenderItemFor: each ].
	direction := projectionNodes
		ifEmpty: [ #upstream ]
		ifNotEmpty: [ self revealDirectionForNode: projectionNodes first ].
	^ CgtMatcherRevealRenderItem new
		rowItems: rowItems;
		direction: direction;
		yourself
]

{ #category : 'private - assembly' }
CgtStyleRuleSelectorPathWidget >> revealDirectionForNode: aProjectionNode [
	^ self gapDirectionFor: aProjectionNode
]

{ #category : 'private - assembly' }
CgtStyleRuleSelectorPathWidget >> newOtherRuleIndicatorRenderItemFor: anIndicatorNode [
	^ CgtMatcherOtherRuleIndicatorRenderItem new
		hiddenCount: anIndicatorNode hiddenNodeCount;
		yourself
]

{ #category : 'private - assembly' }
CgtStyleRuleSelectorPathWidget >> incomingMatcherRelationForNode: aProjectionNode [
	projection ifNil: [ ^ nil ].
	^ projection relations
		detect: [ :each | each kind = #matcher and: [ each toNode == aProjectionNode ] ]
		ifNone: [ nil ]
]

{ #category : 'private - assembly' }
CgtStyleRuleSelectorPathWidget >> gapDirectionFor: aProjectionNode [
	| selectedNode downstreamNodes |
	projection ifNil: [ ^ #upstream ].
	selectedNode := projection selectedProjectionNode.
	selectedNode ifNil: [ ^ #upstream ].
	downstreamNodes := self downstreamVisiblePathNodesAfter: selectedNode.
	(downstreamNodes includes: aProjectionNode) ifTrue: [ ^ #downstream ].
	^ #upstream
]

{ #category : 'rendering' }
CgtStyleRuleSelectorPathWidget >> renderItems: aCollection [
	renderElementsByKey := Dictionary new.
	rowsContainer removeChildren.
	aCollection do: [ :each |
		| element |
		element := self buildElementForRenderItem: each.
		rowsContainer addChild: element ].
	^ self
]

{ #category : 'rendering' }
CgtStyleRuleSelectorPathWidget >> buildElementForRenderItem: aRenderItem [
	aRenderItem isRowItem ifTrue: [ ^ self buildRowElementFor: aRenderItem ].
	aRenderItem isGapItem ifTrue: [ ^ self buildGapElementFor: aRenderItem ].
	aRenderItem isRevealItem ifTrue: [ ^ self buildRevealElementFor: aRenderItem ].
	aRenderItem isOtherRuleIndicatorItem ifTrue: [ ^ self buildOtherRuleIndicatorElementFor: aRenderItem ].
	self error: 'Unknown render item kind'
]

{ #category : 'rendering' }
CgtStyleRuleSelectorPathWidget >> buildRowElementFor: aRowRenderItem [
	| rowElement |
	rowElement := CgtMatcherRowElement new
		projectionNode: aRowRenderItem projectionNode;
		incomingRelation: aRowRenderItem incomingRelation;
		nodeVisualPolicy: nodeVisualPolicy;
		selected: aRowRenderItem isSelected;
		currentRule: aRowRenderItem isCurrentRule;
		otherRule: aRowRenderItem isOtherRule;
		inScope: aRowRenderItem isInScope;
		revealedContext: aRowRenderItem isRevealedContext;
		yourself.
	rowElement when: CgtMatcherNodeHoveredEvent do: [ :anEvent |
		self announceSelectorNodeHoveredFor: anEvent projectionNode ].
	rowElement when: CgtMatcherNodeUnhoveredEvent do: [ :anEvent |
		self announceSelectorNodeUnhoveredFor: anEvent projectionNode ].
	rowElement when: CgtMatcherNodeSelectedEvent do: [ :anEvent |
		self announceSelectorNodeSelectedFor: anEvent projectionNode ].
	rowElement when: CgtMatcherClassMatchToggledEvent do: [ :anEvent |
		self announceSelectorClassMatch: anEvent shouldMatch for: anEvent projectionNode ].
	rowElement when: CgtMatcherIdMatchToggledEvent do: [ :anEvent |
		self announceSelectorIdMatch: anEvent shouldMatch for: anEvent projectionNode ].
	rowElement when: CgtMatcherCombinatorChangedEvent do: [ :anEvent |
		self announceSelectorCombinator: anEvent combinator for: anEvent relation ].
	^ rowElement
]


{ #category : 'rendering' }
CgtStyleRuleSelectorPathWidget >> buildRevealElementFor: aRevealRenderItem [
	| revealElement rowElements |
	rowElements := aRevealRenderItem rowItems collect: [ :each |
		self buildRowElementFor: each ].
	revealElement := CgtMatcherRevealElement new
		direction: aRevealRenderItem direction;
		transitionPolicy: transitionPolicy;
		structuralRefreshPlan: structuralRefreshPlan;
		rowElements: rowElements;
		yourself.
	^ revealElement
]

{ #category : 'rendering' }
CgtStyleRuleSelectorPathWidget >> buildGapElementFor: aGapRenderItem [
	| gapProjectionNode gapElement |
	gapProjectionNode := projection compactedSectionNodes
		detect: [ :each | each gapIdentity = aGapRenderItem gapIdentity ]
		ifNone: [ nil ].
	gapElement := CgtMatcherGapElement new
		projectionNode: gapProjectionNode;
		outgoingRelation: (gapProjectionNode ifNil: [ nil ] ifNotNil: [ self outgoingRelationForGapNode: gapProjectionNode ]);
		yourself.
	gapElement when: CgtMatcherCombinatorChangedEvent do: [ :anEvent |
		self announceSelectorCombinator: anEvent combinator for: anEvent relation ].
	gapElement when: CgtMatcherCompactedSectionExpandedEvent do: [ :anEvent |
		self announceSelectorCompactedSectionExpandedFor: anEvent projectionNode ].
	^ gapElement
]

{ #category : 'private - assembly' }
CgtStyleRuleSelectorPathWidget >> outgoingRelationForGapNode: aProjectionNode [
	| relations |
	projection ifNil: [ ^ nil ].
	relations := projection relationsFromNode: aProjectionNode.
	^ relations ifEmpty: [ nil ] ifNotEmpty: [ :each | each first ]
]

{ #category : 'rendering' }
CgtStyleRuleSelectorPathWidget >> buildOtherRuleIndicatorElementFor: aRenderItem [
	| indicatorNode indicatorElement |
	indicatorNode := projection otherRuleIndicatorNode.
	indicatorElement := CgtMatcherOtherRuleIndicatorElement new
		projectionNode: indicatorNode;
		yourself.
	indicatorElement when: CgtMatcherOtherRuleContextToggledEvent do: [ :anEvent |
		self announceSelectorOtherRuleContextToggled ].
	^ indicatorElement
]

{ #category : 'accessing' }
CgtStyleRuleSelectorPathWidget >> revealElements [
	^ rowsContainer children select: [ :each | each isKindOf: CgtMatcherRevealElement ]
]

{ #category : 'actions' }
CgtStyleRuleSelectorPathWidget >> beginRevealPresentationsForCurrentPlan [
	(self revealElements) do: [ :each |
		(transitionPolicy shouldAnimateStructuralRefreshPlan: structuralRefreshPlan)
			ifTrue: [ each beginViewportPresentationForCurrentPlan ]
			ifFalse: [ each finishViewportPresentationForCurrentPlan ] ].
	self refreshRevealPresentationLayout.
	^ self
]

{ #category : 'actions' }
CgtStyleRuleSelectorPathWidget >> completeRevealPresentationsForCurrentPlan [
	self revealElements do: [ :each | each finishViewportPresentationForCurrentPlan ].
	self refreshRevealPresentationLayout.
	^ self
]

{ #category : 'actions' }
CgtStyleRuleSelectorPathWidget >> advanceRevealPresentationsBy: aNumber [
	self revealElements do: [ :each | each advanceViewportPresentationProgressBy: aNumber ].
	self refreshRevealPresentationLayout.
	^ self
]

{ #category : 'actions' }
CgtStyleRuleSelectorPathWidget >> applyRevealPresentationProgress: aNumber [
	self revealElements do: [ :each | each viewportPresentationProgress: aNumber ].
	self refreshRevealPresentationLayout.
	^ self
]

{ #category : 'actions' }
CgtStyleRuleSelectorPathWidget >> refreshRevealPresentationLayout [
	self revealElements do: [ :each | each requestLayout ].
	rowsContainer requestLayout.
	self requestLayout.
	^ self
]

{ #category : 'testing' }
CgtStyleRuleSelectorPathWidget >> hasRevealPresentationsInFlight [
	^ self revealElements anySatisfy: [ :each | each isAtTargetViewportPresentationProgress not ]
]

