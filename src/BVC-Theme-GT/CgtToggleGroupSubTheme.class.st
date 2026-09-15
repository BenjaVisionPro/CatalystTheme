Class {
	#name : #CgtToggleGroupSubTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'borderColor',
		'background',
		'hoveredBackground',
		'inactiveForeground',
		'activeForeground'
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
		source: [ :aTheme | aTheme toggleGroup borderColor ].
	background := self color: [ :aTheme | self contrastTintColorFor: aTheme alpha: 0.08 ] source: [ :aTheme | aTheme toggleGroup background ].
	hoveredBackground := self color: [ :aTheme | self contrastTintColorFor: aTheme alpha: 0.06 ] source: [ :aTheme | aTheme toggleGroup hoveredBackground ].
	inactiveForeground := self color: [ :aTheme | self contrastTintColorFor: aTheme alpha: 0.68 ] source: [ :aTheme | aTheme toggleGroup inactiveForeground ].
	activeForeground := self color: [ :aTheme | Color white ] source: [ :aTheme | aTheme toggleGroup activeForeground ]
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


{ #category : #accessing }
CgtToggleGroupSubTheme >> background [ ^ background ]
{ #category : #accessing }
CgtToggleGroupSubTheme >> hoveredBackground [ ^ hoveredBackground ]
{ #category : #accessing }
CgtToggleGroupSubTheme >> inactiveForeground [ ^ inactiveForeground ]
{ #category : #accessing }
CgtToggleGroupSubTheme >> activeForeground [ ^ activeForeground ]
