Class {
    #name : #CgtDarkHighContrastCodePalette,
    #superclass : #CgtAbstractCodePalette,
    #category : #'BVC-Theme-DarkHighContrast'
}

{ #category : #initialization }
CgtDarkHighContrastCodePalette >> initialize [
    super initialize.
    self
        valueAtRoleNamed: #codeBackground put: (Color fromHexString: '#0F1317');
        valueAtRoleNamed: #codeTextPlain put: (Color fromHexString: '#FFFFFF');
        valueAtRoleNamed: #codeTextComment put: (Color fromHexString: '#BBD0A8');
        valueAtRoleNamed: #codeTextKeyword put: (Color fromHexString: '#7DD3FC');
        valueAtRoleNamed: #codeTextString put: (Color fromHexString: '#FDE68A')
]
