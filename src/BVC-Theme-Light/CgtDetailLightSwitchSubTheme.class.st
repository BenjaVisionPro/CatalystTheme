Class { #name : #CgtDetailLightSwitchSubTheme, #superclass : #CgtSwitchSubTheme, #category : #'BVC-Theme-Light' }
{ #category : #initialization }
CgtDetailLightSwitchSubTheme >> initializeConstants [
	super initializeConstants.
	self constantAt: #inactiveTrackBackground put: (Color black alpha: 35.0 / 255.0); constantAt: #thumbBackground put: Color white
]
