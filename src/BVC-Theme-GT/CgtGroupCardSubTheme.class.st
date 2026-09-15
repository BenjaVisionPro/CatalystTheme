Class {
	#name : #CgtGroupCardSubTheme,
	#superclass : #BlSubTheme,
	#instVars : [ 'background' ],
	#category : #'BVC-Theme-GT'
}

{ #category : #initialization }
CgtGroupCardSubTheme >> initializeThemeable [
	background := self color: [ :aTheme | self contrastTintColorFor: aTheme alpha: 7.0 / 255.0 ] source: [ :aTheme | aTheme groupCard background ]
]

{ #category : #private }
CgtGroupCardSubTheme >> contrastTintColorFor: aTheme alpha: anAlpha [
	| aBackground aLuminance |
	aBackground := aTheme default contentBackground blocResolveColorForTheme: aTheme.
	aLuminance := (aBackground red * 0.2126) + (aBackground green * 0.7152) + (aBackground blue * 0.0722).
	^ (aLuminance < 0.5 ifTrue: [ Color white ] ifFalse: [ Color black ]) alpha: anAlpha
]

{ #category : #accessing }
CgtGroupCardSubTheme >> background [ ^ background ]
