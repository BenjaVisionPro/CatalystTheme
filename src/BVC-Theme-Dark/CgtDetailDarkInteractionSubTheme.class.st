Class {
	#name : #CgtDetailDarkInteractionSubTheme,
	#superclass : #CgtInteractionSubTheme,
	#category : #'BVC-Theme-Dark'
}

{ #category : #initialization }
CgtDetailDarkInteractionSubTheme >> initializeConstants [
	super initializeConstants.
	self
		constantAt: #subtleBackgroundTint put: (Color white alpha: 0.06);
		constantAt: #controlBackgroundTint put: (Color white alpha: 0.08);
		constantAt: #popupBackgroundTint put: (Color white alpha: 0.10);
		constantAt: #hoveredBackgroundTint put: (Color white alpha: 0.12);
		constantAt: #pressedBackgroundTint put: (Color white alpha: 0.16)
]
