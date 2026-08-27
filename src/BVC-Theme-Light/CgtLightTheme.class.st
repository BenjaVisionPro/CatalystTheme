Class {
	#name : #CgtLightTheme,
	#superclass : #CgtAbstractTheme,
	#category : #'BVC-Theme-Light'
}

{ #category : #'class defaults' }
CgtLightTheme class >> buttonThemeClass [
	^ CgtLightButtonTheme
]

{ #category : #'class defaults' }
CgtLightTheme class >> colorsClass [
	^ BrGlamorousLightThemeColors
]


{ #category : #'class defaults' }
CgtLightTheme class >> controlsThemeClass [
	^ CgtLightControlsTheme
]

{ #category : #'class defaults' }
CgtLightTheme class >> defaultThemeClass [
	^ BrGlamorousDefaultLightTheme
]

{ #category : #'class defaults' }
CgtLightTheme class >> editorThemeClass [
	^ CgtLightEditorTheme
]


{ #category : #'class defaults' }
CgtLightTheme class >> headerThemeClass [
	^ BrGlamorousHeaderLightTheme
]


{ #category : #'class defaults' }
CgtLightTheme class >> interactionThemeClass [
	^ CgtLightInteractionTheme
]

{ #category : #'class defaults' }
CgtLightTheme class >> surfacesThemeClass [
	^ CgtLightSurfacesTheme
]

{ #category : #'class defaults' }
CgtLightTheme class >> typographyThemeClass [
	^ CgtLightTypographyTheme
]

{ #category : #'class defaults' }
CgtLightTheme class >> menuThemeClass [
	^ CgtLightMenuTheme
]
