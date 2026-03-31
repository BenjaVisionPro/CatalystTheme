"
#Theme Selector Widget
I am the current host widget for the theme selector editor. I still render through the Mondrian matcher widget superclass, but my non-visual selector state now lives in a dedicated CgtThemeSelectorModel.
"
Class {
	#name : 'CgtThemeSelectorWidget',
	#superclass : 'CgtThemeMatcherMondrianWidget',
	#instVars : [
		'model'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}


{ #category : 'initialization' }
CgtThemeSelectorWidget >> initialize [
	super initialize.
	model := CgtThemeSelectorModel new.
	self when: CgtMatcherCompactedSectionExpandedEvent do: [ :anEvent |
		self matcherCompactedSectionExpandedEvent: anEvent ].
	self when: CgtMatcherNodeIncludedInRuleEvent do: [ :anEvent |
		self matcherNodeIncludedInRuleEvent: anEvent ].
	self when: CgtMatcherNodeExcludedFromRuleEvent do: [ :anEvent |
		self matcherNodeExcludedFromRuleEvent: anEvent ].
	self when: CgtMatcherClassMatchToggledEvent do: [ :anEvent |
		self matcherClassMatchToggledEvent: anEvent ].
	self when: CgtMatcherIdMatchToggledEvent do: [ :anEvent |
		self matcherIdMatchToggledEvent: anEvent ].
	self when: CgtMatcherCombinatorChangedEvent do: [ :anEvent |
		self matcherCombinatorChangedEvent: anEvent ].
	self when: CgtMatcherNodeHoveredEvent do: [ :anEvent |
		self matcherInteractionEvent: anEvent ].
	self when: CgtMatcherNodeSelectedEvent do: [ :anEvent |
		self matcherInteractionEvent: anEvent ]
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
CgtThemeSelectorWidget >> currentStyleRule [
	^ model currentStyleRule
]

{ #category : 'event handling' }
CgtThemeSelectorWidget >> matcherSelectorChangedEvent: anEvent [
	model matcherSelectorChangedEvent: anEvent.
	self refreshProjectionFromModel
]


{ #category : 'accessing' }
CgtThemeSelectorWidget >> model [
	^ model
]

{ #category : 'private - projection' }
CgtThemeSelectorWidget >> refreshProjection [
	self refreshProjectionFromModel
]

{ #category : 'private - projection' }
CgtThemeSelectorWidget >> refreshProjectionFromModel [
	self projection: model projection.
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
