Class {
    #name : #CgtTransparentDefaultTheme,
    #superclass : #BrGlamorousDefaultDarkTheme,
    #category : #'BVC-Theme-Transparent'
}

{ #category : #initialization }
CgtTransparentDefaultTheme >> initializeThemeable [
    super initializeThemeable.

    primaryBorderColor := self
            color: [ :aTheme | aTheme uiPalette valueForRoleNamed: #borderDefault ]
            source: [ :aTheme | aTheme default primaryBorderColor ].

    darkBorderColor := self
            color: [ :aTheme | aTheme uiPalette valueForRoleNamed: #borderDefault ]
            source: [ :aTheme | aTheme default darkBorderColor ].

    appBackground := self
            background: [ :aTheme | aTheme bindings valueForConsumerSelector: #appBackground fromPalette: aTheme uiPalette ]
            source: [ :aTheme | aTheme default appBackground ].

    newsBackgroundColor := self
            color: [ :aTheme | aTheme uiPalette valueForRoleNamed: #surfaceContentSecondary ]
            source: [ :aTheme | aTheme default newsBackgroundColor ]
]
