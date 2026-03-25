Class {
	#name : 'CgtEditorHideHighlightWish',
	#superclass : 'BlEvent',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'sending' }
CgtEditorHideHighlightWish >> sendTo: anObject [
	anObject hideHighlightEvent: self
]
