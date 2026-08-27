Class {
	#name : #CgtDarkMenuTheme,
	#superclass : #CgtMenuTheme,
	#category : #'BVC-Theme-Dark'
}

{ #category : #initialization }
CgtDarkMenuTheme >> initializeConstants [
	super initializeConstants.
	self
		constantAt: #containerBackground put: Color transparent;
		constantAt: #containerBorderColor put: Color transparent;
		constantAt: #containerShadowColor put: Color transparent;
		constantAt: #menuBackground put: (Color white alpha: 0.08);
		constantAt: #menuBorderColor put: (Color white alpha: 0.18);
		constantAt: #menuShadowColor put: (Color black alpha: 0.45)
]
