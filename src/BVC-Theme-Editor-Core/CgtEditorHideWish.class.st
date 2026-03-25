Class {
	#name : 'CgtEditorHideWish',
	#superclass : 'BlEvent',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'sending' }
CgtEditorHideWish >> sendTo: anObject [
	anObject hideThemeEditorEvent: self
]
