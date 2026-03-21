Class {
    #name : #CgtDarkHighContrastUIPalette,
    #superclass : #CgtAbstractUIPalette,
    #category : #'BVC-Theme-DarkHighContrast'
}

{ #category : #initialization }
CgtDarkHighContrastUIPalette >> initialize [
    super initialize.
    self
        valueAtRoleNamed: #surfaceWorldBackground put: (Color fromHexString: '#0B0D10');
        valueAtRoleNamed: #surfaceChromePrimary put: (Color fromHexString: '#0B0D10');
        valueAtRoleNamed: #surfaceChromeSecondary put: (Color fromHexString: '#14181D');
        valueAtRoleNamed: #surfaceTabBarBackground put: (Color fromHexString: '#14181D');
        valueAtRoleNamed: #surfaceTabContentBackground put: (Color fromHexString: '#0F1317');
        valueAtRoleNamed: #surfaceContentPrimary put: (Color fromHexString: '#0F1317');
        valueAtRoleNamed: #surfaceContentSecondary put: (Color fromHexString: '#181D23');
        valueAtRoleNamed: #textPrimary put: (Color fromHexString: '#FFFFFF');
        valueAtRoleNamed: #textSecondary put: (Color fromHexString: '#E2E8F0');
        valueAtRoleNamed: #textMuted put: (Color fromHexString: '#AAB4C0');
        valueAtRoleNamed: #borderDefault put: (Color fromHexString: '#7A8697');
        valueAtRoleNamed: #borderFocus put: (Color fromHexString: '#60A5FA');
        valueAtRoleNamed: #itemBackground put: (Color fromHexString: '#0F1317');
        valueAtRoleNamed: #itemBackgroundSelected put: (Color fromHexString: '#27466A');
        valueAtRoleNamed: #itemBackgroundHovered put: (Color fromHexString: '#1C2936');
        valueAtRoleNamed: #itemText put: (Color fromHexString: '#FFFFFF');
        valueAtRoleNamed: #itemTextSelected put: (Color fromHexString: '#FFFFFF');
        valueAtRoleNamed: #headerBackground put: (Color fromHexString: '#14181D');
        valueAtRoleNamed: #headerText put: (Color fromHexString: '#FFFFFF');
        valueAtRoleNamed: #tabBackgroundActive put: (Color fromHexString: '#27466A');
        valueAtRoleNamed: #tabBackgroundInactive put: (Color fromHexString: '#14181D');
        valueAtRoleNamed: #tabTextActive put: (Color fromHexString: '#FFFFFF');
        valueAtRoleNamed: #tabTextInactive put: (Color fromHexString: '#E2E8F0')
]
