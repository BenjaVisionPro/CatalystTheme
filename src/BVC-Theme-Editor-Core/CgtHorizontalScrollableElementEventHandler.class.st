Class {
	#name : 'CgtHorizontalScrollableElementEventHandler',
	#superclass : 'BlScrollableElementEventHandler',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
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
