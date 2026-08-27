Class {
	#name : #CgtDarkSurfacesTheme,
	#superclass : #CgtSurfacesTheme,
	#category : #'BVC-Theme-Dark'
}

{ #category : #initialization }
CgtDarkSurfacesTheme >> initializeConstants [
	super initializeConstants.
	self
		constantAt: #baseBackground put: self theme colors contentBackgroundColor;
		constantAt: #cardTint put: (Color white alpha: 7.0 / 255.0);
		constantAt: #separatorTint put: (Color white alpha: 19.0 / 248.0)
]
