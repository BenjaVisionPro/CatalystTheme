Class {
	#name : 'CgtThemeStyleRule',
	#superclass : 'Object',
	#instVars : [
		'selector',
		'styleChanges'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
	#comment : 'I am responsible for representing one complete theme style rule. I combine selector matching with the set of style changes that should apply when that selector matches.'
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
