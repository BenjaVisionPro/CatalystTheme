Class {
	#name : 'CgtElementPathNode',
	#superclass : 'Object',
	#instVars : [
		'element'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
	#comment : 'I am responsible for representing one node in an element path. I pair a concrete element with its place in the path so path-oriented UI and logic can reason about individual path members clearly.'
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
