Class {
    #name : #CgtTransparentCodePalette,
    #superclass : #CgtAbstractCodePalette,
    #category : #'BVC-Theme-Transparent'
}

{ #category : #initialization }
CgtTransparentCodePalette >> initialize [
    super initialize.
    self
        valueAtRoleNamed: #codeBackground put: Color transparent;
        valueAtRoleNamed: #codeTextPlain put: (Color fromHexString: '#E8ECF1');
        valueAtRoleNamed: #codeTextComment put: (Color fromHexString: '#95A0AE');
        valueAtRoleNamed: #codeTextKeyword put: (Color fromHexString: '#7DD3FC');
        valueAtRoleNamed: #codeTextString put: (Color fromHexString: '#A7F3D0')
]
