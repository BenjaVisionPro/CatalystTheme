Class {
	#name : #CgtStubCodePalette,
	#superclass : #CgtAbstractCodePalette,
	#category : #'BVC-Theme-Palettes-Core'
}

{ #category : #initialization }
CgtStubCodePalette >> initialize [
	super initialize.
	self valueAtRoleNamed: #codeBackground put: Color black.
	self valueAtRoleNamed: #codeTextPlain put: Color white.
	self valueAtRoleNamed: #codeTextComment put: Color gray.
	self valueAtRoleNamed: #codeTextKeyword put: Color magenta.
	self valueAtRoleNamed: #codeTextString put: Color orange
]
