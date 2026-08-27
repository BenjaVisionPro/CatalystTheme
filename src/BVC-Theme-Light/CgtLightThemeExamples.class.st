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
CgtLightThemeExamples class >> foundationReferenceValues [
	| aTheme |
	aTheme := self theme.
	self assert: aTheme foundation primaryForeground equals: Color black.
	self assert: aTheme foundation secondaryForeground equals: (Color black alpha: 0.8).
	self assert: aTheme foundation tertiaryForeground equals: (Color black alpha: 0.55).
	self assert: aTheme foundation formBackground equals: Color white.
	self
		assert: aTheme foundation cardBackground
		equals: (Color r: 248 g: 248 b: 248 range: 255).
	self
		assert: aTheme foundation separatorColor
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
		highlightColor: CgtFoundationPalette highlightPurple;
		textHighlightColor: CgtFoundationPalette textHighlightPurple.
	aLightTheme := CgtLightTheme state: aState.
	aDarkTheme := CgtDarkTheme state: aState.
	self assert: aLightTheme foundation highlightColor equals: aDarkTheme foundation highlightColor.
	self assert: aLightTheme foundation textHighlightColor equals: aDarkTheme foundation textHighlightColor.
	^ aLightTheme
]
