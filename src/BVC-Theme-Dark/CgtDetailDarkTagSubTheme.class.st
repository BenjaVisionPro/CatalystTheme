Class { #name : #CgtDetailDarkTagSubTheme, #superclass : #CgtTagSubTheme, #category : #'BVC-Theme-Dark' }
{ #category : #initialization }
CgtDetailDarkTagSubTheme >> initializeConstants [
	super initializeConstants.
	self constantAt: #background put: (Color white alpha: 0.06); constantAt: #hoveredBackground put: (Color white alpha: 0.12); constantAt: #editorBackground put: (Color black alpha: 0.10)
]
