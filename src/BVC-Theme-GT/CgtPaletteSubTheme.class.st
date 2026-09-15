Class {
	#name : #CgtPaletteSubTheme,
	#superclass : #BlSubTheme,
	#instVars : [ 'background' ],
	#category : #'BVC-Theme-GT'
}

{ #category : #initialization }
CgtPaletteSubTheme >> initializeThemeable [
	background := self color: [ :aTheme | self contrastColorFor: aTheme alpha: 0.06 ] source: [ :aTheme | aTheme palette background ]
]

{ #category : #private }
CgtPaletteSubTheme >> contrastColorFor: aTheme alpha: anAlpha [
	| aBackground aLuminance |
	aBackground := aTheme default contentBackground blocResolveColorForTheme: aTheme.
	aLuminance := (aBackground red * 0.2126) + (aBackground green * 0.7152) + (aBackground blue * 0.0722).
	^ (aLuminance < 0.5 ifTrue: [ Color white ] ifFalse: [ Color black ]) alpha: anAlpha
]

{ #category : #accessing }
CgtPaletteSubTheme >> background [ ^ background ]
