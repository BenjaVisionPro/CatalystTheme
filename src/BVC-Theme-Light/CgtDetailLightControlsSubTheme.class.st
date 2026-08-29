Class {
	#name : #CgtDetailLightControlsSubTheme,
	#superclass : #CgtControlsSubTheme,
	#category : #'BVC-Theme-Light'
}

{ #category : #initialization }
CgtDetailLightControlsSubTheme >> initializeConstants [
	super initializeConstants.
	self
		constantAt: #sliderTrackTint put: (Color black alpha: 0.14);
		constantAt: #sliderThumbBackground put: Color white;
		constantAt: #sliderThumbBorderTint put: (Color black alpha: 0.16);
		constantAt: #sliderTickTint put: (Color black alpha: 0.22);
		constantAt: #switchInactiveTrackTint put: (Color black alpha: 35.0 / 255.0);
		constantAt: #switchThumbBackground put: Color white;
		constantAt: #inactiveIconForeground put: (Color black alpha: 0.68);
		constantAt: #controlIndicatorForeground put: (Color black alpha: 0.72);
		constantAt: #tagBackgroundTint put: (Color black alpha: 0.06);
		constantAt: #tagEditorBackground put: (Color white alpha: 0.9)
]
