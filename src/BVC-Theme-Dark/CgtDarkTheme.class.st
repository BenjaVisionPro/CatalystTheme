Class {
	#name : #CgtDarkTheme,
	#superclass : #CgtAbstractTheme,
	#category : #'BVC-Theme-Dark'
}

{ #category : #'class defaults' }
CgtDarkTheme class >> buttonThemeClass [
	^ BrGlamorousButtonDarkTheme
]

{ #category : #'class defaults' }
CgtDarkTheme class >> colorsClass [
	^ BrGlamorousDarkThemeColors
]

{ #category : #'class defaults' }
CgtDarkTheme class >> defaultThemeClass [
	^ BrGlamorousDefaultDarkTheme
]

{ #category : #'class defaults' }
CgtDarkTheme class >> editorThemeClass [
	^ BrGlamorousEditorDarkTheme
]


{ #category : #'class defaults' }
CgtDarkTheme class >> headerThemeClass [
	^ BrGlamorousHeaderDarkTheme
]

{ #category : #'class defaults' }
CgtDarkTheme class >> surfacesThemeClass [
	^ CgtDarkSurfacesTheme
]

{ #category : #'class defaults' }
CgtDarkTheme class >> typographyThemeClass [
	^ CgtDarkTypographyTheme
]
