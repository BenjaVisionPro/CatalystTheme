Class {
    #name : #CgtLightUIPalette,
    #superclass : #CgtAbstractUIPalette,
    #category : #'BVC-Theme-Light'
}

{ #category : #initialization }
CgtLightUIPalette >> initialize [
    super initialize.
    self
        valueAtRoleNamed: #surfaceWorldBackground put: (Color fromHexString: '#F4F5F7');
        valueAtRoleNamed: #surfaceChromePrimary put: (Color fromHexString: '#F4F5F7');
        valueAtRoleNamed: #surfaceChromeSecondary put: (Color fromHexString: '#E7EAF0');
        valueAtRoleNamed: #surfaceTabBarBackground put: (Color fromHexString: '#E7EAF0');
        valueAtRoleNamed: #surfaceTabContentBackground put: (Color fromHexString: '#FFFFFF');
        valueAtRoleNamed: #surfaceContentPrimary put: (Color fromHexString: '#FFFFFF');
        valueAtRoleNamed: #surfaceContentSecondary put: (Color fromHexString: '#F1F3F7');
        valueAtRoleNamed: #textPrimary put: (Color fromHexString: '#20242B');
        valueAtRoleNamed: #textSecondary put: (Color fromHexString: '#505A67');
        valueAtRoleNamed: #textMuted put: (Color fromHexString: '#7B8592');
        valueAtRoleNamed: #borderDefault put: (Color fromHexString: '#C7D0DB');
        valueAtRoleNamed: #borderFocus put: (Color fromHexString: '#2563EB');
        valueAtRoleNamed: #itemBackground put: (Color fromHexString: '#FFFFFF');
        valueAtRoleNamed: #itemBackgroundSelected put: (Color fromHexString: '#DDE7F6');
        valueAtRoleNamed: #itemBackgroundHovered put: (Color fromHexString: '#EDF2FA');
        valueAtRoleNamed: #itemText put: (Color fromHexString: '#20242B');
        valueAtRoleNamed: #itemTextSelected put: (Color fromHexString: '#0F172A');
        valueAtRoleNamed: #headerBackground put: (Color fromHexString: '#E7EAF0');
        valueAtRoleNamed: #headerText put: (Color fromHexString: '#20242B');
        valueAtRoleNamed: #tabBackgroundActive put: (Color fromHexString: '#FFFFFF');
        valueAtRoleNamed: #tabBackgroundInactive put: (Color fromHexString: '#E7EAF0');
        valueAtRoleNamed: #tabTextActive put: (Color fromHexString: '#111827');
        valueAtRoleNamed: #tabTextInactive put: (Color fromHexString: '#505A67')
]
