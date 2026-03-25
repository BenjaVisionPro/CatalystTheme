"
Fire the ""theme editor show wish"" from withing the graphical scene whose root has {{gtClass:CgtEditorEventHandler}} event handler to transform the scene into debug mode

"
Class {
	#name : #CgtEditorShowWish,
	#superclass : #BlEvent,
	#instVars : [
		'elementToSelect',
		'sceneExtent'
	],
	#category : #'BVC-Theme-Editor-Core'
}

{ #category : #accessing }
CgtEditorShowWish >> elementToSelect [
	^ elementToSelect
]

{ #category : #accessing }
CgtEditorShowWish >> elementToSelect: anObject [
	elementToSelect := anObject
]

{ #category : #accessing }
CgtEditorShowWish >> sceneExtent [
	^ sceneExtent
]

{ #category : #accessing }
CgtEditorShowWish >> sceneExtent: anObject [
	sceneExtent := anObject
]

{ #category : #sending }
CgtEditorShowWish >> sendTo: anObject [
	anObject showThemeEditorEvent: self
]
