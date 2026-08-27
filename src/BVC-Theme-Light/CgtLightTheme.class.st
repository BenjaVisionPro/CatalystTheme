Class {
	#name : #CgtLightTheme,
	#superclass : #CgtAbstractTheme,
	#category : #'BVC-Theme-Light'
}

{ #category : #'class defaults' }
CgtLightTheme class >> buttonThemeClass [
	^ BrGlamorousButtonLightTheme
]

{ #category : #'class defaults' }
CgtLightTheme class >> colorsClass [
	^ BrGlamorousLightThemeColors
]

{ #category : #'class defaults' }
CgtLightTheme class >> defaultThemeClass [
	^ BrGlamorousDefaultLightTheme
]

{ #category : #'class defaults' }
CgtLightTheme class >> editorThemeClass [
	^ BrGlamorousEditorLightTheme
]

{ #category : #'class defaults' }
CgtLightTheme class >> headerThemeClass [
	^ BrGlamorousHeaderLightTheme
]
