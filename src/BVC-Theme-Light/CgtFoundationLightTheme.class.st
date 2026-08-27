Class {
	#name : #CgtFoundationLightTheme,
	#superclass : #CgtFoundationTheme,
	#category : #'BVC-Theme-Light'
}

{ #category : #initialization }
CgtFoundationLightTheme >> initializeConstants [
	super initializeConstants.
	self
		constantAt: #primaryForeground put: Color black;
		constantAt: #secondaryForeground put: (Color black alpha: 0.8);
		constantAt: #tertiaryForeground put: (Color black alpha: 0.55);
		constantAt: #quaternaryForeground put: (Color black alpha: 0.35);
		constantAt: #disabledForeground put: (Color black alpha: 0.22);
		constantAt: #formBackground put: Color white;
		constantAt: #cardBackground put: (Color r: 248 g: 248 b: 248 range: 255);
		constantAt: #separatorColor put: (Color r: 229 g: 229 b: 229 range: 255)
]
