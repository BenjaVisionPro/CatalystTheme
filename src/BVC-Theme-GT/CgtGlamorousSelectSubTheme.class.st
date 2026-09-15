Class {
	#name : #CgtGlamorousSelectSubTheme,
	#superclass : #BlSubTheme,
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtGlamorousSelectSubTheme >> hoveredBackground [
	^ self contrastTintColorWithAlpha: 0.10
]

{ #category : #accessing }
CgtGlamorousSelectSubTheme >> optionHoveredBackground [
	^ self contrastTintColorWithAlpha: 0.08
]

{ #category : #accessing }
CgtGlamorousSelectSubTheme >> selectedForeground [
	^ Color white
]

{ #category : #accessing }
CgtGlamorousSelectSubTheme >> indicatorForeground [
	^ self contrastTintColorWithAlpha: 0.72
]

{ #category : #private }
CgtGlamorousSelectSubTheme >> contrastTintColorWithAlpha: anAlpha [
	| aBackground aLuminance |
	aBackground := self theme default contentBackground blocResolveColorForTheme: self theme.
	aLuminance := (aBackground red * 0.2126) + (aBackground green * 0.7152) + (aBackground blue * 0.0722).
	^ (aLuminance < 0.5 ifTrue: [ Color white ] ifFalse: [ Color black ]) alpha: anAlpha
]
