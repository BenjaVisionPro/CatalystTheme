Class {
	#name : 'CgtEditorOverlayEventHandler',
	#superclass : 'BlCustomEventHandler',
	#instVars : [
		'overlay'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'element handlers' }
CgtEditorOverlayEventHandler >> elementAddedToSceneGraphEvent: anEvent [
	self overlay showElement: anEvent currentTarget.
	self overlay updatePositions
]

{ #category : 'element handlers' }
CgtEditorOverlayEventHandler >> elementExtentChangedEvent: anEvent [
	self overlay updatePositions
]

{ #category : 'element handlers' }
CgtEditorOverlayEventHandler >> elementPositionInSpaceChangedEvent: anEvent [
	self overlay updatePositions
]

{ #category : 'element handlers' }
CgtEditorOverlayEventHandler >> elementRemovedFromSceneGraphEvent: anEvent [
	self overlay hideElement: anEvent currentTarget
]

{ #category : 'api - accessing' }
CgtEditorOverlayEventHandler >> eventsToHandle [
	^ {
		BlElementPositionInSpaceChangedEvent.
		BlElementExtentChangedEvent.
		BlElementRemovedFromSceneGraphEvent.
		BlElementAddedToSceneGraphEvent.
	}
]

{ #category : 'accessing' }
CgtEditorOverlayEventHandler >> overlay [
	^ overlay
]

{ #category : 'accessing' }
CgtEditorOverlayEventHandler >> overlay: anObject [
	overlay := anObject
]
