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
		'relatedStyleRules'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

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
	self refreshProjection.
	^ self
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> selector [
	^ styleRule ifNil: [ nil ] ifNotNil: [ styleRule selector ]
]

{ #category : 'private - projection' }
CgtThemeSelectorWidget >> refreshProjection [
	(styleRule isNil or: [ selectedElement isNil ]) ifTrue: [
		self projection: nil.
		^ self ].
	self projection: (CgtMatcherProjectionBuilder
		projectionForStyleRule: styleRule
		selectedElement: selectedElement
		hierarchyRoot: pathRootElement
		relatedStyleRules: self relatedStyleRules)
]
