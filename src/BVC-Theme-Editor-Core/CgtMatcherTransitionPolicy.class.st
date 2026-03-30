"
#Matcher Transition Policy
I provide timing and motion policy for matcher structural transitions. I am responsible for reveal/collapse animation values and the default expansion direction, not for matcher semantics.
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
	^ self corridorOrientation = #horizontal
		ifTrue: [ -24 ]
		ifFalse: [ 0 ]
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> graphRevealOffsetY [
	^ self corridorOrientation = #vertical
		ifTrue: [ -24 ]
		ifFalse: [ 0 ]
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
CgtMatcherTransitionPolicy >> corridorOrientation [
	^ corridorOrientation ifNil: [ #horizontal ]
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> corridorOrientation: aSymbol [
	corridorOrientation := aSymbol.
	^ self
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> expansionDirection [
	^ self corridorOrientation = #horizontal
		ifTrue: [ #left ]
		ifFalse: [ #up ]
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> leadingMarginForProgress: aProgress [
	| left top |
	left := self graphRevealOffsetX * (1.0 - aProgress).
	top := self graphRevealOffsetY * (1.0 - aProgress).
	^ BlInsets top: top left: left bottom: 0 right: 0
]
