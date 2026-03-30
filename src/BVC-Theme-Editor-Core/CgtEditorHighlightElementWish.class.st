"
#Editor Highlight Element Wish
I request that a specific element be highlighted by the Theme Editor. I carry the target element so the editor can apply an explicit highlight.
"
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
