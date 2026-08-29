Class {
	#name : #CgtDetailDarkTypographySubTheme,
	#superclass : #CgtTypographySubTheme,
	#category : #'BVC-Theme-Dark'
}

{ #category : #initialization }
CgtDetailDarkTypographySubTheme >> initializeConstants [
	super initializeConstants.
	self
		constantAt: #primaryForeground put: Color white;
		constantAt: #secondaryForeground put: (Color white alpha: 0.8);
		constantAt: #tertiaryForeground put: (Color white alpha: 0.55);
		constantAt: #quaternaryForeground put: (Color white alpha: 0.35);
		constantAt: #disabledForeground put: (Color white alpha: 0.22);
		constantAt: #titleForeground put: (Color white alpha: 0.92);
		constantAt: #metadataForeground put: (Color white alpha: 0.45)
]
