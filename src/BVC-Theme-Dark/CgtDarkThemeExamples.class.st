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
CgtDarkThemeExamples class >> proofChecklist [
	^ {
		'Outer chrome/background via CgtAbstractThemeColors'.
		'Content/background surfaces via BrGlamorousDefaultTheme bindings'.
		'Header background/text via CgtDarkHeaderTheme'.
		'Item selected/hovered/default colors via CgtAbstractItemTheme'.
		'Editor token colors via CgtDarkEditorTheme'.
		'Item refresh path through CgtAbstractTheme>>onThemeModified'
	}
]

{ #category : #examples }
CgtDarkThemeExamples class >> theme [
	^ CgtDarkTheme new
]
