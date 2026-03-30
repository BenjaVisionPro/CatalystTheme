"
#Matcher Transition Policy
I provide timing and motion policy for matcher structural transitions. I am responsible for reveal/collapse animation values, corridor-orientation-aware expansion semantics, and leading-side offset values, not for matcher semantics.
"
Class {
	#name : 'CgtMatcherTransitionPolicy',
	#superclass : 'Object',
	#instVars : [
		'corridorOrientation'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtMatcherTransitionPolicy >> initialize [
	super initialize.
	corridorOrientation := #horizontal
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> corridorOrientation [
	^ corridorOrientation ifNil: [ corridorOrientation := #horizontal ]
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> corridorOrientation: aSymbol [
	corridorOrientation := aSymbol ifNil: [ #horizontal ].
	^ self
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> structuralRefreshDuration [
	^ 220 milliSeconds
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> hoverDuration [
	^ 140 milliSeconds
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> revealDuration [
	^ 240 milliSeconds
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> collapseDuration [
	^ 200 milliSeconds
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> graphRevealOffsetX [
	^ -24
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> graphRevealOffsetY [
	^ -20
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> graphRevealStartOpacity [
	^ 0.0
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> graphRevealEndOpacity [
	^ 1.0
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> keepsFollowingNodeFixed [
	^ true
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> expansionDirection [
	^ self corridorOrientation = #vertical
		ifTrue: [ #up ]
		ifFalse: [ #left ]
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> durationFromExpandedGapCount: aPreviousCount to: aNewCount [
	aNewCount > aPreviousCount ifTrue: [ ^ self revealDuration ].
	aNewCount < aPreviousCount ifTrue: [ ^ self collapseDuration ].
	^ self structuralRefreshDuration
]

{ #category : 'layout' }
CgtMatcherTransitionPolicy >> leadingMarginForProgress: aProgress [
	| clamped |
	clamped := (aProgress max: 0.0) min: 1.0.
	self corridorOrientation = #vertical ifTrue: [
		^ BlInsets top: (self graphRevealOffsetY abs * clamped) asInteger right: 0 bottom: 0 left: 0 ].
	^ BlInsets top: 0 right: 0 bottom: 0 left: (self graphRevealOffsetX abs * clamped) asInteger
]
