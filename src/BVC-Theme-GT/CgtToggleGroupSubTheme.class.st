Class {
	#name : #CgtToggleGroupSubTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'borderColor'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtToggleGroupSubTheme >> borderColor [
	^ borderColor
]

{ #category : #accessing }
CgtToggleGroupSubTheme >> cornerRadius [
	^ 3
]

{ #category : #initialization }
CgtToggleGroupSubTheme >> initializeThemeable [
	borderColor := self
		color: [ :aTheme | self contrastTintColorFor: aTheme alpha: 0.12 ]
		source: [ :aTheme | aTheme toggleGroup borderColor ]
]

{ #category : #private }
CgtToggleGroupSubTheme >> contrastTintColorFor: aTheme alpha: anAlpha [
	| aBackground aLuminance |
	aBackground := aTheme default contentBackground blocResolveColorForTheme: aTheme.
	aLuminance := (aBackground red * 0.2126)
		+ (aBackground green * 0.7152)
		+ (aBackground blue * 0.0722).
	^ (aLuminance < 0.5 ifTrue: [ Color white ] ifFalse: [ Color black ]) alpha: anAlpha
]
