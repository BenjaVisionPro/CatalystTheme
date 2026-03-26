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
CgtElementPathNode class >> element: anElement [
	^ self new
		element: anElement;
		yourself
]

{ #category : 'accessing' }
CgtElementPathNode >> element [
	^ element
]

{ #category : 'accessing' }
CgtElementPathNode >> element: anElement [
	element := anElement
]
