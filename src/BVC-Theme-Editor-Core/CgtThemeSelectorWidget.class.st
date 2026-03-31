"
#Theme Selector Widget
I am the host widget for the theme selector editor. I own a non-visual CgtThemeSelectorModel and one pluggable selector renderer widget. I coordinate selector editing semantics through the model while keeping rendering technology replaceable.
"
Class {
	#name : 'CgtThemeSelectorWidget',
	#superclass : 'BrVerticalPane',
	#instVars : [
		'selectorModel',
		'selectorRendererWidget',
		'selectorRendererWidgetClass'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtThemeSelectorWidget >> initialize [
	super initialize.
	selectorModel := CgtThemeSelectorModel new.
	selectorRendererWidgetClass := CgtThemeSelectorMondrianWidget.
	self
		vFitContent;
		hMatchParent.
	self installSelectorRendererWidget
]

{ #category : 'initialization' }
CgtThemeSelectorWidget >> buildSelectorRendererWidget [
	(selectorRendererWidgetClass inheritsFrom: CgtThemeSelectorRendererWidget) ifFalse: [
		self error: 'Selector renderer widgets must subclass CgtThemeSelectorRendererWidget' ].
	^ selectorRendererWidgetClass new
]

{ #category : 'initialization' }
CgtThemeSelectorWidget >> installSelectorRendererWidget [
	selectorRendererWidget ifNotNil: [ self removeChild: selectorRendererWidget ].
	selectorRendererWidget := self buildSelectorRendererWidget.
	self addChild: selectorRendererWidget.
	self wireSelectorRendererWidget.
	self refreshSelectorProjectionFromModel.
	^ self
]

{ #category : 'initialization' }
CgtThemeSelectorWidget >> wireSelectorRendererWidget [
	selectorRendererWidget when: CgtThemeSelectorCompactedSectionExpandedEvent do: [ :anEvent |
		self selectorCompactedSectionExpandedEvent: anEvent ].
	selectorRendererWidget when: CgtThemeSelectorNodeIncludedInRuleEvent do: [ :anEvent |
		self selectorNodeIncludedInRuleEvent: anEvent ].
	selectorRendererWidget when: CgtThemeSelectorNodeExcludedFromRuleEvent do: [ :anEvent |
		self selectorNodeExcludedFromRuleEvent: anEvent ].
	selectorRendererWidget when: CgtThemeSelectorClassMatchChangedEvent do: [ :anEvent |
		self selectorClassMatchChangedEvent: anEvent ].
	selectorRendererWidget when: CgtThemeSelectorIdMatchChangedEvent do: [ :anEvent |
		self selectorIdMatchChangedEvent: anEvent ].
	selectorRendererWidget when: CgtThemeSelectorCombinatorChangedEvent do: [ :anEvent |
		self selectorCombinatorChangedEvent: anEvent ].
	selectorRendererWidget when: CgtThemeSelectorNodeHoveredEvent do: [ :anEvent |
		self selectorNodeHoveredEvent: anEvent ].
	selectorRendererWidget when: CgtThemeSelectorNodeSelectedEvent do: [ :anEvent |
		self selectorNodeSelectedEvent: anEvent ].
	selectorRendererWidget when: CgtThemeSelectorNodeUnhoveredEvent do: [ :anEvent |
		self selectorNodeUnhoveredEvent: anEvent ].
	selectorRendererWidget when: CgtThemeSelectorOtherRuleContextToggledEvent do: [ :anEvent |
		self selectorOtherRuleContextToggledEvent: anEvent ]
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> configureForStyleRule: aCgtThemeStyleRule selectedElement: anElement hierarchyRoot: aRootElement relatedStyleRules: aCollection [
	selectorModel
		configureForStyleRule: aCgtThemeStyleRule
		selectedElement: anElement
		hierarchyRoot: aRootElement
		relatedStyleRules: aCollection.
	self refreshSelectorProjectionFromModel.
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
	selectorModel applyClassMatch: anEvent shouldMatch toProjectionNode: anEvent projectionNode.
	self refreshSelectorProjectionFromModelAndPublishSelectorChanged.
	self scheduleIdleCollapse
]

{ #category : 'event handling' }
CgtThemeSelectorWidget >> selectorCombinatorChangedEvent: anEvent [
	selectorModel applyCombinator: anEvent combinator toRelation: anEvent relation.
	self refreshSelectorProjectionFromModelAndPublishSelectorChanged.
	self scheduleIdleCollapse
]

{ #category : 'event handling' }
CgtThemeSelectorWidget >> selectorCompactedSectionExpandedEvent: anEvent [
	selectorModel revealCompactedProjectionNode: anEvent projectionNode.
	self refreshSelectorProjectionFromModel.
	self scheduleIdleCollapse
]

{ #category : 'event handling' }
CgtThemeSelectorWidget >> selectorIdMatchChangedEvent: anEvent [
	selectorModel applyIdMatch: anEvent shouldMatch toProjectionNode: anEvent projectionNode.
	self refreshSelectorProjectionFromModelAndPublishSelectorChanged.
	self scheduleIdleCollapse
]

{ #category : 'event handling' }
CgtThemeSelectorWidget >> selectorNodeExcludedFromRuleEvent: anEvent [
	selectorModel excludeProjectionNode: anEvent projectionNode.
	self refreshSelectorProjectionFromModelAndPublishSelectorChanged.
	self scheduleIdleCollapse
]

{ #category : 'event handling' }
CgtThemeSelectorWidget >> selectorNodeIncludedInRuleEvent: anEvent [
	selectorModel includeProjectionNode: anEvent projectionNode.
	self refreshSelectorProjectionFromModelAndPublishSelectorChanged.
	self scheduleIdleCollapse
]

{ #category : 'event handling' }
CgtThemeSelectorWidget >> selectorOtherRuleContextToggledEvent: anEvent [
	selectorModel toggleOtherRuleContext.
	self refreshSelectorProjectionFromModel.
	self scheduleIdleCollapse.
	^ self
]

{ #category : 'private - idle collapse' }
CgtThemeSelectorWidget >> noteSelectorInteraction [
	^ selectorModel noteSelectorInteraction
]

{ #category : 'private - idle collapse' }
CgtThemeSelectorWidget >> scheduleIdleCollapse [
	selectorModel scheduleIdleCollapseAfter: [ self collapseTemporaryReveals ].
	^ self
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> idleCollapseDelayMilliseconds [
	^ selectorModel idleCollapseDelayMilliseconds
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> idleCollapseDelayMilliseconds: anInteger [
	selectorModel idleCollapseDelayMilliseconds: anInteger.
	^ self
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> styleRule [
	^ selectorModel currentStyleRule
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> styleRule: aCgtThemeStyleRule [
	selectorModel styleRule: aCgtThemeStyleRule.
	self refreshSelectorProjectionFromModel.
	^ self
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> selectedElement [
	^ selectorModel selectedElement
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> selectedElement: anElement [
	selectorModel selectedElement: anElement.
	self refreshSelectorProjectionFromModel.
	^ self
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> hierarchyRoot [
	^ selectorModel hierarchyRoot
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> hierarchyRoot: anElement [
	selectorModel hierarchyRoot: anElement.
	self refreshSelectorProjectionFromModel.
	^ self
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> relatedStyleRules [
	^ selectorModel relatedStyleRules
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> relatedStyleRules: aCollection [
	selectorModel relatedStyleRules: aCollection.
	self refreshSelectorProjectionFromModel.
	^ self
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> selector [
	^ selectorModel selector
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> currentSelector [
	^ selectorModel selector
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> currentStyleRule [
	^ selectorModel currentStyleRule
]

{ #category : 'event handling' }
CgtThemeSelectorWidget >> selectorChangedEvent: anEvent [
	selectorModel selector: anEvent selector.
	self refreshSelectorProjectionFromModel
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> selectorModel [
	^ selectorModel
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> selectorRendererWidget [
	^ selectorRendererWidget
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> selectorRendererWidgetClass [
	^ selectorRendererWidgetClass ifNil: [ CgtThemeSelectorMondrianWidget ]
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> selectorRendererWidgetClass: aClass [
	selectorRendererWidgetClass := aClass ifNil: [ CgtThemeSelectorMondrianWidget ].
	self installSelectorRendererWidget.
	^ self
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> projection [
	^ selectorModel projection
]

{ #category : 'private - projection' }
CgtThemeSelectorWidget >> refreshSelectorProjection [
	self refreshSelectorProjectionFromModel
]

{ #category : 'private - projection' }
CgtThemeSelectorWidget >> refreshSelectorProjectionFromModel [
	selectorRendererWidget projection: selectorModel projection.
	^ self
]

{ #category : 'private - projection' }
CgtThemeSelectorWidget >> refreshSelectorProjectionFromModelAndPublishSelectorChanged [
	self refreshSelectorProjectionFromModel.
	self publishSelectorChanged.
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
	^ selectorModel visibilityState
]

{ #category : 'editing' }
CgtThemeSelectorWidget >> showOtherRuleContext [
	selectorModel showOtherRuleContext.
	self refreshSelectorProjectionFromModel.
	^ self
]

{ #category : 'editing' }
CgtThemeSelectorWidget >> hideOtherRuleContext [
	selectorModel hideOtherRuleContext.
	self refreshSelectorProjectionFromModel.
	^ self
]

{ #category : 'editing' }
CgtThemeSelectorWidget >> toggleOtherRuleContext [
	selectorModel toggleOtherRuleContext.
	self refreshSelectorProjectionFromModel.
	^ self
]

{ #category : 'events' }
CgtThemeSelectorWidget >> collapseTemporaryReveals [
	selectorModel collapseTemporaryReveals.
	self refreshSelectorProjectionFromModel
]
