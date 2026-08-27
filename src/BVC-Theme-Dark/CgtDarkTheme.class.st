Class {
	#name : #CgtDarkTheme,
	#superclass : #CgtAbstractTheme,
	#category : #'BVC-Theme-Dark'
}

{ #category : #'class defaults' }
CgtDarkTheme class >> buttonThemeClass [
	^ CgtDarkButtonTheme
]

{ #category : #'class defaults' }
CgtDarkTheme class >> colorsClass [
	^ BrGlamorousDarkThemeColors
]


{ #category : #'class defaults' }
CgtDarkTheme class >> controlsThemeClass [
	^ CgtDarkControlsTheme
]

{ #category : #'class defaults' }
CgtDarkTheme class >> defaultThemeClass [
	^ BrGlamorousDefaultDarkTheme
]

{ #category : #'class defaults' }
CgtDarkTheme class >> editorThemeClass [
	^ CgtDarkEditorTheme
]


{ #category : #'class defaults' }
CgtDarkTheme class >> headerThemeClass [
	^ BrGlamorousHeaderDarkTheme
]


{ #category : #'class defaults' }
CgtDarkTheme class >> interactionThemeClass [
	^ CgtDarkInteractionTheme
]

{ #category : #'class defaults' }
CgtDarkTheme class >> surfacesThemeClass [
	^ CgtDarkSurfacesTheme
]

{ #category : #'class defaults' }
CgtDarkTheme class >> typographyThemeClass [
	^ CgtDarkTypographyTheme
]

{ #category : #'class defaults' }
CgtDarkTheme class >> menuThemeClass [
	^ CgtDarkMenuTheme
]
