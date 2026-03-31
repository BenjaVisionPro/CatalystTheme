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
	rendererWidget when: CgtMatcherCompactedSectionExpandedEvent do: [ :anEvent |
		self matcherCompactedSectionExpandedEvent: anEvent ].
	rendererWidget when: CgtMatcherNodeIncludedInRuleEvent do: [ :anEvent |
		self matcherNodeIncludedInRuleEvent: anEvent ].
	rendererWidget when: CgtMatcherNodeExcludedFromRuleEvent do: [ :anEvent |
		self matcherNodeExcludedFromRuleEvent: anEvent ].
	rendererWidget when: CgtMatcherClassMatchToggledEvent do: [ :anEvent |
		self matcherClassMatchToggledEvent: anEvent ].
	rendererWidget when: CgtMatcherIdMatchToggledEvent do: [ :anEvent |
		self matcherIdMatchToggledEvent: anEvent ].
	rendererWidget when: CgtMatcherCombinatorChangedEvent do: [ :anEvent |
		self matcherCombinatorChangedEvent: anEvent ].
	rendererWidget when: CgtMatcherNodeHoveredEvent do: [ :anEvent |
		self matcherNodeHoveredEvent: anEvent ].
	rendererWidget when: CgtMatcherNodeSelectedEvent do: [ :anEvent |
		self matcherNodeSelectedEvent: anEvent ].
	rendererWidget when: CgtMatcherNodeUnhoveredEvent do: [ :anEvent |
		self matcherNodeUnhoveredEvent: anEvent ]
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> configureForStyleRule: aCgtThemeStyleRule selectedElement: anElement pathRootElement: aRootElement relatedStyleRules: aCollection [
	model
		configureForStyleRule: aCgtThemeStyleRule
		selectedElement: anElement
		pathRootElement: aRootElement
		relatedStyleRules: aCollection.
	self refreshProjectionFromModel.
	^ self
]

{ #category : 'events' }
CgtThemeSelectorWidget >> matcherInteractionEvent: anEvent [
	self scheduleIdleCollapse.
	self fireEvent: anEvent.
	^ self
]

{ #category : 'events' }
CgtThemeSelectorWidget >> matcherNodeHoveredEvent: anEvent [
	^ self matcherInteractionEvent: anEvent
]

{ #category : 'events' }
CgtThemeSelectorWidget >> matcherNodeSelectedEvent: anEvent [
	^ self matcherInteractionEvent: anEvent
]

{ #category : 'events' }
CgtThemeSelectorWidget >> matcherNodeUnhoveredEvent: anEvent [
	self fireEvent: anEvent.
	^ self
]

{ #category : 'event handling' }
CgtThemeSelectorWidget >> matcherClassMatchToggledEvent: anEvent [
	model matcherClassMatchToggledEvent: anEvent.
	self refreshProjectionFromModel.
	self scheduleIdleCollapse.
	self publishSelectorChanged
]

{ #category : 'event handling' }
CgtThemeSelectorWidget >> matcherCombinatorChangedEvent: anEvent [
	model matcherCombinatorChangedEvent: anEvent.
	self refreshProjectionFromModel.
	self scheduleIdleCollapse.
	self publishSelectorChanged
]

{ #category : 'event handling' }
CgtThemeSelectorWidget >> matcherCompactedSectionExpandedEvent: anEvent [
	model matcherCompactedSectionExpandedEvent: anEvent.
	self refreshProjectionFromModel.
	self scheduleIdleCollapse
]

{ #category : 'event handling' }
CgtThemeSelectorWidget >> matcherIdMatchToggledEvent: anEvent [
	model matcherIdMatchToggledEvent: anEvent.
	self refreshProjectionFromModel.
	self scheduleIdleCollapse.
	self publishSelectorChanged
]

{ #category : 'event handling' }
CgtThemeSelectorWidget >> matcherNodeExcludedFromRuleEvent: anEvent [
	model matcherNodeExcludedFromRuleEvent: anEvent.
	self refreshProjectionFromModel.
	self scheduleIdleCollapse.
	self publishSelectorChanged
]

{ #category : 'event handling' }
CgtThemeSelectorWidget >> matcherNodeIncludedInRuleEvent: anEvent [
	model matcherNodeIncludedInRuleEvent: anEvent.
	self refreshProjectionFromModel.
	self scheduleIdleCollapse.
	self publishSelectorChanged
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
CgtThemeSelectorWidget >> pathRootElement [
	^ model pathRootElement
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> pathRootElement: anElement [
	model pathRootElement: anElement.
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
CgtThemeSelectorWidget >> matcherSelectorChangedEvent: anEvent [
	model matcherSelectorChangedEvent: anEvent.
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
	self fireEvent: (CgtMatcherSelectorChangedEvent new
		projection: self projection;
		selector: self currentSelector;
		yourself)
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> visibilityState [
	^ model visibilityState
]

{ #category : 'events' }
CgtThemeSelectorWidget >> collapseTemporaryReveals [
	model collapseTemporaryReveals.
	self refreshProjectionFromModel
]
