Class {
	#name : 'CgtElementPathNodeSelectedEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'element'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
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
