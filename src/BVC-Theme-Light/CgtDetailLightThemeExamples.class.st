Class {
	#name : #CgtDetailLightThemeExamples,
	#superclass : #Object,
	#category : #'BVC-Theme-Light'
}

{ #category : #examples }
CgtDetailLightThemeExamples class >> inspectTheme [
	^ self theme inspect
]

{ #category : #examples }
CgtDetailLightThemeExamples class >> openThemeEditor [
	^ GtBlocThemeEditorElement new editTheme: self theme
]

{ #category : #examples }
CgtDetailLightThemeExamples class >> theme [
	^ CgtDetailLightTheme new
]

{ #category : #examples }
CgtDetailLightThemeExamples class >> appearanceStateInvalidatesTheme [
	| aTheme aGeneration |
	aTheme := CgtDetailLightTheme appearanceState: CgtAppearanceState new.
	aGeneration := aTheme generation.
	aTheme appearanceState themeColour: Color purple.
	self assert: aTheme generation equals: aGeneration + 1.
	^ aTheme
]

{ #category : #examples }
CgtDetailLightThemeExamples class >> detailLightReferenceValues [
	| aTheme |
	aTheme := self theme.
	self assert: aTheme label defaultTextForeground equals: Color black.
	self assert: aTheme label summaryTextForeground equals: (Color black alpha: 0.8).
	self assert: aTheme colors tertiaryTextColor equals: (Color black alpha: 0.55).
	self assert: aTheme default contentBackground equals: Color white.
	self assert: aTheme typography bodyFontSize equals: 13.
	self assert: aTheme typography supportingFontSize equals: 11.
	self assert: aTheme typography groupHeadingFontSize equals: 14.
	self assert: aTheme typography titleFontSize equals: 16.
	self assert: aTheme typography metadataFontSize equals: 11.
	self assert: aTheme label defaultTextForeground equals: (Color black alpha: 0.92).
	self assert: aTheme label metadataTextForeground equals: (Color black alpha: 0.45).
	^ aTheme
]

{ #category : #examples }
CgtDetailLightThemeExamples class >> sharedAppearanceStateSurvivesAppearanceChange [
	| aState aLightTheme aDarkTheme |
	aState := CgtAppearanceState new.
	aState
		themeColour: CgtPalette themePurple;
		textSelectionColour: CgtPalette textSelectionPurple.
	aLightTheme := CgtDetailLightTheme appearanceState: aState.
	aDarkTheme := CgtDetailDarkTheme appearanceState: aState.
	self assert: aLightTheme appearanceState themeColour equals: aDarkTheme appearanceState themeColour.
	self assert: aLightTheme appearanceState textSelectionColour equals: aDarkTheme appearanceState textSelectionColour.
	^ aLightTheme
]



{ #category : #examples }
CgtDetailLightThemeExamples class >> showcase [
	^ CgtThemeShowcaseElement new
		theme: self theme;
		build
]


{ #category : #examples }
CgtDetailLightThemeExamples class >> brickControlThemeValues [
	| aTheme resolve |
	aTheme := self theme.
	resolve := [ :aColor | aColor blocResolveColorForTheme: aTheme ].
	self assert: (resolve value: aTheme button defaultBackground) equals: (Color black alpha: 0.08).
	self assert: (resolve value: aTheme button defaultTextForeground) equals: (resolve value: aTheme label defaultTextForeground).
	self assert: (resolve value: aTheme button disabledBackgroundColor) equals: (Color black alpha: 0.06).
	self assert: (resolve value: aTheme button disabledTextColor) equals: (resolve value: aTheme colors disabledTextColor).
	self assert: aTheme button defaultBorderColor equals: Color transparent.
	self assert: (resolve value: aTheme editor defaultBackground) equals: (Color black alpha: 0.08).
	self assert: (resolve value: aTheme editor defaultTextForeground) equals: (resolve value: aTheme label defaultTextForeground).
	self assert: aTheme editor borderColor equals: Color transparent.
	self assert: (resolve value: aTheme editor focusedBorderColor) equals: (CgtPalette themeBlue alpha: 0.3).
	^ aTheme
]
