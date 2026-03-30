"
#Theme Style Rule
I represent one style rule in the theme system. I am responsible for pairing a selector with the style changes that should apply when that selector matches.
"
Class {
	#name : 'CgtThemeStyleRule',
	#superclass : 'Object',
	#instVars : [
		'selector',
		'styleChanges'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtThemeStyleRule >> initialize [
	super initialize.
	styleChanges := CgtThemeStyleChangeSet new
]

{ #category : 'instance creation' }
CgtThemeStyleRule class >> fromElementPath: aCgtElementPath [
	^ self new
		selector: (CgtThemeSelector selectorFromElementPath: aCgtElementPath);
		yourself
]

{ #category : 'accessing' }
CgtThemeStyleRule >> selector [
	^ selector
]

{ #category : 'accessing' }
CgtThemeStyleRule >> selector: aCgtThemeSelector [
	selector := aCgtThemeSelector
]



{ #category : 'accessing' }
CgtThemeStyleRule >> styleChanges [
	^ styleChanges
]

{ #category : 'accessing' }
CgtThemeStyleRule >> styleChanges: aCgtThemeStyleChangeSet [
	styleChanges := aCgtThemeStyleChangeSet
]
