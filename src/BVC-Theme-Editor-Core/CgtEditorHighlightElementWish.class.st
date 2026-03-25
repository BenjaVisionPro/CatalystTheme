Class {
	#name : 'CgtEditorHighlightElementWish',
	#superclass : 'BlEvent',
	#instVars : [
		'element'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
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
