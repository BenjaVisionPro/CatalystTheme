Class {
	#name : 'CgtEditorHideWish',
	#superclass : 'BlEvent',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
	#comment : 'I am responsible for representing a request to hide the editor. I let the editor infrastructure communicate that intent without coupling the sender to the handler that performs it.'
}

{ #category : 'sending' }
CgtEditorHideWish >> sendTo: anObject [
	anObject hideThemeEditorEvent: self
]
