Class {
    #name : #CgtLightCodePalette,
    #superclass : #CgtAbstractCodePalette,
    #category : #'BVC-Theme-Light'
}

{ #category : #initialization }
CgtLightCodePalette >> initialize [
    super initialize.
    self
        valueAtRoleNamed: #codeBackground put: (Color fromHexString: '#FFFFFF');
        valueAtRoleNamed: #codeTextPlain put: (Color fromHexString: '#20242B');
        valueAtRoleNamed: #codeTextComment put: (Color fromHexString: '#6B7280');
        valueAtRoleNamed: #codeTextKeyword put: (Color fromHexString: '#005CC5');
        valueAtRoleNamed: #codeTextString put: (Color fromHexString: '#0A7A2F')
]
