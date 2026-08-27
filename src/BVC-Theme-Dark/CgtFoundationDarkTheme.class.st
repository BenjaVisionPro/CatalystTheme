Class {
	#name : #CgtFoundationDarkTheme,
	#superclass : #CgtFoundationTheme,
	#category : #'BVC-Theme-Dark'
}

{ #category : #initialization }
CgtFoundationDarkTheme >> initializeConstants [
	super initializeConstants.
	"These are GT-native dark fallbacks so the semantic API is complete while
	the Catalyst Dark reference is still being migrated. They are not the final
	Catalyst Dark design."
	self
		constantAt: #primaryForeground put: self theme colors primaryTextColor;
		constantAt: #secondaryForeground put: self theme colors secondaryTextColor;
		constantAt: #tertiaryForeground put: self theme colors tertiaryTextColor;
		constantAt: #quaternaryForeground put: self theme colors disabledTextColor;
		constantAt: #disabledForeground put: self theme colors disabledTextColor;
		constantAt: #formBackground put: self theme colors contentBackgroundColor;
		constantAt: #cardBackground put: self theme colors contentBackgroundColor;
		constantAt: #separatorColor put: self theme colors tertiaryTextColor
]
