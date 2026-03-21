Class {
    #name : #CgtTransparentHeaderTheme,
    #superclass : #BrGlamorousHeaderDarkTheme,
    #category : #'BVC-Theme-Transparent'
}

{ #category : #initialization }
CgtTransparentHeaderTheme >> initializeThemeable [
    super initializeThemeable.

    textMarkupColor := self
            color: [ :aTheme | aTheme uiPalette valueForRoleNamed: #textMuted ]
            source: [ :aTheme | aTheme header textMarkupColor ].

    defaultBackgroundColor := self
            color: [ :aTheme | aTheme uiPalette valueForRoleNamed: #headerBackground ]
            source: [ :aTheme | aTheme header defaultBackgroundColor ].

    disabledTextColor := self
            color: [ :aTheme | aTheme uiPalette valueForRoleNamed: #textMuted ]
            source: [ :aTheme | aTheme header disabledTextColor ].

    defaultTextColor := self
            color: [ :aTheme | aTheme uiPalette valueForRoleNamed: #headerText ]
            source: [ :aTheme | aTheme header defaultTextColor ].

    secondaryBackgroundColor := self
            color: [ :aTheme | aTheme uiPalette valueForRoleNamed: #tabBackgroundInactive ]
            source: [ :aTheme | aTheme header secondaryBackgroundColor ].

    defaultBackground := self
            background: [ :aTheme | aTheme uiPalette valueForRoleNamed: #headerBackground ]
            source: [ :aTheme | aTheme header defaultBackground ]
]
