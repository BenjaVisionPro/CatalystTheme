Class {
	#name : #CgtLightInteractionTheme,
	#superclass : #CgtInteractionTheme,
	#category : #'BVC-Theme-Light'
}

{ #category : #initialization }
CgtLightInteractionTheme >> initializeConstants [
	super initializeConstants.
	self
		constantAt: #subtleBackgroundTint put: (Color black alpha: 0.06);
		constantAt: #controlBackgroundTint put: (Color black alpha: 0.08);
		constantAt: #popupBackgroundTint put: (Color black alpha: 0.10);
		constantAt: #hoveredBackgroundTint put: (Color black alpha: 0.12);
		constantAt: #pressedBackgroundTint put: (Color black alpha: 0.16)
]
