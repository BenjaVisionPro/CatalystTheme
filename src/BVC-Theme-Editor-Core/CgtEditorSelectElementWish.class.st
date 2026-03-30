"
#Editor Select Element Wish
I request that a specific element be selected by the Theme Editor. I carry the target element so the editor can apply its normal selection semantics.
"
Class {
	#name : 'CgtEditorSelectElementWish',
	#superclass : 'BlEvent',
	#instVars : [
		'element'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
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
