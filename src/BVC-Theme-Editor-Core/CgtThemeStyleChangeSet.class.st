Class {
	#name : 'CgtThemeStyleChangeSet',
	#superclass : 'Object',
	#instVars : [
		'changes'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
	#comment : 'I am responsible for grouping the style changes that belong to a theme rule. I keep related changes together as one coherent set that can be edited, inspected, and applied as a unit.'
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
