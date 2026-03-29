Class {
	#name : 'CgtElementPathSelectorSelectedEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'selectedSimpleSelector'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtElementPathSelectorSelectedEvent >> selectedSimpleSelector [
	^ selectedSimpleSelector
]

{ #category : 'accessing' }
CgtElementPathSelectorSelectedEvent >> selectedSimpleSelector: aCgtThemeSimpleSelector [
	selectedSimpleSelector := aCgtThemeSimpleSelector
]
