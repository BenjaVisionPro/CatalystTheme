Class {
	#name : 'CgtThemeEditorOverlayEventHandler',
	#superclass : 'BlCustomEventHandler',
	#instVars : [
		'overlay'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'element handlers' }
CgtThemeEditorOverlayEventHandler >> elementAddedToSceneGraphEvent: anEvent [
	self overlay showElement: anEvent currentTarget.
	self overlay updatePositions
]

{ #category : 'element handlers' }
CgtThemeEditorOverlayEventHandler >> elementExtentChangedEvent: anEvent [
	self overlay updatePositions
]

{ #category : 'element handlers' }
CgtThemeEditorOverlayEventHandler >> elementPositionInSpaceChangedEvent: anEvent [
	self overlay updatePositions
]

{ #category : 'element handlers' }
CgtThemeEditorOverlayEventHandler >> elementRemovedFromSceneGraphEvent: anEvent [
	self overlay hideElement: anEvent currentTarget
]

{ #category : 'api - accessing' }
CgtThemeEditorOverlayEventHandler >> eventsToHandle [
	^ {
		BlElementPositionInSpaceChangedEvent.
		BlElementExtentChangedEvent.
		BlElementRemovedFromSceneGraphEvent.
		BlElementAddedToSceneGraphEvent }
]

{ #category : 'accessing' }
CgtThemeEditorOverlayEventHandler >> overlay [
	^ overlay
]

{ #category : 'accessing' }
CgtThemeEditorOverlayEventHandler >> overlay: anObject [
	overlay := anObject
]
