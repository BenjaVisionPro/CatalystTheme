Class {
	#name : 'CgtThemeEditorEventHandler',
	#superclass : 'BlCustomEventHandler',
	#instVars : [
		'editor'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtThemeEditorEventHandler >> editor [
	^ editor
]

{ #category : 'accessing' }
CgtThemeEditorEventHandler >> editor: aThemeEditor [
	editor := aThemeEditor
]

{ #category : 'api - accessing' }
CgtThemeEditorEventHandler >> eventsToHandle [
	^ #()
]
