Class {
	#name : #CgtDarkDefaultTheme,
	#superclass : #BrGlamorousDefaultDarkTheme,
	#category : #'BVC-Theme-Dark'
}

{ #category : #initialization }
CgtDarkDefaultTheme >> initializeThemeable [
	super initializeThemeable.

	primaryBorderColor := self
			color: [ :aTheme | aTheme uiPalette valueForRoleNamed: #borderDefault ]
			source: [ :aTheme | aTheme default primaryBorderColor ].

	darkBorderColor := self
			color: [ :aTheme | aTheme uiPalette valueForRoleNamed: #borderDefault ]
			source: [ :aTheme | aTheme default darkBorderColor ].

	newsBackgroundColor := self
			color: [ :aTheme | aTheme uiPalette valueForRoleNamed: #surfaceContentSecondary ]
			source: [ :aTheme | aTheme default newsBackgroundColor ]
]
