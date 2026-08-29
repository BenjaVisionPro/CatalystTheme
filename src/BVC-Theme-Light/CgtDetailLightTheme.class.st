Class {
	#name : #CgtDetailLightTheme,
	#superclass : #CgtTheme,
	#category : #'BVC-Theme-Light'
}

{ #category : #'class defaults' }
CgtDetailLightTheme class >> buttonThemeClass [
	^ CgtDetailLightButtonSubTheme
]

{ #category : #'class defaults' }
CgtDetailLightTheme class >> colorsClass [
	^ BrGlamorousLightThemeColors
]


{ #category : #'class defaults' }
CgtDetailLightTheme class >> controlsThemeClass [
	^ CgtDetailLightControlsSubTheme
]

{ #category : #'class defaults' }
CgtDetailLightTheme class >> defaultThemeClass [
	^ BrGlamorousDefaultLightTheme
]

{ #category : #'class defaults' }
CgtDetailLightTheme class >> editorThemeClass [
	^ CgtDetailLightEditorSubTheme
]


{ #category : #'class defaults' }
CgtDetailLightTheme class >> headerThemeClass [
	^ BrGlamorousHeaderLightTheme
]


{ #category : #'class defaults' }
CgtDetailLightTheme class >> interactionThemeClass [
	^ CgtDetailLightInteractionSubTheme
]

{ #category : #'class defaults' }
CgtDetailLightTheme class >> surfacesThemeClass [
	^ CgtDetailLightSurfacesSubTheme
]

{ #category : #'class defaults' }
CgtDetailLightTheme class >> typographyThemeClass [
	^ CgtDetailLightTypographySubTheme
]



{ #category : #'theme appearance' }
CgtDetailLightTheme >> toggledAppearanceTheme [
	^ CgtDetailDarkTheme appearanceState: self appearanceState
]

{ #category : #'theme appearance' }
CgtDetailLightTheme >> themeAppearanceIconName [
	^ #sunBright
]
