Class {
	#name : #CgtSeparatorSubTheme,
	#superclass : #BlSubTheme,
	#instVars : [ 'color' ],
	#category : #'BVC-Theme-GT'
}

{ #category : #initialization }
CgtSeparatorSubTheme >> initializeThemeable [
	color := self color: [ :aTheme | self contrastTintColorFor: aTheme alpha: 19.0 / 248.0 ] source: [ :aTheme | aTheme separator color ]
]

{ #category : #private }
CgtSeparatorSubTheme >> contrastTintColorFor: aTheme alpha: anAlpha [
	| aBackground aLuminance |
	aBackground := aTheme default contentBackground blocResolveColorForTheme: aTheme.
	aLuminance := (aBackground red * 0.2126) + (aBackground green * 0.7152) + (aBackground blue * 0.0722).
	^ (aLuminance < 0.5 ifTrue: [ Color white ] ifFalse: [ Color black ]) alpha: anAlpha
]

{ #category : #accessing }
CgtSeparatorSubTheme >> color [ ^ color ]
