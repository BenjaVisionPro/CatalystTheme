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
