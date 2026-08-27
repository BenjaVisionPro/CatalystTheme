Class {
	#name : #CgtLightingTheme,
	#superclass : #BlSubTheme,
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtLightingTheme >> direction [
	^ self theme themeState lightDirection
]
