Class { #name : #CgtDetailLightTabSwitcherSubTheme, #superclass : #CgtTabSwitcherSubTheme, #category : #'BVC-Theme-Light' }

{ #category : #initialization }
CgtDetailLightTabSwitcherSubTheme >> initializeConstants [
	super initializeConstants.
	self
		constantAt: #hoveredBackground put: Color veryVeryLightGray lighter;
		constantAt: #pressedBackground put: Color veryVeryLightGray
]
