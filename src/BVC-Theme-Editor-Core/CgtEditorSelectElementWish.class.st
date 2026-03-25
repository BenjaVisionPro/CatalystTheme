Class {
	#name : #CgtEditorSelectElementWish,
	#superclass : #BlEvent,
	#instVars : [
		'element'
	],
	#category : #'BVC-Theme-Editor-Core'
}

{ #category : #accessing }
CgtEditorSelectElementWish >> element [
	^ element
]

{ #category : #accessing }
CgtEditorSelectElementWish >> element: anObject [
	element := anObject
]

{ #category : #sending }
CgtEditorSelectElementWish >> sendTo: anObject [
	anObject selectElementEvent: self
]
