Class {
	#name : #BrGtDarkTheme,
	#superclass : #BrGtAbstractTheme,
	#category : #'BVC-Theme-Dark'
}

{ #category : #'class defaults' }
BrGtDarkTheme class >> buttonThemeClass [
	^ BrGtButtonDarkTheme
]

{ #category : #'class defaults' }
BrGtDarkTheme class >> colorsClass [
	^ BrGtDarkThemeColors
]

{ #category : #'class defaults' }
BrGtDarkTheme class >> defaultThemeClass [
	^ BrGtDefaultDarkTheme
]

{ #category : #'class defaults' }
BrGtDarkTheme class >> editorThemeClass [
	^ BrGtEditorDarkTheme
]

{ #category : #'class defaults' }
BrGtDarkTheme class >> headerThemeClass [
	^ BrGtHeaderDarkTheme
]
