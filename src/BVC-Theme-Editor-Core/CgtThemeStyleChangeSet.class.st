"
#Theme Style Change Set
I group style changes that belong to one style rule. I am responsible for holding the set of changes that should be applied together.
"
Class {
	#name : 'CgtThemeStyleChangeSet',
	#superclass : 'Object',
	#instVars : [
		'changes'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtThemeStyleChangeSet >> initialize [
	super initialize.
	changes := OrderedCollection new
]

{ #category : 'accessing' }
CgtThemeStyleChangeSet >> changes [
	^ changes copy
]

{ #category : 'accessing' }
CgtThemeStyleChangeSet >> changes: aCollection [
	changes := aCollection asOrderedCollection
]

{ #category : 'actions' }
CgtThemeStyleChangeSet >> addChange: aCgtThemeStyleChange [
	changes add: aCgtThemeStyleChange
]
