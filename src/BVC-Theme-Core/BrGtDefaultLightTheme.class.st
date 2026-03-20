Class {
	#name : #BrGtDefaultLightTheme,
	#superclass : #BrGlamorousDefaultTheme,
	#category : #'BVC-Theme-Core'
}

{ #category : #initialization }
BrGtDefaultLightTheme >> initializeColors [
	super initializeColors.
	distinctTenStrongColors := BrGlamorousColors distinctTenStrongColors.
	distinctTenLightColors := BrGlamorousColors distinctTenLightColors
]

{ #category : #initialization }
BrGtDefaultLightTheme >> initializeThemeable [
	super initializeThemeable.

	defaultShadowColor := self
			color: [ :aTheme | aTheme colors defaultShadowColor ]
			source: [ :aTheme | aTheme default defaultShadowColor ].

	primaryBorderColor := self
			color: [ :aTheme | aTheme colors primaryBorderColor ]
			source: [ :aTheme | aTheme default primaryBorderColor ].

	darkBorderColor := self
			color: [ :aTheme | aTheme colors darkBorderColor ]
			source: [ :aTheme | aTheme default darkBorderColor ].

	newsBackgroundColor := self
			color: [ :aTheme | aTheme colors newsBackgroundColor ]
			source: [ :aTheme | aTheme default newsBackgroundColor ]
]
