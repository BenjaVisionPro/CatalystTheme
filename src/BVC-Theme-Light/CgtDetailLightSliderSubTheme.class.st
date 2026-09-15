Class { #name : #CgtDetailLightSliderSubTheme, #superclass : #CgtSliderSubTheme, #category : #'BVC-Theme-Light' }
{ #category : #initialization }
CgtDetailLightSliderSubTheme >> initializeConstants [
	super initializeConstants.
	self constantAt: #trackBackground put: (Color black alpha: 0.14); constantAt: #thumbBackground put: Color white; constantAt: #thumbBorderColor put: (Color black alpha: 0.16); constantAt: #tickColor put: (Color black alpha: 0.22)
]
