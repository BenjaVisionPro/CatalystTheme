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

{ #category : #examples }
CgtLightThemeExamples class >> detailLightReferenceValues [
	| aTheme |
	aTheme := self theme.
	self assert: aTheme typography primaryForeground equals: Color black.
	self assert: aTheme typography secondaryForeground equals: (Color black alpha: 0.8).
	self assert: aTheme typography tertiaryForeground equals: (Color black alpha: 0.55).
	self assert: aTheme surfaces formBackground equals: Color white.
	self
		assert: aTheme surfaces cardBackground
		equals: (Color r: 248 g: 248 b: 248 range: 255).
	self
		assert: aTheme surfaces separatorColor
		equals: (Color r: 229 g: 229 b: 229 range: 255).
	self assert: aTheme typography bodyFontSize equals: 13.
	self assert: aTheme typography supportingFontSize equals: 11.
	self assert: aTheme typography groupHeadingFontSize equals: 14.
	^ aTheme
]

{ #category : #examples }
CgtLightThemeExamples class >> sharedThemeStateSurvivesAppearanceChange [
	| aState aLightTheme aDarkTheme |
	aState := CgtThemeState new.
	aState
		highlightColor: CgtPalette highlightPurple;
		textHighlightColor: CgtPalette textHighlightPurple.
	aLightTheme := CgtLightTheme state: aState.
	aDarkTheme := CgtDarkTheme state: aState.
	self assert: aLightTheme highlight color equals: aDarkTheme highlight color.
	self assert: aLightTheme highlight textColor equals: aDarkTheme highlight textColor.
	^ aLightTheme
]


