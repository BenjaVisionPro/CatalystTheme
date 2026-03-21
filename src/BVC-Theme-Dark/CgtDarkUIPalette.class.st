Class {
    #name : #CgtDarkUIPalette,
    #superclass : #CgtAbstractUIPalette,
    #category : #'BVC-Theme-Dark'
}

{ #category : #initialization }
CgtDarkUIPalette >> initialize [
    super initialize.
    self
        valueAtRoleNamed: #surfaceWorldBackground put: (Color fromHexString: '#1E1F24');
        valueAtRoleNamed: #surfaceChromePrimary put: (Color fromHexString: '#1E1F24');
        valueAtRoleNamed: #surfaceChromeSecondary put: (Color fromHexString: '#24262C');
        valueAtRoleNamed: #surfaceTabBarBackground put: (Color fromHexString: '#24262C');
        valueAtRoleNamed: #surfaceTabContentBackground put: (Color fromHexString: '#1E2127');
        valueAtRoleNamed: #surfaceContentPrimary put: (Color fromHexString: '#1E2127');
        valueAtRoleNamed: #surfaceContentSecondary put: (Color fromHexString: '#2A2D34');
        valueAtRoleNamed: #textPrimary put: (Color fromHexString: '#E8ECF1');
        valueAtRoleNamed: #textSecondary put: (Color fromHexString: '#B7C0CC');
        valueAtRoleNamed: #textMuted put: (Color fromHexString: '#7E8794');
        valueAtRoleNamed: #borderDefault put: (Color fromHexString: '#3A3F48');
        valueAtRoleNamed: #borderFocus put: (Color fromHexString: '#3B82F6');
        valueAtRoleNamed: #itemBackground put: (Color fromHexString: '#1E2127');
        valueAtRoleNamed: #itemBackgroundSelected put: (Color fromHexString: '#38404B');
        valueAtRoleNamed: #itemBackgroundHovered put: (Color fromHexString: '#2C323B');
        valueAtRoleNamed: #itemText put: (Color fromHexString: '#E8ECF1');
        valueAtRoleNamed: #itemTextSelected put: (Color fromHexString: '#FFFFFF');
        valueAtRoleNamed: #headerBackground put: (Color fromHexString: '#24262C');
        valueAtRoleNamed: #headerText put: (Color fromHexString: '#E8ECF1');
        valueAtRoleNamed: #tabBackgroundActive put: (Color fromHexString: '#2F3742');
        valueAtRoleNamed: #tabBackgroundInactive put: (Color fromHexString: '#24262C');
        valueAtRoleNamed: #tabTextActive put: (Color fromHexString: '#FFFFFF');
        valueAtRoleNamed: #tabTextInactive put: (Color fromHexString: '#B7C0CC')
]
