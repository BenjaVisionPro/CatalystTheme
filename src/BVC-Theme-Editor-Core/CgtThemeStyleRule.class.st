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
