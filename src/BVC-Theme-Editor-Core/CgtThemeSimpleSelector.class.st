"
#Theme Simple Selector
I represent one simple selector in the theme selector model. I am responsible for the predicates that must all match at a single structural step.
"
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

{ #category : 'printing' }
CgtThemeSimpleSelector >> displayString [
	^ String streamContents: [ :aStream |
		predicates doWithIndex: [ :each :anIndex |
			anIndex > 1 ifTrue: [ aStream nextPutAll: '' ].
			aStream nextPutAll: each displayString ] ]
]
