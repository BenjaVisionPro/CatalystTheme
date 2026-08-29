Class {
	#name : #CgtAppearanceStateExamples,
	#superclass : #Object,
	#category : #'BVC-Theme-Core'
}

{ #category : #examples }
CgtAppearanceStateExamples >> manualAngleIsRetainedWhileUsingTimeOfDay [
	<gtExample>
	| state manualDirection |
	state := CgtAppearanceState new.
	state lightDirectionDegrees: 180.
	manualDirection := state lightDirection.
	state useTimeOfDay: true.
	self assert: state lightDirection equals: manualDirection.
	state useTimeOfDay: false.
	self assert: state effectiveLightDirection equals: manualDirection.
	^ state
]

{ #category : #examples }
CgtAppearanceStateExamples >> manualLightDirection [
	<gtExample>
	| state |
	state := CgtAppearanceState new.
	state
		useTimeOfDay: false;
		lightDirectionDegrees: 90.
	self assert: state effectiveLightDirection equals: state lightDirection.
	self assert: (state lightDirectionDegrees - 90) abs < 0.000001.
	^ state
]

{ #category : #examples }
CgtAppearanceStateExamples >> timeOfDayUsesDerivedDirection [
	<gtExample>
	| state |
	state := CgtAppearanceState new.
	state useTimeOfDay: true.
	self assert: state effectiveLightDirection isNotNil.
	^ state
]


{ #category : #examples }
CgtAppearanceStateExamples >> themeColourDescriptionsUseFoundationPickers [
	<gtExample>
	| state themeColourDescription textSelectionDescription |
	state := CgtAppearanceState new.
	themeColourDescription := state themeColourDescription.
	textSelectionDescription := state textSelectionColourDescription.
	self assert: themeColourDescription class equals: MASingleOptionDescription.
	self assert: themeColourDescription options equals: CgtPalette themeColours.
	self assert: themeColourDescription isRequired.
	self assert: textSelectionDescription class equals: MASingleOptionDescription.
	self assert: textSelectionDescription options equals: ({ nil } , CgtPalette textSelectionColours).
	self assert: (CgtPalette textSelectionNameFor: nil) equals: 'Automatic'.
	self assert: state textSelectionColour isNil.
	self assert: state effectiveTextSelectionColour equals: CgtPalette textSelectionBlue.
	state themeColour: CgtPalette themePurple.
	self assert: state effectiveTextSelectionColour equals: CgtPalette textSelectionPurple.
	state textSelectionColour: CgtPalette textSelectionGreen.
	self assert: state effectiveTextSelectionColour equals: CgtPalette textSelectionGreen.
	^ state
]
