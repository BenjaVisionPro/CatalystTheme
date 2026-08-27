Class {
	#name : #CgtDarkThemeExamples,
	#superclass : #Object,
	#category : #'BVC-Theme-Dark'
}

{ #category : #examples }
CgtDarkThemeExamples class >> inspectTheme [
	^ self theme inspect
]

{ #category : #examples }
CgtDarkThemeExamples class >> openThemeEditor [
	^ GtBlocThemeEditorElement new editTheme: self theme
]

{ #category : #examples }
CgtDarkThemeExamples class >> theme [
	^ CgtDarkTheme new
]
