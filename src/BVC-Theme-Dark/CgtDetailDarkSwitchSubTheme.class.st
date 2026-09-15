Class { #name : #CgtDetailDarkSwitchSubTheme, #superclass : #CgtSwitchSubTheme, #category : #'BVC-Theme-Dark' }
{ #category : #initialization }
CgtDetailDarkSwitchSubTheme >> initializeConstants [
	super initializeConstants.
	self constantAt: #inactiveTrackBackground put: (Color white alpha: 35.0 / 255.0); constantAt: #thumbBackground put: Color white alpha: 0.86
]
