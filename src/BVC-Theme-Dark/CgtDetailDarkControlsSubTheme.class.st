Class {
	#name : #CgtDetailDarkControlsSubTheme,
	#superclass : #CgtControlsSubTheme,
	#category : #'BVC-Theme-Dark'
}

{ #category : #initialization }
CgtDetailDarkControlsSubTheme >> initializeConstants [
	super initializeConstants.
	self
		constantAt: #sliderTrackTint put: (Color white alpha: 0.14);
		constantAt: #sliderThumbBackground put: (Color white alpha: 0.86);
		constantAt: #sliderThumbBorderTint put: (Color black alpha: 0.16);
		constantAt: #sliderTickTint put: (Color white alpha: 0.22);
		constantAt: #switchInactiveTrackTint put: (Color white alpha: 35.0 / 255.0);
		constantAt: #switchThumbBackground put: (Color white alpha: 0.86);
		constantAt: #inactiveIconForeground put: (Color white alpha: 0.68);
		constantAt: #controlIndicatorForeground put: (Color white alpha: 0.72);
		constantAt: #tagBackgroundTint put: (Color white alpha: 0.06);
		constantAt: #tagHoveredBackgroundTint put: (Color white alpha: 0.12);
		constantAt: #tagEditorBackground put: (Color black alpha: 0.10)
]
