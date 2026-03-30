"
#Editor Hide Wish
I request that the Theme Editor be hidden. I exist so that editor lifecycle changes can be expressed explicitly as events.
"
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
