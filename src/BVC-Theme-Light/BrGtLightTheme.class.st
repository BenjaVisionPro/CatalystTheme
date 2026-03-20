Class {
	#name : #BrGtLightTheme,
	#superclass : #BrGtAbstractTheme,
	#category : #'BVC-Theme-Light'
}

{ #category : #'class defaults' }
BrGtLightTheme class >> canBeDefault [
	^ true
]

{ #category : #'class defaults' }
BrGtLightTheme class >> buttonThemeClass [
	^ BrGtButtonLightTheme
]

{ #category : #'class defaults' }
BrGtLightTheme class >> colorsClass [
	^ BrGtLightThemeColors
]

{ #category : #'class defaults' }
BrGtLightTheme class >> defaultThemeClass [
	^ BrGtDefaultLightTheme
]

{ #category : #'class defaults' }
BrGtLightTheme class >> editorThemeClass [
	^ BrGtEditorLightTheme
]

{ #category : #'class defaults' }
BrGtLightTheme class >> headerThemeClass [
	^ BrGtHeaderLightTheme
]


{ #category : #'class defaults' }
BrGtLightTheme class >> itemThemeClass [
	^ BrGtItemLightTheme
]


{ #category : #'class defaults' }
BrGtLightTheme class >> labelThemeClass [
	^ BrGtLabelLightTheme
]
