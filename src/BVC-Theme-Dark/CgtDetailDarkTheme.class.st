Class {
	#name : #CgtDetailDarkTheme,
	#superclass : #CgtTheme,
	#category : #'BVC-Theme-Dark'
}

{ #category : #'class defaults' }
CgtDetailDarkTheme class >> buttonThemeClass [
	^ CgtDetailDarkButtonSubTheme
]

{ #category : #'class defaults' }
CgtDetailDarkTheme class >> colorsClass [
	^ BrGlamorousDarkThemeColors
]


{ #category : #'class defaults' }
CgtDetailDarkTheme class >> controlsThemeClass [
	^ CgtDetailDarkControlsSubTheme
]

{ #category : #'class defaults' }
CgtDetailDarkTheme class >> defaultThemeClass [
	^ BrGlamorousDefaultDarkTheme
]

{ #category : #'class defaults' }
CgtDetailDarkTheme class >> editorThemeClass [
	^ CgtDetailDarkEditorSubTheme
]


{ #category : #'class defaults' }
CgtDetailDarkTheme class >> headerThemeClass [
	^ BrGlamorousHeaderDarkTheme
]


{ #category : #'class defaults' }
CgtDetailDarkTheme class >> interactionThemeClass [
	^ CgtDetailDarkInteractionSubTheme
]

{ #category : #'class defaults' }
CgtDetailDarkTheme class >> surfacesThemeClass [
	^ CgtDetailDarkSurfacesSubTheme
]

{ #category : #'class defaults' }
CgtDetailDarkTheme class >> typographyThemeClass [
	^ CgtDetailDarkTypographySubTheme
]



{ #category : #'theme appearance' }
CgtDetailDarkTheme >> toggledAppearanceTheme [
	^ CgtDetailLightTheme appearanceState: self appearanceState
]

{ #category : #'theme appearance' }
CgtDetailDarkTheme >> themeAppearanceIconName [
	^ #moon
]
