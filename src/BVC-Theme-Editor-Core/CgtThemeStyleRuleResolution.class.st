"
#Theme Style Rule Resolution
I represent the resolved editing target for a style-inspector session. I carry the active style rule, the related style rules around it, and whether the active rule was bootstrapped instead of resolved from the theme.
"
Class {
	#name : 'CgtThemeStyleRuleResolution',
	#superclass : 'Object',
	#instVars : [
		'activeStyleRule',
		'relatedStyleRules',
		'wasBootstrapped'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtThemeStyleRuleResolution >> activeStyleRule [
	^ activeStyleRule
]

{ #category : 'accessing' }
CgtThemeStyleRuleResolution >> activeStyleRule: aCgtThemeStyleRule [
	activeStyleRule := aCgtThemeStyleRule.
	^ self
]

{ #category : 'accessing' }
CgtThemeStyleRuleResolution >> relatedStyleRules [
	^ relatedStyleRules ifNil: [ #() ]
]

{ #category : 'accessing' }
CgtThemeStyleRuleResolution >> relatedStyleRules: aCollection [
	relatedStyleRules := (aCollection ifNil: [ #() ]) asOrderedCollection.
	^ self
]

{ #category : 'testing' }
CgtThemeStyleRuleResolution >> wasBootstrapped [
	^ wasBootstrapped = true
]

{ #category : 'accessing' }
CgtThemeStyleRuleResolution >> wasBootstrapped: aBoolean [
	wasBootstrapped := aBoolean = true.
	^ self
]
