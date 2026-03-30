Class {
	#name : 'CgtElementPathNodeSelectedEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'element'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
	#comment : 'I am responsible for announcing that a path node was selected in the path selector. I carry the represented element so the editor can apply its selection policy explicitly.'
}

{ #category : 'accessing' }
CgtElementPathNodeSelectedEvent >> element [
	^ element
]

{ #category : 'accessing' }
CgtElementPathNodeSelectedEvent >> element: anElement [
	element := anElement
]

{ #category : 'sending' }
CgtElementPathNodeSelectedEvent >> sendTo: anObject [
	anObject elementPathNodeSelectedEvent: self
]
