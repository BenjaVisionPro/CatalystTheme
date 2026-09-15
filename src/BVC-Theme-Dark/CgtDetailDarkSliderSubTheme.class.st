Class { #name : #CgtDetailDarkSliderSubTheme, #superclass : #CgtSliderSubTheme, #category : #'BVC-Theme-Dark' }
{ #category : #initialization }
CgtDetailDarkSliderSubTheme >> initializeConstants [
	super initializeConstants.
	self constantAt: #trackBackground put: (Color white alpha: 0.14); constantAt: #thumbBackground put: Color white alpha: 0.86; constantAt: #thumbBorderColor put: (Color black alpha: 0.16); constantAt: #tickColor put: (Color white alpha: 0.22)
]
