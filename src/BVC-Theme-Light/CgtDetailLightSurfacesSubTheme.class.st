Class {
	#name : #CgtDetailLightSurfacesSubTheme,
	#superclass : #CgtSurfacesSubTheme,
	#category : #'BVC-Theme-Light'
}

{ #category : #initialization }
CgtDetailLightSurfacesSubTheme >> initializeConstants [
	super initializeConstants.
	self
		constantAt: #baseBackground put: Color white;
		constantAt: #cardTint put: (Color black alpha: 7.0 / 255.0);
		constantAt: #separatorTint put: (Color black alpha: 19.0 / 248.0)
]
