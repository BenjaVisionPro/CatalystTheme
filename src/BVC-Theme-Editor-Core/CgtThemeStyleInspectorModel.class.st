"
#Theme Style Inspector Model
I am the semantic owner for a style-inspector editing session. I hold the selected live element, hierarchy root, selected scope path, active style rule, related style rules, and the selector model used to edit the active rule. I coordinate selector-model configuration, but I do not render UI or handle raw preview input.
"
Class {
	#name : 'CgtThemeStyleInspectorModel',
	#superclass : 'Object',
	#instVars : [
		'themeStyleRules',
		'selectedElement',
		'hierarchyRoot',
		'selectedScopePath',
		'activeStyleRule',
		'relatedStyleRules',
		'selectorModel',
		'styleRuleResolver'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtThemeStyleInspectorModel >> initialize [
	super initialize.
	themeStyleRules := OrderedCollection new.
	relatedStyleRules := OrderedCollection new.
	selectorModel := CgtThemeSelectorModel new.
	styleRuleResolver := CgtThemeStyleRuleResolver new
]

{ #category : 'accessing' }
CgtThemeStyleInspectorModel >> activeStyleRule [
	^ activeStyleRule
]

{ #category : 'accessing' }
CgtThemeStyleInspectorModel >> activeStyleRule: aCgtThemeStyleRule [
	activeStyleRule := aCgtThemeStyleRule.
	self rebuildThemeStyleRules.
	self refreshSelectorModel.
	^ self
]

{ #category : 'accessing' }
CgtThemeStyleInspectorModel >> configureForStyleRule: aCgtThemeStyleRule selectedElement: anElement hierarchyRoot: aRootElement relatedStyleRules: aCollection [
	activeStyleRule := aCgtThemeStyleRule.
	selectedElement := anElement.
	hierarchyRoot := aRootElement.
	relatedStyleRules := (aCollection ifNil: [ #() ]) asOrderedCollection.
	selectedScopePath := anElement ifNil: [ nil ] ifNotNil: [ CgtElementPath anchorElement: anElement ].
	themeStyleRules := OrderedCollection new.
	activeStyleRule ifNotNil: [ themeStyleRules add: activeStyleRule ].
	relatedStyleRules do: [ :each |
		(each notNil and: [ (themeStyleRules includes: each) not ]) ifTrue: [ themeStyleRules add: each ] ].
	self refreshSelectorModel.
	^ self
]

{ #category : 'accessing' }
CgtThemeStyleInspectorModel >> hierarchyRoot [
	^ hierarchyRoot
]

{ #category : 'accessing' }
CgtThemeStyleInspectorModel >> hierarchyRoot: anElement [
	hierarchyRoot := anElement.
	self resolveActiveStyleRule.
	self refreshSelectorModel.
	^ self
]

{ #category : 'accessing' }
CgtThemeStyleInspectorModel >> relatedStyleRules [
	^ relatedStyleRules ifNil: [ #() ]
]

{ #category : 'accessing' }
CgtThemeStyleInspectorModel >> relatedStyleRules: aCollection [
	relatedStyleRules := (aCollection ifNil: [ #() ]) asOrderedCollection.
	self rebuildThemeStyleRules.
	self refreshSelectorModel.
	^ self
]

{ #category : 'private' }
CgtThemeStyleInspectorModel >> rebuildThemeStyleRules [
	themeStyleRules := OrderedCollection new.
	activeStyleRule ifNotNil: [ themeStyleRules add: activeStyleRule ].
	self relatedStyleRules do: [ :each |
		(each notNil and: [ (themeStyleRules includes: each) not ]) ifTrue: [ themeStyleRules add: each ] ].
	^ self
]

{ #category : 'private' }
CgtThemeStyleInspectorModel >> refreshSelectorModel [
	selectorModel configureForStyleInspectorModel: self.
	^ self
]

{ #category : 'accessing' }
CgtThemeStyleInspectorModel >> selectedElement [
	^ selectedElement
]

{ #category : 'accessing' }
CgtThemeStyleInspectorModel >> selectedElement: anElement [
	selectedElement := anElement.
	selectedScopePath := anElement ifNil: [ nil ] ifNotNil: [ CgtElementPath anchorElement: anElement ].
	self resolveActiveStyleRule.
	self refreshSelectorModel.
	^ self
]

{ #category : 'accessing' }
CgtThemeStyleInspectorModel >> selectedScopePath [
	^ selectedScopePath
]

{ #category : 'accessing' }
CgtThemeStyleInspectorModel >> selectedScopePath: aCgtElementPath [
	selectedScopePath := aCgtElementPath ifNil: [ selectedElement ifNil: [ nil ] ifNotNil: [ CgtElementPath anchorElement: selectedElement ] ].
	self resolveActiveStyleRule.
	self refreshSelectorModel.
	^ self
]

{ #category : 'accessing' }
CgtThemeStyleInspectorModel >> selectorModel [
	^ selectorModel
]

{ #category : 'accessing' }
CgtThemeStyleInspectorModel >> selectorModel: aCgtThemeSelectorModel [
	selectorModel := aCgtThemeSelectorModel ifNil: [ CgtThemeSelectorModel new ].
	self refreshSelectorModel.
	^ self
]


{ #category : 'accessing' }
CgtThemeStyleInspectorModel >> styleRuleResolver [
	^ styleRuleResolver ifNil: [ styleRuleResolver := CgtThemeStyleRuleResolver new ]
]

{ #category : 'accessing' }
CgtThemeStyleInspectorModel >> styleRuleResolver: aCgtThemeStyleRuleResolver [
	styleRuleResolver := aCgtThemeStyleRuleResolver ifNil: [ CgtThemeStyleRuleResolver new ].
	self resolveActiveStyleRule.
	^ self
]

{ #category : 'accessing' }
CgtThemeStyleInspectorModel >> configureForSelectedElement: anElement hierarchyRoot: aRootElement selectedScopePath: aCgtElementPath themeStyleRules: aCollection [
	selectedElement := anElement.
	hierarchyRoot := aRootElement.
	selectedScopePath := aCgtElementPath ifNil: [ anElement ifNil: [ nil ] ifNotNil: [ CgtElementPath anchorElement: anElement ] ].
	themeStyleRules := (aCollection ifNil: [ #() ]) asOrderedCollection.
	self resolveActiveStyleRule.
	self refreshSelectorModel.
	^ self
]

{ #category : 'private' }
CgtThemeStyleInspectorModel >> resolveActiveStyleRule [
	| resolution |
	resolution := self styleRuleResolver
		resolutionForSelectedElement: selectedElement
		scopePath: selectedScopePath
		withinStyleRules: self themeStyleRules
		hierarchyRoot: hierarchyRoot.
	activeStyleRule := resolution activeStyleRule.
	relatedStyleRules := resolution relatedStyleRules asOrderedCollection.
	(activeStyleRule notNil and: [ (themeStyleRules includes: activeStyleRule) not ]) ifTrue: [
		themeStyleRules := self themeStyleRules asOrderedCollection.
		themeStyleRules addFirst: activeStyleRule ].
	^ self
]

{ #category : 'accessing' }
CgtThemeStyleInspectorModel >> themeStyleRules [
	^ themeStyleRules ifNil: [ #() ]
]

{ #category : 'accessing' }
CgtThemeStyleInspectorModel >> themeStyleRules: aCollection [
	themeStyleRules := (aCollection ifNil: [ #() ]) asOrderedCollection.
	self resolveActiveStyleRule.
	self refreshSelectorModel.
	^ self
]
