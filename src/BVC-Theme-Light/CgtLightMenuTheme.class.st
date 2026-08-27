Class {
	#name : #CgtLightMenuTheme,
	#superclass : #CgtMenuTheme,
	#category : #'BVC-Theme-Light'
}

{ #category : #initialization }
CgtLightMenuTheme >> initializeConstants [
	super initializeConstants.
	self
		constantAt: #containerBackground put: Color transparent;
		constantAt: #containerBorderColor put: Color transparent;
		constantAt: #containerShadowColor put: Color transparent;
		constantAt: #menuBackground put: (Color black alpha: 0.06);
		constantAt: #menuBorderColor put: (Color black alpha: 0.18);
		constantAt: #menuShadowColor put: (Color black alpha: 0.28)
]
