Class {
	#name : #CgtGlamorousSeparatorSubTheme,
	#superclass : #BlSubTheme,
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtGlamorousSeparatorSubTheme >> color [
	^ self contrastTintColorWithAlpha: 19.0 / 248.0
]

{ #category : #private }
CgtGlamorousSeparatorSubTheme >> contrastTintColorWithAlpha: anAlpha [
	| aBackground aLuminance |
	aBackground := self theme default contentBackground blocResolveColorForTheme: self theme.
	aLuminance := (aBackground red * 0.2126) + (aBackground green * 0.7152) + (aBackground blue * 0.0722).
	^ (aLuminance < 0.5 ifTrue: [ Color white ] ifFalse: [ Color black ]) alpha: anAlpha
]
