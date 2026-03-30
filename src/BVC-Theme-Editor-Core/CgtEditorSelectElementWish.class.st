Class {
	#name : 'CgtEditorSelectElementWish',
	#superclass : 'BlEvent',
	#instVars : [
		'element'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
	#comment : 'I am responsible for representing a request to select a specific element in the editor. I communicate that intent as data so the editor infrastructure can react without direct coupling.'
}

{ #category : 'accessing' }
CgtEditorSelectElementWish >> element [
	^ element
]

{ #category : 'accessing' }
CgtEditorSelectElementWish >> element: anObject [
	element := anObject
]

{ #category : 'sending' }
CgtEditorSelectElementWish >> sendTo: anObject [
	anObject selectElementEvent: self
]
