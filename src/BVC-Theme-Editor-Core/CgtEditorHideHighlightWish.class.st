Class {
	#name : 'CgtEditorHideHighlightWish',
	#superclass : 'BlEvent',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
	#comment : 'I am responsible for representing a request to clear any externally requested editor highlight. I carry intent, not behavior, so other objects can react to that request in a decoupled way.'
}

{ #category : 'sending' }
CgtEditorHideHighlightWish >> sendTo: anObject [
	anObject hideHighlightEvent: self
]
