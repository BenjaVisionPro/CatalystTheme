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
		'selectorModel'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtThemeStyleInspectorModel >> initialize [
	super initialize.
	themeStyleRules := OrderedCollection new.
	relatedStyleRules := OrderedCollection new.
	selectorModel := CgtThemeSelectorModel new
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
	selectorModel
		configureForStyleRule: activeStyleRule
		selectedElement: selectedElement
		hierarchyRoot: hierarchyRoot
		relatedStyleRules: self relatedStyleRules.
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
	self refreshSelectorModel.
	^ self
]

{ #category : 'accessing' }
CgtThemeStyleInspectorModel >> selectedScopePath [
	^ selectedScopePath
]

{ #category : 'accessing' }
CgtThemeStyleInspectorModel >> selectedScopePath: aCgtElementPath [
	selectedScopePath := aCgtElementPath.
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
CgtThemeStyleInspectorModel >> themeStyleRules [
	^ themeStyleRules ifNil: [ #() ]
]

{ #category : 'accessing' }
CgtThemeStyleInspectorModel >> themeStyleRules: aCollection [
	themeStyleRules := (aCollection ifNil: [ #() ]) asOrderedCollection.
	relatedStyleRules := themeStyleRules reject: [ :each | each == activeStyleRule ].
	self refreshSelectorModel.
	^ self
]
