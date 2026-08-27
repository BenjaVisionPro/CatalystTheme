Class {
	#name : #CgtDarkTypographyTheme,
	#superclass : #CgtTypographyTheme,
	#category : #'BVC-Theme-Dark'
}

{ #category : #initialization }
CgtDarkTypographyTheme >> initializeConstants [
	super initializeConstants.
	self
		constantAt: #primaryForeground put: self theme colors primaryTextColor;
		constantAt: #secondaryForeground put: self theme colors secondaryTextColor;
		constantAt: #tertiaryForeground put: self theme colors tertiaryTextColor;
		constantAt: #quaternaryForeground put: self theme colors disabledTextColor;
		constantAt: #disabledForeground put: self theme colors disabledTextColor
]
