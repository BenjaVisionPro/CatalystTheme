Class { #name : #CgtDetailLightTagSubTheme, #superclass : #CgtTagSubTheme, #category : #'BVC-Theme-Light' }
{ #category : #initialization }
CgtDetailLightTagSubTheme >> initializeConstants [
	super initializeConstants.
	self constantAt: #background put: (Color black alpha: 0.06); constantAt: #hoveredBackground put: (Color black alpha: 0.12); constantAt: #editorBackground put: (Color white alpha: 0.9)
]
