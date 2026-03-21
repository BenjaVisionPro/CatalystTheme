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

newsBackgroundColor := self
        color: [ :aTheme | aTheme uiPalette valueForRoleNamed: #surfaceContentSecondary ]
        source: [ :aTheme | aTheme default newsBackgroundColor ]
]


{ #category : #accessing }
CgtTransparentDefaultTheme >> appBackground [
    (theme notNil and: [ theme bindings notNil and: [ theme uiPalette notNil and: [ theme bindings hasBindingForConsumerSelector: #appBackground ] ] ])
        ifTrue: [ ^ theme bindings valueForConsumerSelector: #appBackground fromPalette: theme uiPalette ].
    ^ super appBackground
]
