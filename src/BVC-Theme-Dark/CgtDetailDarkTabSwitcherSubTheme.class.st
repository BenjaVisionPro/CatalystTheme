Class { #name : #CgtDetailDarkTabSwitcherSubTheme, #superclass : #CgtTabSwitcherSubTheme, #category : #'BVC-Theme-Dark' }

{ #category : #initialization }
CgtDetailDarkTabSwitcherSubTheme >> initializeConstants [
	super initializeConstants.
	self
		constantAt: #hoveredBackground put: (Color white alpha: 0.08);
		constantAt: #pressedBackground put: (Color white alpha: 0.12)
]
