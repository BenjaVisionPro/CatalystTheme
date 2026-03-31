"
#Matcher Transition Policy
I provide timing and motion policy for matcher structural transitions. I am responsible for reveal/collapse animation values and orientation-aware leading-side expansion semantics, not for matcher semantics.
"
Class {
	#name : 'CgtMatcherTransitionPolicy',
	#superclass : 'Object',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

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
CgtMatcherTransitionPolicy >> graphRevealOffsetForOrientation: anOrientation [
	anOrientation = #horizontal ifTrue: [ ^ -24 @ 0 ].
	^ 0 @ -24
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
CgtMatcherTransitionPolicy >> leadingExpansionSideForOrientation: anOrientation [
	anOrientation = #horizontal ifTrue: [ ^ #left ].
	^ #up
]
