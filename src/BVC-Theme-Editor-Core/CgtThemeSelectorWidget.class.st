"
#Theme Selector Widget
I am the host widget for the theme selector editor. I own a non-visual CgtThemeSelectorModel and one pluggable selector renderer widget. I coordinate selector editing semantics through the model while keeping rendering technology replaceable.
"
Class {
	#name : 'CgtThemeSelectorWidget',
	#superclass : 'BrVerticalPane',
	#instVars : [
		'model',
		'rendererWidget',
		'rendererWidgetClass'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}


{ #category : 'initialization' }
CgtThemeSelectorWidget >> initialize [
	super initialize.
	model := CgtThemeSelectorModel new.
	rendererWidgetClass := CgtThemeSelectorMondrianWidget.
	self
		vFitContent;
		hMatchParent.
	self installRendererWidget
]



{ #category : 'initialization' }
CgtThemeSelectorWidget >> buildRendererWidget [
	(rendererWidgetClass inheritsFrom: CgtThemeSelectorRendererWidget) ifFalse: [
		self error: 'Selector renderer widgets must subclass CgtThemeSelectorRendererWidget' ].
	^ rendererWidgetClass new
]

{ #category : 'initialization' }
CgtThemeSelectorWidget >> installRendererWidget [
	rendererWidget ifNotNil: [ self removeChild: rendererWidget ].
	rendererWidget := self buildRendererWidget.
	self addChild: rendererWidget.
	self wireRendererWidget.
	self refreshProjectionFromModel.
	^ self
]

{ #category : 'initialization' }
CgtThemeSelectorWidget >> wireRendererWidget [
	rendererWidget when: CgtThemeSelectorCompactedSectionExpandedEvent do: [ :anEvent |
		self selectorCompactedSectionExpandedEvent: anEvent ].
	rendererWidget when: CgtThemeSelectorNodeIncludedInRuleEvent do: [ :anEvent |
		self selectorNodeIncludedInRuleEvent: anEvent ].
	rendererWidget when: CgtThemeSelectorNodeExcludedFromRuleEvent do: [ :anEvent |
		self selectorNodeExcludedFromRuleEvent: anEvent ].
	rendererWidget when: CgtThemeSelectorClassMatchChangedEvent do: [ :anEvent |
		self selectorClassMatchChangedEvent: anEvent ].
	rendererWidget when: CgtThemeSelectorIdMatchChangedEvent do: [ :anEvent |
		self selectorIdMatchChangedEvent: anEvent ].
	rendererWidget when: CgtThemeSelectorCombinatorChangedEvent do: [ :anEvent |
		self selectorCombinatorChangedEvent: anEvent ].
	rendererWidget when: CgtThemeSelectorNodeHoveredEvent do: [ :anEvent |
		self selectorNodeHoveredEvent: anEvent ].
	rendererWidget when: CgtThemeSelectorNodeSelectedEvent do: [ :anEvent |
		self selectorNodeSelectedEvent: anEvent ].
	rendererWidget when: CgtThemeSelectorNodeUnhoveredEvent do: [ :anEvent |
		self selectorNodeUnhoveredEvent: anEvent ].
	rendererWidget when: CgtThemeSelectorOtherRuleContextToggledEvent do: [ :anEvent |
		self selectorOtherRuleContextToggledEvent: anEvent ]
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> configureForStyleRule: aCgtThemeStyleRule selectedElement: anElement hierarchyRoot: aRootElement relatedStyleRules: aCollection [
	model
		configureForStyleRule: aCgtThemeStyleRule
		selectedElement: anElement
		hierarchyRoot: aRootElement
		relatedStyleRules: aCollection.
	self refreshProjectionFromModel.
	^ self
]

{ #category : 'events' }
CgtThemeSelectorWidget >> selectorInteractionEvent: anEvent [
	self scheduleIdleCollapse.
	self fireEvent: anEvent.
	^ self
]

{ #category : 'events' }
CgtThemeSelectorWidget >> selectorNodeHoveredEvent: anEvent [
	^ self selectorInteractionEvent: anEvent
]

{ #category : 'events' }
CgtThemeSelectorWidget >> selectorNodeSelectedEvent: anEvent [
	^ self selectorInteractionEvent: anEvent
]

{ #category : 'events' }
CgtThemeSelectorWidget >> selectorNodeUnhoveredEvent: anEvent [
	self fireEvent: anEvent.
	^ self
]

{ #category : 'event handling' }
CgtThemeSelectorWidget >> selectorClassMatchChangedEvent: anEvent [
	model applyClassMatch: anEvent shouldMatch toProjectionNode: anEvent projectionNode.
	self refreshProjectionFromModel.
	self scheduleIdleCollapse.
	self publishSelectorChanged
]

{ #category : 'event handling' }
CgtThemeSelectorWidget >> selectorCombinatorChangedEvent: anEvent [
	model applyCombinator: anEvent combinator toRelation: anEvent relation.
	self refreshProjectionFromModel.
	self scheduleIdleCollapse.
	self publishSelectorChanged
]

{ #category : 'event handling' }
CgtThemeSelectorWidget >> selectorCompactedSectionExpandedEvent: anEvent [
	model revealCompactedProjectionNode: anEvent projectionNode.
	self refreshProjectionFromModel.
	self scheduleIdleCollapse
]

{ #category : 'event handling' }
CgtThemeSelectorWidget >> selectorIdMatchChangedEvent: anEvent [
	model applyIdMatch: anEvent shouldMatch toProjectionNode: anEvent projectionNode.
	self refreshProjectionFromModel.
	self scheduleIdleCollapse.
	self publishSelectorChanged
]

{ #category : 'event handling' }
CgtThemeSelectorWidget >> selectorNodeExcludedFromRuleEvent: anEvent [
	model excludeProjectionNode: anEvent projectionNode.
	self refreshProjectionFromModel.
	self scheduleIdleCollapse.
	self publishSelectorChanged
]

{ #category : 'event handling' }
CgtThemeSelectorWidget >> selectorNodeIncludedInRuleEvent: anEvent [
	model includeProjectionNode: anEvent projectionNode.
	self refreshProjectionFromModel.
	self scheduleIdleCollapse.
	self publishSelectorChanged
]

{ #category : 'event handling' }
CgtThemeSelectorWidget >> selectorOtherRuleContextToggledEvent: anEvent [
	model toggleOtherRuleContext.
	self refreshProjectionFromModel.
	self scheduleIdleCollapse.
	^ self
]

{ #category : 'private - idle collapse' }
CgtThemeSelectorWidget >> noteMatcherInteraction [
	^ model noteMatcherInteraction
]

{ #category : 'private - idle collapse' }
CgtThemeSelectorWidget >> scheduleIdleCollapse [
	model scheduleIdleCollapseAfter: [ self collapseTemporaryReveals ].
	^ self
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> idleCollapseDelayMilliseconds [
	^ model idleCollapseDelayMilliseconds
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> idleCollapseDelayMilliseconds: anInteger [
	model idleCollapseDelayMilliseconds: anInteger.
	^ self
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> styleRule [
	^ model currentStyleRule
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> styleRule: aCgtThemeStyleRule [
	model styleRule: aCgtThemeStyleRule.
	self refreshProjectionFromModel.
	^ self
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> selectedElement [
	^ model selectedElement
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> selectedElement: anElement [
	model selectedElement: anElement.
	self refreshProjectionFromModel.
	^ self
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> hierarchyRoot [
	^ model hierarchyRoot
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> hierarchyRoot: anElement [
	model hierarchyRoot: anElement.
	self refreshProjectionFromModel.
	^ self
]



{ #category : 'accessing' }
CgtThemeSelectorWidget >> relatedStyleRules [
	^ model relatedStyleRules
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> relatedStyleRules: aCollection [
	model relatedStyleRules: aCollection.
	self refreshProjectionFromModel.
	^ self
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> selector [
	^ model selector
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> currentSelector [
	^ model selector
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> currentStyleRule [
	^ model currentStyleRule
]

{ #category : 'event handling' }
CgtThemeSelectorWidget >> selectorChangedEvent: anEvent [
	model selector: anEvent selector.
	self refreshProjectionFromModel
]


{ #category : 'accessing' }
CgtThemeSelectorWidget >> selectorModel [
	^ model
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> selectorRendererWidget [
	^ rendererWidget
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> selectorRendererWidgetClass [
	^ self rendererWidgetClass
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> selectorRendererWidgetClass: aClass [
	^ self rendererWidgetClass: aClass
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> model [
	^ model
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> rendererWidgetClass [
	^ rendererWidgetClass ifNil: [ CgtThemeSelectorMondrianWidget ]
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> rendererWidgetClass: aClass [
	rendererWidgetClass := aClass ifNil: [ CgtThemeSelectorMondrianWidget ].
	self installRendererWidget.
	^ self
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> rendererWidget [
	^ rendererWidget
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> projection [
	^ model projection
]

{ #category : 'private - projection' }
CgtThemeSelectorWidget >> refreshProjection [
	self refreshProjectionFromModel
]

{ #category : 'private - projection' }
CgtThemeSelectorWidget >> refreshProjectionFromModel [
	rendererWidget projection: model projection.
	^ self
]

{ #category : 'events' }
CgtThemeSelectorWidget >> publishSelectorChanged [
	self fireEvent: (CgtThemeSelectorChangedEvent new
		projection: self projection;
		selector: self currentSelector;
		yourself)
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> visibilityState [
	^ model visibilityState
]

{ #category : 'editing' }
CgtThemeSelectorWidget >> showOtherRuleContext [
	model showOtherRuleContext.
	self refreshProjectionFromModel.
	^ self
]

{ #category : 'editing' }
CgtThemeSelectorWidget >> hideOtherRuleContext [
	model hideOtherRuleContext.
	self refreshProjectionFromModel.
	^ self
]

{ #category : 'editing' }
CgtThemeSelectorWidget >> toggleOtherRuleContext [
	model toggleOtherRuleContext.
	self refreshProjectionFromModel.
	^ self
]

{ #category : 'events' }
CgtThemeSelectorWidget >> collapseTemporaryReveals [
	model collapseTemporaryReveals.
	self refreshProjectionFromModel
]
