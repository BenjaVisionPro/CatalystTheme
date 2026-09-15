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
	| aTheme resolve |
	aTheme := self theme.
	resolve := [ :aColor | aColor blocResolveColorForTheme: aTheme ].
	self assert: (resolve value: aTheme label defaultTextForeground) equals: aTheme colors primaryTextColor.
	self assert: (resolve value: aTheme label summaryTextForeground) equals: aTheme colors secondaryTextColor.
	self assert: (resolve value: aTheme label supportingTextForeground) equals: aTheme colors tertiaryTextColor.
	self assert: (resolve value: aTheme label metadataTextForeground) equals: aTheme colors secondaryTextColor.
	self assert: aTheme typography bodyFontSize equals: 13.
	self assert: aTheme typography supportingFontSize equals: 11.
	self assert: aTheme typography groupHeadingFontSize equals: 14.
	self assert: aTheme typography titleFontSize equals: 16.
	self assert: aTheme typography metadataFontSize equals: 11.
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
