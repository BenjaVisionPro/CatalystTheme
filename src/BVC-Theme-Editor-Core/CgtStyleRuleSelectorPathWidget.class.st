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
		'renderElementsByKey'
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

{ #category : 'rendering' }
CgtStyleRuleSelectorPathWidget >> refreshContents [
	previousRenderItems := renderItems ifNil: [ OrderedCollection new ] ifNotNil: [ renderItems copy ].
	renderItems := self buildRenderItemsFromProjection.
	self renderItems: renderItems.
	^ self
]

{ #category : 'rendering' }
CgtStyleRuleSelectorPathWidget >> buildRenderItemsFromProjection [
	| items |
	projection ifNil: [ ^ OrderedCollection new ].
	items := OrderedCollection new.
	self orderedVisibleNodes do: [ :aNode |
		aNode isCompactedSection
			ifTrue: [ items add: (self newGapRenderItemFor: aNode) ]
			ifFalse: [ items add: (self newRowRenderItemFor: aNode) ] ].
	projection otherRuleIndicatorNode ifNotNil: [ :anIndicatorNode |
		items add: (CgtMatcherOtherRuleIndicatorRenderItem new
			hiddenCount: anIndicatorNode hiddenNodeCount;
			yourself) ].
	^ items
]

{ #category : 'private - assembly' }
CgtStyleRuleSelectorPathWidget >> orderedVisibleNodes [
	| visibleNodes start ordered current nextRelation |
	projection ifNil: [ ^ #() ].
	visibleNodes := projection visibleCorridorNodes asOrderedCollection.
	visibleNodes ifEmpty: [ ^ #() ].
	start := visibleNodes
		detect: [ :each |
			((projection visibleCorridorRelations select: [ :aRelation | aRelation toNode == each ]) isEmpty) ]
		ifNone: [ visibleNodes first ].
	ordered := OrderedCollection new.
	current := start.
	[current notNil and: [ (ordered includes: current) not ]] whileTrue: [
		ordered add: current.
		nextRelation := (projection visibleCorridorRelations
			detect: [ :aRelation | aRelation fromNode == current ]
			ifNone: [ nil ]).
		current := nextRelation ifNil: [ nil ] ifNotNil: [ nextRelation toNode ] ].
	^ ordered
]

{ #category : 'private - assembly' }
CgtStyleRuleSelectorPathWidget >> newRowRenderItemFor: aProjectionNode [
	^ CgtMatcherRowRenderItem new
		projectionNode: aProjectionNode;
		incomingRelation: (self incomingMatcherRelationForNode: aProjectionNode);
		isSelected: aProjectionNode == projection selectedProjectionNode;
		isCurrentRule: aProjectionNode isInCurrentRule;
		isOtherRule: aProjectionNode isInOtherRule;
		yourself
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
CgtStyleRuleSelectorPathWidget >> incomingMatcherRelationForNode: aProjectionNode [
	projection ifNil: [ ^ nil ].
	^ projection relations
		detect: [ :each | each kind = #matcher and: [ each toNode == aProjectionNode ] ]
		ifNone: [ nil ]
]

{ #category : 'private - assembly' }
CgtStyleRuleSelectorPathWidget >> gapDirectionFor: aProjectionNode [
	projection ifNil: [ ^ #upstream ].
	projection trailingCompactedProjectionNode == aProjectionNode ifTrue: [ ^ #downstream ].
	^ #upstream
]

{ #category : 'rendering' }
CgtStyleRuleSelectorPathWidget >> renderItems: aCollection [
	renderElementsByKey := Dictionary new.
	rowsContainer removeChildren.
	aCollection do: [ :each |
		| element |
		element := self buildElementForRenderItem: each.
		renderElementsByKey at: each renderKey put: element.
		rowsContainer addChild: element ].
	^ self
]

{ #category : 'rendering' }
CgtStyleRuleSelectorPathWidget >> buildElementForRenderItem: aRenderItem [
	aRenderItem isRowItem ifTrue: [ ^ self buildRowElementFor: aRenderItem ].
	aRenderItem isGapItem ifTrue: [ ^ self buildGapElementFor: aRenderItem ].
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
