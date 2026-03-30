"
#Element Path Node Selected Event
I announce that a path node in the selector has been selected. I carry the concrete element represented by that node so the editor can apply its normal selection policy.
"
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
