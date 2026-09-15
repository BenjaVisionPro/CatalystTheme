Class {
	#name : #CgtDetailDarkThemeExamples,
	#superclass : #Object,
	#category : #'BVC-Theme-Dark'
}

{ #category : #examples }
CgtDetailDarkThemeExamples class >> inspectTheme [
	^ self theme inspect
]

{ #category : #examples }
CgtDetailDarkThemeExamples class >> openThemeEditor [
	^ GtBlocThemeEditorElement new editTheme: self theme
]

{ #category : #examples }
CgtDetailDarkThemeExamples class >> theme [
	^ CgtDetailDarkTheme new
]

{ #category : #examples }
CgtDetailDarkThemeExamples class >> detailDarkReferenceValues [
	| aTheme |
	aTheme := self theme.
	self assert: aTheme label defaultTextForeground equals: Color white.
	self assert: aTheme label summaryTextForeground equals: (Color white alpha: 0.8).
	self assert: aTheme colors tertiaryTextColor equals: (Color white alpha: 0.55).
	self assert: aTheme colors disabledTextColor equals: (Color white alpha: 0.35).
	self assert: aTheme colors disabledTextColor equals: (Color white alpha: 0.22).
	self assert: aTheme label defaultTextForeground equals: (Color white alpha: 0.92).
	self assert: aTheme label metadataTextForeground equals: (Color white alpha: 0.45).
	self assert: aTheme controls sliderTrackTint equals: (Color white alpha: 0.14).
	self assert: aTheme controls sliderThumbBackground equals: (Color white alpha: 0.86).
	self assert: aTheme controls sliderThumbBorderTint equals: (Color black alpha: 0.16).
	self assert: aTheme controls sliderTickTint equals: (Color white alpha: 0.22).
	self assert: aTheme controls switchInactiveTrackTint equals: (Color white alpha: 35.0 / 255.0).
	self assert: aTheme controls switchThumbBackground equals: (Color white alpha: 0.86).
	self assert: aTheme controls inactiveIconForeground equals: (Color white alpha: 0.68).
	self assert: aTheme controls controlIndicatorForeground equals: (Color white alpha: 0.72).
	self assert: aTheme controls tagBackgroundTint equals: (Color white alpha: 0.06).
	self assert: aTheme controls tagHoveredBackgroundTint equals: (Color white alpha: 0.12).
	self assert: aTheme controls tagEditorBackground equals: (Color black alpha: 0.10).
	^ aTheme
]

{ #category : #examples }
CgtDetailDarkThemeExamples class >> showcase [
	^ CgtThemeShowcaseElement new
		theme: self theme;
		build
]


{ #category : #examples }
CgtDetailDarkThemeExamples class >> brickControlThemeValues [
	| aTheme resolve |
	aTheme := self theme.
	resolve := [ :aColor | aColor blocResolveColorForTheme: aTheme ].
	self assert: (resolve value: aTheme button defaultBackground) equals: (Color white alpha: 0.08).
	self assert: (resolve value: aTheme button defaultTextForeground) equals: (resolve value: aTheme label defaultTextForeground).
	self assert: (resolve value: aTheme button disabledBackgroundColor) equals: (Color white alpha: 0.06).
	self assert: (resolve value: aTheme button disabledTextColor) equals: (resolve value: aTheme colors disabledTextColor).
	self assert: aTheme button defaultBorderColor equals: Color transparent.
	self assert: (resolve value: aTheme editor defaultBackground) equals: (Color white alpha: 0.08).
	self assert: (resolve value: aTheme editor defaultTextForeground) equals: (resolve value: aTheme label defaultTextForeground).
	self assert: aTheme editor borderColor equals: Color transparent.
	self assert: (resolve value: aTheme editor focusedBorderColor) equals: (CgtPalette themeBlue alpha: 0.3).
	^ aTheme
]
