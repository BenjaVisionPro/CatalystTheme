"
Fire the ""theme editor show wish"" from withing the graphical scene whose root has {{gtClass:CgtEditorEventHandler}} event handler to transform the scene into debug mode

"
Class {
	#name : 'CgtEditorShowWish',
	#superclass : 'BlEvent',
	#instVars : [
		'elementToSelect',
		'sceneExtent'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
	#comment : 'I am responsible for representing a request to show the editor. I let other objects express that intent without needing to know how the editor is mounted or animated.'
}

{ #category : 'accessing' }
CgtEditorShowWish >> elementToSelect [
	^ elementToSelect
]

{ #category : 'accessing' }
CgtEditorShowWish >> elementToSelect: anObject [
	elementToSelect := anObject
]

{ #category : 'accessing' }
CgtEditorShowWish >> sceneExtent [
	^ sceneExtent
]

{ #category : 'accessing' }
CgtEditorShowWish >> sceneExtent: anObject [
	sceneExtent := anObject
]

{ #category : 'sending' }
CgtEditorShowWish >> sendTo: anObject [
	anObject showThemeEditorEvent: self
]
