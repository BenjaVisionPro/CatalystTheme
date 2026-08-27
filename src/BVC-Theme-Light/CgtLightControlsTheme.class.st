Class {
	#name : #CgtLightControlsTheme,
	#superclass : #CgtControlsTheme,
	#category : #'BVC-Theme-Light'
}

{ #category : #initialization }
CgtLightControlsTheme >> initializeConstants [
	super initializeConstants.
	self
		constantAt: #sliderTrackTint put: (Color black alpha: 0.14);
		constantAt: #sliderThumbBackground put: Color white;
		constantAt: #sliderThumbBorderTint put: (Color black alpha: 0.16);
		constantAt: #sliderTickTint put: (Color black alpha: 0.22);
		constantAt: #switchInactiveTrackTint put: (Color black alpha: 35.0 / 255.0);
		constantAt: #switchThumbBackground put: Color white
]
