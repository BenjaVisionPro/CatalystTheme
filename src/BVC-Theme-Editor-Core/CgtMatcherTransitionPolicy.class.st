"
#Matcher Transition Policy
I provide timing and motion policy for matcher structural transitions. I am responsible for reveal/collapse animation values and the default expansion direction, not for matcher semantics.
"
Class {
	#name : 'CgtMatcherTransitionPolicy',
	#superclass : 'Object',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> corridorOrientation [
	^ #horizontal
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
	^ #left
]


{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> durationFromExpandedGapCount: aPreviousCount to: aCurrentCount [
	aCurrentCount > aPreviousCount ifTrue: [ ^ self revealDuration ].
	aCurrentCount < aPreviousCount ifTrue: [ ^ self collapseDuration ].
	^ self structuralRefreshDuration
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> leadingMarginForProgress: aNumber [
	self corridorOrientation = #vertical ifTrue: [
		^ BlInsets top: ((1.0 - aNumber) * self graphRevealOffsetX abs) asInteger right: 0 bottom: 0 left: 0 ].
	^ BlInsets top: 0 right: 0 bottom: 0 left: ((1.0 - aNumber) * self graphRevealOffsetX abs) asInteger
]
