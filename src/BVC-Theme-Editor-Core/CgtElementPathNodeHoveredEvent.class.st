Class {
	#name : 'CgtElementPathNodeHoveredEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'element'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
	#comment : 'I am responsible for announcing that a path node is being hovered in the path selector. I carry the represented element so the editor can interpret that interaction semantically.'
}

{ #category : 'accessing' }
CgtElementPathNodeHoveredEvent >> element [
	^ element
]

{ #category : 'accessing' }
CgtElementPathNodeHoveredEvent >> element: anElement [
	element := anElement
]

{ #category : 'sending' }
CgtElementPathNodeHoveredEvent >> sendTo: anObject [
	anObject elementPathNodeHoveredEvent: self
]
