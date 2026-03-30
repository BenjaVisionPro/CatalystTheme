"
#Element Path Node
I represent one node in an element path. I am responsible for pairing a concrete element with its role inside the path so the path can be reasoned about and rendered cleanly.
"
Class {
	#name : 'CgtElementPathNode',
	#superclass : 'Object',
	#instVars : [
		'element'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'instance creation' }
CgtElementPathNode class >> on: anElement [
	^ self new element: anElement; yourself
]

{ #category : 'accessing' }
CgtElementPathNode >> element [
	^ element
]

{ #category : 'accessing' }
CgtElementPathNode >> element: anElement [
	element := anElement
]
