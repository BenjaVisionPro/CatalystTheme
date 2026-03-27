Class {
	#name : 'CgtThemeSimpleSelector',
	#superclass : 'CgtThemeSelector',
	#instVars : [
		'predicates'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtThemeSimpleSelector >> initialize [
	super initialize.
	predicates := OrderedCollection new
]

{ #category : 'instance creation' }
CgtThemeSimpleSelector class >> defaultForElement: anElement [
	| selector |
	selector := self new.
	(anElement id = BlElementId noId)
		ifTrue: [ selector addPredicate: (CgtThemeClassPredicate elementClass: anElement class) ]
		ifFalse: [ selector addPredicate: (CgtThemeIdPredicate elementId: anElement id) ].
	^ selector
]

{ #category : 'accessing' }
CgtThemeSimpleSelector >> predicates [
	^ predicates copy
]

{ #category : 'accessing' }
CgtThemeSimpleSelector >> predicates: aCollection [
	predicates := aCollection asOrderedCollection
]

{ #category : 'accessing' }
CgtThemeSimpleSelector >> addPredicate: aCgtThemeSelectorPredicate [
	predicates add: aCgtThemeSelectorPredicate
]

{ #category : 'testing' }
CgtThemeSimpleSelector >> matchesElement: anElement [
	^ predicates allSatisfy: [ :each | each matchesElement: anElement ]
]
