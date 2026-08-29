Class {
	#name : #CgtDetailLightTypographySubTheme,
	#superclass : #CgtTypographySubTheme,
	#category : #'BVC-Theme-Light'
}

{ #category : #initialization }
CgtDetailLightTypographySubTheme >> initializeConstants [
	super initializeConstants.
	self
		constantAt: #primaryForeground put: Color black;
		constantAt: #secondaryForeground put: (Color black alpha: 0.8);
		constantAt: #tertiaryForeground put: (Color black alpha: 0.55);
		constantAt: #quaternaryForeground put: (Color black alpha: 0.35);
		constantAt: #disabledForeground put: (Color black alpha: 0.22);
		constantAt: #titleForeground put: (Color black alpha: 0.92);
		constantAt: #metadataForeground put: (Color black alpha: 0.45)
]
