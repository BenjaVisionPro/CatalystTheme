Class {
	#name : #CgtLightThemeExamples,
	#superclass : #Object,
	#category : #'BVC-Theme-Light'
}

{ #category : #examples }
CgtLightThemeExamples class >> inspectTheme [
	^ self theme inspect
]

{ #category : #examples }
CgtLightThemeExamples class >> openThemeEditor [
	^ GtBlocThemeEditorElement new editTheme: self theme
]

{ #category : #examples }
CgtLightThemeExamples class >> theme [
	^ CgtLightTheme new
]

{ #category : #examples }
CgtLightThemeExamples class >> themeStateInvalidatesTheme [
	| aTheme aGeneration |
	aTheme := CgtLightTheme state: CgtThemeState new.
	aGeneration := aTheme generation.
	aTheme themeState highlightColor: Color purple.
	self assert: aTheme generation equals: aGeneration + 1.
	^ aTheme
]
