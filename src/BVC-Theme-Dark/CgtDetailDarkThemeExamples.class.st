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
	self assert: aTheme typography primaryForeground equals: Color white.
	self assert: aTheme typography secondaryForeground equals: (Color white alpha: 0.8).
	self assert: aTheme typography tertiaryForeground equals: (Color white alpha: 0.55).
	self assert: aTheme typography quaternaryForeground equals: (Color white alpha: 0.35).
	self assert: aTheme typography disabledForeground equals: (Color white alpha: 0.22).
	self assert: aTheme typography titleForeground equals: (Color white alpha: 0.92).
	self assert: aTheme typography metadataForeground equals: (Color white alpha: 0.45).
	self assert: aTheme surfaces cardTint equals: (Color white alpha: 7.0 / 255.0).
	self assert: aTheme surfaces separatorTint equals: (Color white alpha: 19.0 / 248.0).
	self assert: aTheme interaction subtleBackgroundTint equals: (Color white alpha: 0.06).
	self assert: aTheme interaction controlBackgroundTint equals: (Color white alpha: 0.08).
	self assert: aTheme interaction popupBackgroundTint equals: (Color white alpha: 0.10).
	self assert: aTheme interaction hoveredBackgroundTint equals: (Color white alpha: 0.12).
	self assert: aTheme interaction pressedBackgroundTint equals: (Color white alpha: 0.16).
	self assert: aTheme interaction focusedBorderColor equals: (CgtPalette themeBlue alpha: 0.3).
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
