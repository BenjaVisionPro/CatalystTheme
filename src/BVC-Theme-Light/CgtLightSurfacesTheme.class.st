Class {
	#name : #CgtLightSurfacesTheme,
	#superclass : #CgtSurfacesTheme,
	#category : #'BVC-Theme-Light'
}

{ #category : #initialization }
CgtLightSurfacesTheme >> initializeConstants [
	super initializeConstants.
	self
		constantAt: #formBackground put: Color white;
		constantAt: #cardBackground put: (Color r: 248 g: 248 b: 248 range: 255);
		constantAt: #separatorColor put: (Color r: 229 g: 229 b: 229 range: 255)
]
