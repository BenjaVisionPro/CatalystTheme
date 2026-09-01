Class {
	#name : #CgtAppearanceStateMagritteExamples,
	#superclass : #Object,
	#category : #'BVC-Theme-GT-Examples'
}

{ #category : #examples }
CgtAppearanceStateMagritteExamples >> appearanceStateHasNoCompactIdentityContract [
	<gtExample>
	| state aDescription aMemento |
	state := CgtAppearanceState new.
	aDescription := state magritteDescription.
	self assert: aDescription compactIdentityReference isNil.
	aMemento := CFMaMemento model: state description: aDescription.
	self assert: aMemento magritteDescription compactIdentityReference isNil.
	^ aMemento
]
