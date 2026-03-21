Class {
    #name : #CgtTransparentUIPalette,
    #superclass : #CgtAbstractUIPalette,
    #category : #'BVC-Theme-Transparent'
}

{ #category : #initialization }
CgtTransparentUIPalette >> initialize [
    super initialize.
    self
        valueAtRoleNamed: #surfaceWorldBackground put: Color transparent;
        valueAtRoleNamed: #surfaceChromePrimary put: Color transparent;
        valueAtRoleNamed: #surfaceChromeSecondary put: Color transparent;
        valueAtRoleNamed: #surfaceTabBarBackground put: Color transparent;
        valueAtRoleNamed: #surfaceTabContentBackground put: Color transparent;
        valueAtRoleNamed: #surfaceContentPrimary put: Color transparent;
        valueAtRoleNamed: #surfaceContentSecondary put: Color transparent;
        valueAtRoleNamed: #textPrimary put: (Color fromHexString: '#E8ECF1');
        valueAtRoleNamed: #textSecondary put: (Color fromHexString: '#C7D0DB');
        valueAtRoleNamed: #textMuted put: (Color fromHexString: '#95A0AE');
        valueAtRoleNamed: #borderDefault put: (Color fromHexString: '#8FA0B5');
        valueAtRoleNamed: #borderFocus put: (Color fromHexString: '#60A5FA');
        valueAtRoleNamed: #itemBackground put: Color transparent;
        valueAtRoleNamed: #itemBackgroundSelected put: (Color fromHexString: '#2D3A4C');
        valueAtRoleNamed: #itemBackgroundHovered put: (Color fromHexString: '#1F2937');
        valueAtRoleNamed: #itemText put: (Color fromHexString: '#E8ECF1');
        valueAtRoleNamed: #itemTextSelected put: (Color fromHexString: '#FFFFFF');
        valueAtRoleNamed: #headerBackground put: Color transparent;
        valueAtRoleNamed: #headerText put: (Color fromHexString: '#E8ECF1');
        valueAtRoleNamed: #tabBackgroundActive put: (Color fromHexString: '#273243');
        valueAtRoleNamed: #tabBackgroundInactive put: Color transparent;
        valueAtRoleNamed: #tabTextActive put: (Color fromHexString: '#FFFFFF');
        valueAtRoleNamed: #tabTextInactive put: (Color fromHexString: '#C7D0DB')
]
