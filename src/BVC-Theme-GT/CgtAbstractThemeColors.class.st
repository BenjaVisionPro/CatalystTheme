Class {
    #name : #CgtAbstractThemeColors,
    #superclass : #BrGlamorousThemeColors,
    #category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtAbstractThemeColors >> appBackgroundColor [
    ^ self uiColorForConsumerSelector: #appBackgroundColor fallback: [ super appBackgroundColor ]
]

{ #category : #accessing }
CgtAbstractThemeColors >> backdropBackgroundColor [
    ^ self uiColorForConsumerSelector: #backdropBackgroundColor fallback: [ super backdropBackgroundColor ]
]

{ #category : #accessing }
CgtAbstractThemeColors >> backdropEmphasisBackgroundColor [
    ^ self uiColorForConsumerSelector: #backdropEmphasisBackgroundColor fallback: [ super backdropEmphasisBackgroundColor ]
]

{ #category : #accessing }
CgtAbstractThemeColors >> contentBackgroundColor [
    ^ self uiColorForConsumerSelector: #contentBackgroundColor fallback: [ super contentBackgroundColor ]
]

{ #category : #accessing }
CgtAbstractThemeColors >> disabledTextColor [
    ^ self uiColorRoleNamed: #textMuted fallback: [ super disabledTextColor ]
]

{ #category : #accessing }
CgtAbstractThemeColors >> floatBackgroundColor [
    ^ self uiColorRoleNamed: #surfaceContentSecondary fallback: [ super floatBackgroundColor ]
]

{ #category : #accessing }
CgtAbstractThemeColors >> groupBackgroundColor [
    ^ self uiColorRoleNamed: #surfaceContentSecondary fallback: [ super groupBackgroundColor ]
]

{ #category : #accessing }
CgtAbstractThemeColors >> invertedTextColor [
    ^ super invertedTextColor
]

{ #category : #accessing }
CgtAbstractThemeColors >> primaryTextColor [
    ^ self uiColorForConsumerSelector: #primaryTextColor fallback: [ super primaryTextColor ]
]

{ #category : #accessing }
CgtAbstractThemeColors >> raisedBackgroundColor [
    ^ self uiColorRoleNamed: #surfaceContentSecondary fallback: [ super raisedBackgroundColor ]
]

{ #category : #accessing }
CgtAbstractThemeColors >> secondaryTextColor [
    ^ self uiColorRoleNamed: #textSecondary fallback: [ super secondaryTextColor ]
]

{ #category : #accessing }
CgtAbstractThemeColors >> sidebarBackgroundColor [
    ^ self uiColorRoleNamed: #surfaceChromeSecondary fallback: [ super sidebarBackgroundColor ]
]

{ #category : #accessing }
CgtAbstractThemeColors >> sidebarTextColor [
    ^ self uiColorRoleNamed: #textSecondary fallback: [ super sidebarTextColor ]
]

{ #category : #accessing }
CgtAbstractThemeColors >> tertiaryTextColor [
    ^ self uiColorRoleNamed: #textMuted fallback: [ super tertiaryTextColor ]
]

{ #category : #private }
CgtAbstractThemeColors >> uiColorForConsumerSelector: aSelector fallback: aBlock [
    (theme notNil and: [ theme bindings notNil and: [ theme uiPalette notNil and: [ theme bindings hasBindingForConsumerSelector: aSelector ] ] ])
        ifTrue: [ ^ theme bindings valueForConsumerSelector: aSelector fromPalette: theme uiPalette ].
    ^ aBlock value
]

{ #category : #private }
CgtAbstractThemeColors >> uiColorRoleNamed: aRoleName fallback: aBlock [
    (theme notNil and: [ theme uiPalette notNil and: [ theme uiPalette hasValueForRoleNamed: aRoleName ] ])
        ifTrue: [ ^ theme uiPalette valueForRoleNamed: aRoleName ].
    ^ aBlock value
]

{ #category : #private }
CgtAbstractThemeColors >> uiColorRoleNamedAnyOf: roleNames fallback: aBlock [
    roleNames do: [ :each |
        (theme notNil and: [ theme uiPalette notNil and: [ theme uiPalette hasValueForRoleNamed: each ] ])
            ifTrue: [ ^ theme uiPalette valueForRoleNamed: each ] ].
    ^ aBlock value
]
