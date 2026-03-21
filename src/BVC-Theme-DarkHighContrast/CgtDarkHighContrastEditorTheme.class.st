Class {
    #name : #CgtDarkHighContrastEditorTheme,
    #superclass : #BrGlamorousEditorDarkTheme,
    #category : #'BVC-Theme-DarkHighContrast'
}

{ #category : #initialization }
CgtDarkHighContrastEditorTheme >> initialize [
    super initialize.
    borderColor := Color transparent.
    focusedBorderColor := Color transparent
]

{ #category : #initialization }
CgtDarkHighContrastEditorTheme >> initializeThemeable [
    super initializeThemeable.

    borderColor := self
            color: [ :aTheme | aTheme uiPalette valueForRoleNamed: #borderDefault ]
            source: [ :aTheme | aTheme editor borderColor ].

    focusedBorderColor := self
            color: [ :aTheme | aTheme uiPalette valueForRoleNamed: #borderFocus ]
            source: [ :aTheme | aTheme editor focusedBorderColor ].

    defaultTextForeground := self
            color: [ :aTheme | aTheme codePalette valueForRoleNamed: #codeTextPlain ]
            source: [ :aTheme | aTheme editor defaultTextForeground ].

    pharoDeclaredVariableForeground := self
            color: [ :aTheme | aTheme codePalette valueForRoleNamed: #codeTextPlain ]
            source: [ :aTheme | aTheme editor pharoDeclaredVariableForeground ].

    pharoUndeclaredVariableForeground := self
            color: [ :aTheme | aTheme codePalette valueForRoleNamed: #codeTextPlain ]
            source: [ :aTheme | aTheme editor pharoUndeclaredVariableForeground ].

    pharoSelfVariableForeground := self
            color: [ :aTheme | aTheme codePalette valueForRoleNamed: #codeTextPlain ]
            source: [ :aTheme | aTheme editor pharoSelfVariableForeground ].

    pharoSuperVariableForeground := self
            color: [ :aTheme | aTheme codePalette valueForRoleNamed: #codeTextPlain ]
            source: [ :aTheme | aTheme editor pharoSuperVariableForeground ].

    pharoThisContextVariableForeground := self
            color: [ :aTheme | aTheme codePalette valueForRoleNamed: #codeTextPlain ]
            source: [ :aTheme | aTheme editor pharoThisContextVariableForeground ].

    pharoPragmaForeground := self
            color: [ :aTheme | aTheme codePalette valueForRoleNamed: #codeTextKeyword ]
            source: [ :aTheme | aTheme editor pharoPragmaForeground ].

    pharoReturnArrowForeground := self
            color: [ :aTheme | aTheme codePalette valueForRoleNamed: #codeTextKeyword ]
            source: [ :aTheme | aTheme editor pharoReturnArrowForeground ].

    pharoStringLiteralForeground := self
            color: [ :aTheme | aTheme codePalette valueForRoleNamed: #codeTextString ]
            source: [ :aTheme | aTheme editor pharoStringLiteralForeground ].

    pharoSymbolLiteralForeground := self
            color: [ :aTheme | aTheme codePalette valueForRoleNamed: #codeTextString ]
            source: [ :aTheme | aTheme editor pharoSymbolLiteralForeground ].

    pharoNumberLiteralForeground := self
            color: [ :aTheme | aTheme codePalette valueForRoleNamed: #codeTextKeyword ]
            source: [ :aTheme | aTheme editor pharoNumberLiteralForeground ].

    pharoNilLiteralForeground := self
            color: [ :aTheme | aTheme codePalette valueForRoleNamed: #codeTextKeyword ]
            source: [ :aTheme | aTheme editor pharoNilLiteralForeground ].

    pharoBooleanLiteralForeground := self
            color: [ :aTheme | aTheme codePalette valueForRoleNamed: #codeTextKeyword ]
            source: [ :aTheme | aTheme editor pharoBooleanLiteralForeground ].

    pharoCharacterLiteralForeground := self
            color: [ :aTheme | aTheme codePalette valueForRoleNamed: #codeTextString ]
            source: [ :aTheme | aTheme editor pharoCharacterLiteralForeground ].

    pharoCommentForeground := self
            color: [ :aTheme | aTheme codePalette valueForRoleNamed: #codeTextComment ]
            source: [ :aTheme | aTheme editor pharoCommentForeground ].

    pharoErrorTokenForeground := self
            color: [ :aTheme | aTheme uiPalette valueForRoleNamed: #borderFocus ]
            source: [ :aTheme | aTheme editor pharoErrorTokenForeground ]
]
