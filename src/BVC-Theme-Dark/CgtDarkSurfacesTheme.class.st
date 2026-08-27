Class {
	#name : #CgtDarkSurfacesTheme,
	#superclass : #CgtSurfacesTheme,
	#category : #'BVC-Theme-Dark'
}

{ #category : #initialization }
CgtDarkSurfacesTheme >> initializeConstants [
	super initializeConstants.
	"Provisional until the Catalyst Dark visual reference is migrated."
	self
		constantAt: #baseBackground put: self theme colors contentBackgroundColor;
		constantAt: #cardTint put: (Color white alpha: 0.04);
		constantAt: #separatorTint put: (Color white alpha: 0.08)
]
