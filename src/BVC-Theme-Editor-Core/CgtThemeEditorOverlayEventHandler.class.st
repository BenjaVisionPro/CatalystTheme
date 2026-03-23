Class {
	#name : #CgtThemeEditorOverlayEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'overlay'
	],
	#category : #'BVC-Theme-Editor-Core'
}

{ #category : #accessing }
CgtThemeEditorOverlayEventHandler >> overlay [
	^ overlay
]

{ #category : #accessing }
CgtThemeEditorOverlayEventHandler >> overlay: anOverlay [
	overlay := anOverlay
]
