Class {
	#name : 'CgtEditorHighlightElementWish',
	#superclass : 'BlEvent',
	#instVars : [
		'element'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
	#comment : 'I am responsible for representing a request to highlight a specific element in the editor. I carry the target element so the editor infrastructure can apply that intent without embedding the behavior in the sender.'
}

{ #category : 'accessing' }
CgtEditorHighlightElementWish >> element [
	^ element
]

{ #category : 'accessing' }
CgtEditorHighlightElementWish >> element: anObject [
	element := anObject
]

{ #category : 'sending' }
CgtEditorHighlightElementWish >> sendTo: anObject [
	anObject highlightElementEvent: self
]
