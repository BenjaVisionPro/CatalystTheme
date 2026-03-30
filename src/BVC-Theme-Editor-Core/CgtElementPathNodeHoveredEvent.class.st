"
#Element Path Node Hovered Event
I announce that a path node in the selector is being hovered. I carry the concrete element represented by that node so the editor can respond explicitly.
"
Class {
	#name : 'CgtElementPathNodeHoveredEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'element'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
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
