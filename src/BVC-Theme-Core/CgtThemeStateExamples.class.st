Class {
	#name : #CgtThemeStateExamples,
	#superclass : #Object,
	#category : #'BVC-Theme-Core'
}

{ #category : #examples }
CgtThemeStateExamples >> manualAngleIsRetainedWhileUsingTimeOfDay [
	<gtExample>
	| state manualDirection |
	state := CgtThemeState new.
	state lightDirectionDegrees: 180.
	manualDirection := state lightDirection.
	state useTimeOfDay: true.
	self assert: state lightDirection equals: manualDirection.
	state useTimeOfDay: false.
	self assert: state effectiveLightDirection equals: manualDirection.
	^ state
]

{ #category : #examples }
CgtThemeStateExamples >> manualLightDirection [
	<gtExample>
	| state |
	state := CgtThemeState new.
	state
		useTimeOfDay: false;
		lightDirectionDegrees: 90.
	self assert: state effectiveLightDirection equals: state lightDirection.
	self assert: (state lightDirectionDegrees - 90) abs < 0.000001.
	^ state
]

{ #category : #examples }
CgtThemeStateExamples >> timeOfDayUsesDerivedDirection [
	<gtExample>
	| state |
	state := CgtThemeState new.
	state useTimeOfDay: true.
	self assert: state effectiveLightDirection isNotNil.
	^ state
]
