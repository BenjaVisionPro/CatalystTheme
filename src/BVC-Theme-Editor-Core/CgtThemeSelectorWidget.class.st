"
#Theme Selector Widget
I am a compatibility wrapper for the theme selector editor. I present the rule-driven Mondrian matcher widget interface while accepting selector-editor inputs in live hierarchy context. I no longer inherit the old path-selector matcher implementation.
"
Class {
	#name : 'CgtThemeSelectorWidget',
	#superclass : 'CgtThemeMatcherMondrianWidget',
	#instVars : [
		'styleRule',
		'selectedElement',
		'pathRootElement',
		'relatedStyleRules',
		'visibilityState',
		'idleCollapseDelayMilliseconds',
		'idleCollapseGeneration'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}


{ #category : 'initialization' }
CgtThemeSelectorWidget >> initialize [
	super initialize.
	idleCollapseDelayMilliseconds := 1800.
	idleCollapseGeneration := 0.
	self when: CgtMatcherSelectorChangedEvent do: [ :anEvent |
		self matcherSelectorChangedEvent: anEvent ].
	self when: CgtMatcherCompactedSectionExpandedEvent do: [ :anEvent |
		self matcherInteractionEvent: anEvent ].
	self when: CgtMatcherNodeIncludedInRuleEvent do: [ :anEvent |
		self matcherInteractionEvent: anEvent ].
	self when: CgtMatcherNodeExcludedFromRuleEvent do: [ :anEvent |
		self matcherInteractionEvent: anEvent ].
	self when: CgtMatcherClassMatchToggledEvent do: [ :anEvent |
		self matcherInteractionEvent: anEvent ].
	self when: CgtMatcherIdMatchToggledEvent do: [ :anEvent |
		self matcherInteractionEvent: anEvent ].
	self when: CgtMatcherCombinatorChangedEvent do: [ :anEvent |
		self matcherInteractionEvent: anEvent ].
	self when: CgtMatcherNodeHoveredEvent do: [ :anEvent |
		self matcherInteractionEvent: anEvent ].
	self when: CgtMatcherNodeSelectedEvent do: [ :anEvent |
		self matcherInteractionEvent: anEvent ]
]



{ #category : 'accessing' }
CgtThemeSelectorWidget >> configureForStyleRule: aCgtThemeStyleRule selectedElement: anElement pathRootElement: aRootElement relatedStyleRules: aCollection [
	styleRule := aCgtThemeStyleRule.
	selectedElement := anElement.
	pathRootElement := aRootElement.
	relatedStyleRules := (aCollection ifNil: [ #() ]) asOrderedCollection.
	visibilityState ifNil: [ visibilityState := CgtMatcherVisibilityState new ].
	self refreshProjection.
	^ self
]


{ #category : 'events' }
CgtThemeSelectorWidget >> matcherInteractionEvent: anEvent [
	self scheduleIdleCollapse.
	^ self
]

{ #category : 'private - idle collapse' }
CgtThemeSelectorWidget >> noteMatcherInteraction [
	idleCollapseGeneration := idleCollapseGeneration + 1.
	^ idleCollapseGeneration
]

{ #category : 'private - idle collapse' }
CgtThemeSelectorWidget >> scheduleIdleCollapse [
	| token |
	(self visibilityState hasExpandedGaps not) ifTrue: [ ^ self ].
	token := self noteMatcherInteraction.
	[ 
		(Delay forMilliseconds: idleCollapseDelayMilliseconds) wait.
		(token = idleCollapseGeneration and: [ self visibilityState hasExpandedGaps ]) ifTrue: [
			self collapseTemporaryReveals ] ] forkAt: Processor userBackgroundPriority.
	^ self
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> idleCollapseDelayMilliseconds [
	^ idleCollapseDelayMilliseconds
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> idleCollapseDelayMilliseconds: anInteger [
	idleCollapseDelayMilliseconds := anInteger.
	^ self
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> styleRule [
	^ styleRule
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> styleRule: aCgtThemeStyleRule [
	styleRule := aCgtThemeStyleRule.
	self refreshProjection.
	^ self
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> selectedElement [
	^ selectedElement
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> selectedElement: anElement [
	selectedElement := anElement.
	self refreshProjection.
	^ self
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> pathRootElement [
	^ pathRootElement
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> pathRootElement: anElement [
	pathRootElement := anElement.
	self refreshProjection.
	^ self
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> relatedStyleRules [
	^ relatedStyleRules ifNil: [ #() ]
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> relatedStyleRules: aCollection [
	relatedStyleRules := (aCollection ifNil: [ #() ]) asOrderedCollection.
	visibilityState ifNil: [ visibilityState := CgtMatcherVisibilityState new ].
	self refreshProjection.
	^ self
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> selector [
	^ styleRule ifNil: [ nil ] ifNotNil: [ styleRule selector ]
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> currentStyleRule [
	^ styleRule
]

{ #category : 'event handling' }
CgtThemeSelectorWidget >> matcherSelectorChangedEvent: anEvent [
	styleRule ifNil: [ styleRule := CgtThemeStyleRule new ].
	styleRule selector: anEvent selector.
	self refreshProjection
]


{ #category : 'private - projection' }
CgtThemeSelectorWidget >> refreshProjection [
	(styleRule isNil or: [ selectedElement isNil ]) ifTrue: [
		self projection: nil.
		^ self ].
	visibilityState ifNil: [ visibilityState := CgtMatcherVisibilityState new ].
	self projection: (CgtMatcherProjectionBuilder
		projectionForStyleRule: styleRule
		selectedElement: selectedElement
		hierarchyRoot: pathRootElement
		relatedStyleRules: self relatedStyleRules
		visibilityState: visibilityState)
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> visibilityState [
	^ visibilityState ifNil: [ visibilityState := CgtMatcherVisibilityState new ]
]

{ #category : 'events' }
CgtThemeSelectorWidget >> collapseTemporaryReveals [
	self visibilityState clearExpandedGaps.
	idleCollapseGeneration := idleCollapseGeneration + 1.
	self refreshProjection
]
