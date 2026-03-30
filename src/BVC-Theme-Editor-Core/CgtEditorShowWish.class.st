"
#Editor Show Wish
I request that the Theme Editor be shown. I carry the information needed to open the editor in a particular scene configuration.
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
