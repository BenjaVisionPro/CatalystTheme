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
	self assert: aTheme surfaces baseBackground equals: Color white.
	self
		assert: aTheme surfaces cardTint
		equals: (Color black alpha: 7.0 / 255.0).
	self
		assert: aTheme surfaces separatorTint
		equals: (Color black alpha: 19.0 / 248.0).
	self assert: aTheme typography bodyFontSize equals: 13.
	self assert: aTheme typography supportingFontSize equals: 11.
	self assert: aTheme typography groupHeadingFontSize equals: 14.
	self assert: aTheme interaction subtleBackgroundTint equals: (Color black alpha: 0.06).
	self assert: aTheme interaction controlBackgroundTint equals: (Color black alpha: 0.08).
	self assert: aTheme interaction popupBackgroundTint equals: (Color black alpha: 0.10).
	self assert: aTheme interaction hoveredBackgroundTint equals: (Color black alpha: 0.12).
	self assert: aTheme interaction pressedBackgroundTint equals: (Color black alpha: 0.16).
	self assert: aTheme interaction focusedBorderColor equals: (CgtPalette highlightBlue alpha: 0.3).
	self assert: aTheme controls sliderTrackTint equals: (Color black alpha: 0.14).
	self assert: aTheme controls sliderThumbBackground equals: Color white.
	self assert: aTheme controls sliderThumbBorderTint equals: (Color black alpha: 0.16).
	self assert: aTheme controls sliderTickTint equals: (Color black alpha: 0.22).
	self assert: aTheme controls switchInactiveTrackTint equals: (Color black alpha: 35.0 / 255.0).
	self assert: aTheme controls switchThumbBackground equals: Color white.
	self assert: aTheme controls inactiveIconForeground equals: (Color black alpha: 0.68).
	self assert: aTheme controls controlIndicatorForeground equals: (Color black alpha: 0.72).
	self assert: aTheme controls tagBackgroundTint equals: (Color black alpha: 0.06).
	self assert: aTheme controls tagEditorBackground equals: (Color white alpha: 0.9).
	self assert: aTheme highlight foregroundColor equals: Color white.
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


