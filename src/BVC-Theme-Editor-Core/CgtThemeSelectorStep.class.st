"
#Theme Selector Step
I represent one editable structural step in a theme selector. I am responsible for holding the simple selector for a single level and the combinator that connects me to the next step.
"
Class {
	#name : 'CgtThemeSelectorStep',
	#superclass : 'Object',
	#instVars : [
		'simpleSelector',
		'combinatorToNext'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'instance creation' }
CgtThemeSelectorStep class >> simpleSelector: aCgtThemeSimpleSelector combinatorToNext: aSymbol [
	^ self new
		simpleSelector: aCgtThemeSimpleSelector;
		combinatorToNext: aSymbol;
		yourself
]

{ #category : 'accessing' }
CgtThemeSelectorStep >> simpleSelector [
	^ simpleSelector
]

{ #category : 'accessing' }
CgtThemeSelectorStep >> simpleSelector: aCgtThemeSimpleSelector [
	simpleSelector := aCgtThemeSimpleSelector
]

{ #category : 'accessing' }
CgtThemeSelectorStep >> combinatorToNext [
	^ combinatorToNext
]

{ #category : 'accessing' }
CgtThemeSelectorStep >> combinatorToNext: aSymbol [
	combinatorToNext := aSymbol
]
