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
	self assert: aTheme typography titleFontSize equals: 16.
	self assert: aTheme typography metadataFontSize equals: 11.
	self assert: aTheme typography titleForeground equals: (Color black alpha: 0.92).
	self assert: aTheme typography metadataForeground equals: (Color black alpha: 0.45).
	self assert: aTheme interaction subtleBackgroundTint equals: (Color black alpha: 0.06).
	self assert: aTheme interaction controlBackgroundTint equals: (Color black alpha: 0.08).
	self assert: aTheme interaction popupBackgroundTint equals: (Color black alpha: 0.10).
	self assert: aTheme interaction hoveredBackgroundTint equals: (Color black alpha: 0.12).
	self assert: aTheme interaction pressedBackgroundTint equals: (Color black alpha: 0.16).
	self assert: aTheme interaction focusedBorderColor equals: (CgtPalette themeBlue alpha: 0.3).
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
	self assert: (resolve value: aTheme button defaultBackground) equals: (resolve value: aTheme interaction controlBackgroundTint).
	self assert: (resolve value: aTheme button defaultTextForeground) equals: (resolve value: aTheme typography primaryForeground).
	self assert: (resolve value: aTheme button disabledBackgroundColor) equals: (resolve value: aTheme interaction subtleBackgroundTint).
	self assert: (resolve value: aTheme button disabledTextColor) equals: (resolve value: aTheme typography disabledForeground).
	self assert: aTheme button defaultBorderColor equals: Color transparent.
	self assert: (resolve value: aTheme editor defaultBackground) equals: (resolve value: aTheme interaction controlBackgroundTint).
	self assert: (resolve value: aTheme editor defaultTextForeground) equals: (resolve value: aTheme typography primaryForeground).
	self assert: aTheme editor borderColor equals: Color transparent.
	self assert: (resolve value: aTheme editor focusedBorderColor) equals: (resolve value: aTheme interaction focusedBorderColor).
	^ aTheme
]
