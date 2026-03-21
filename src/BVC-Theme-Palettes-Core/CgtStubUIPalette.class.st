Class {
	#name : #CgtStubUIPalette,
	#superclass : #CgtAbstractUIPalette,
	#category : #'BVC-Theme-Palettes-Core'
}

{ #category : #initialization }
CgtStubUIPalette >> initialize [
	super initialize.
	self valueAtRoleNamed: #surfaceChromePrimary put: Color veryVeryDarkGray.
	self valueAtRoleNamed: #surfaceChromeSecondary put: Color veryDarkGray.
	self valueAtRoleNamed: #surfaceContentPrimary put: Color black.
	self valueAtRoleNamed: #surfaceContentSecondary put: Color darkGray.
	self valueAtRoleNamed: #textPrimary put: Color white.
	self valueAtRoleNamed: #textSecondary put: Color veryLightGray.
	self valueAtRoleNamed: #textMuted put: Color gray.
	self valueAtRoleNamed: #borderDefault put: Color gray.
	self valueAtRoleNamed: #borderFocus put: Color blue.
	self valueAtRoleNamed: #itemBackground put: Color black.
	self valueAtRoleNamed: #itemBackgroundSelected put: Color blue muchDarker.
	self valueAtRoleNamed: #itemBackgroundHovered put: Color darkGray.
	self valueAtRoleNamed: #itemText put: Color white.
	self valueAtRoleNamed: #itemTextSelected put: Color white.
	self valueAtRoleNamed: #headerBackground put: Color veryDarkGray.
	self valueAtRoleNamed: #headerText put: Color white.
	self valueAtRoleNamed: #tabBackgroundActive put: Color darkGray.
	self valueAtRoleNamed: #tabBackgroundInactive put: Color veryDarkGray.
	self valueAtRoleNamed: #tabTextActive put: Color white.
	self valueAtRoleNamed: #tabTextInactive put: Color veryLightGray
]
