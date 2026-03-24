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
	| t inverse |
	t := aProgress asFloat.
	t <= 0 ifTrue: [ ^ 0.0 ].
	t >= 1 ifTrue: [ ^ 1.0 ].
	inverse := 1.0 - t.
	^ 1.0 - (inverse * inverse * inverse * inverse * inverse)
]
