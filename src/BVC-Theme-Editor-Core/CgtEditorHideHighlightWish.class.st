"
#Editor Hide Highlight Wish
I request that an explicit highlight be removed. I exist so the editor can clear highlight state through an explicit event.
"
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
