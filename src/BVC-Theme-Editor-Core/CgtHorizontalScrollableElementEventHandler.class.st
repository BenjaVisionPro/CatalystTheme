Class {
	#name : 'CgtHorizontalScrollableElementEventHandler',
	#superclass : 'BlScrollableElementEventHandler',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
	#comment : 'I am responsible for adapting raw scrolling input into horizontal scrolling behavior for an element. I exist so horizontal path navigation behavior stays out of unrelated UI objects.'
}

{ #category : 'mouse handlers' }
CgtHorizontalScrollableElementEventHandler >> gestureScrollEvent: anEvent [
	| aScrollHappened |
	aScrollHappened := anEvent currentTarget scrollBy: (anEvent vector negated * 400).
	anEvent consumed: aScrollHappened
]

{ #category : 'mouse handlers' }
CgtHorizontalScrollableElementEventHandler >> mouseWheelEvent: anEvent [
	| aScrollHappened |
	"I implement touch support, so ignore fake mouse wheel events"
	anEvent isTouch ifTrue: [ ^ self ].
	aScrollHappened := anEvent currentTarget scrollBy: (anEvent vector negated * (20 @ 20 negated)).
	anEvent consumed: aScrollHappened
]
