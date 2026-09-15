Class {
	#name : #CgtSelectSubTheme,
	#superclass : #BlSubTheme,
	#instVars : [ 'hoveredBackground', 'optionHoveredBackground', 'selectedForeground', 'indicatorForeground' ],
	#category : #'BVC-Theme-GT'
}

{ #category : #initialization }
CgtSelectSubTheme >> initializeThemeable [
	hoveredBackground := self color: [ :aTheme | self contrastTintColorFor: aTheme alpha: 0.10 ] source: [ :aTheme | aTheme select hoveredBackground ].
	optionHoveredBackground := self color: [ :aTheme | self contrastTintColorFor: aTheme alpha: 0.08 ] source: [ :aTheme | aTheme select optionHoveredBackground ].
	selectedForeground := self color: [ :aTheme | Color white ] source: [ :aTheme | aTheme select selectedForeground ].
	indicatorForeground := self color: [ :aTheme | self contrastTintColorFor: aTheme alpha: 0.72 ] source: [ :aTheme | aTheme select indicatorForeground ]
]

{ #category : #private }
CgtSelectSubTheme >> contrastTintColorFor: aTheme alpha: anAlpha [
	| aBackground aLuminance |
	aBackground := aTheme default contentBackground blocResolveColorForTheme: aTheme.
	aLuminance := (aBackground red * 0.2126) + (aBackground green * 0.7152) + (aBackground blue * 0.0722).
	^ (aLuminance < 0.5 ifTrue: [ Color white ] ifFalse: [ Color black ]) alpha: anAlpha
]

{ #category : #accessing }
CgtSelectSubTheme >> hoveredBackground [ ^ hoveredBackground ]
{ #category : #accessing }
CgtSelectSubTheme >> optionHoveredBackground [ ^ optionHoveredBackground ]
{ #category : #accessing }
CgtSelectSubTheme >> selectedForeground [ ^ selectedForeground ]

{ #category : #accessing }
CgtSelectSubTheme >> indicatorForeground [ ^ indicatorForeground ]
