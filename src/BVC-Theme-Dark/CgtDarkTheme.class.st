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
	^ CgtDarkThemeColors
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
CgtDarkTheme class >> itemThemeClass [
	^ CgtDarkItemTheme
]

{ #category : #initialization }
CgtDarkTheme >> initializePalettes [
	uiPalette := CgtDarkUIPalette new.
	codePalette := CgtDarkCodePalette new
]
