Class {
	#name : #CgtDarkSurfacesTheme,
	#superclass : #CgtSurfacesTheme,
	#category : #'BVC-Theme-Dark'
}

{ #category : #initialization }
CgtDarkSurfacesTheme >> initializeConstants [
	super initializeConstants.
	"Provisional GT-native dark fallbacks until the Catalyst Dark reference is migrated."
	self
		constantAt: #formBackground put: self theme colors contentBackgroundColor;
		constantAt: #cardBackground put: self theme colors contentBackgroundColor;
		constantAt: #separatorColor put: self theme colors tertiaryTextColor
]
