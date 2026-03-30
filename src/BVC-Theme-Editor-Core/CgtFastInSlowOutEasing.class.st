"
#Fast In Slow Out Easing
I provide an easing curve used by Theme Editor animations. I am responsible for the timing shape of those transitions, not for the transitions themselves.
"
Class {
	#name : 'CgtFastInSlowOutEasing',
	#superclass : 'Object',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'instance creation' }
CgtFastInSlowOutEasing class >> new [
	^ super new
]

{ #category : 'interpolating' }
CgtFastInSlowOutEasing >> interpolate: aProgress [
	| t response |
	t := aProgress asFloat.
	t <= 0 ifTrue: [ ^ 0.0 ].
	t >= 1 ifTrue: [ ^ 1.0 ].

	response := 10.0.	"higher = faster start, longer tail"
	^ (1.0 - (response negated * t) exp) / (1.0 - response negated exp)
]
