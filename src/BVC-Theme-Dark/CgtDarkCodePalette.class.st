Class {
	#name : #CgtDarkCodePalette,
	#superclass : #CgtAbstractCodePalette,
	#category : #'BVC-Theme-Dark'
}

{ #category : #initialization }
CgtDarkCodePalette >> initialize [
	super initialize.
	self
		valueAtRoleNamed: #codeBackground put: (Color fromHexString: '#1E2127');
		valueAtRoleNamed: #codeTextPlain put: (Color fromHexString: '#E8ECF1');
		valueAtRoleNamed: #codeTextComment put: (Color fromHexString: '#7E8794');
		valueAtRoleNamed: #codeTextKeyword put: (Color fromHexString: '#FF7AB2');
		valueAtRoleNamed: #codeTextString put: (Color fromHexString: '#FF9D66')
]
