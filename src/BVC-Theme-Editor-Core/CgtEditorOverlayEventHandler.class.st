"
#Editor Overlay Event Handler
I am the event handler attached to the overlay itself. I am responsible for forwarding raw overlay events in the narrow way the overlay needs, without turning the overlay into an interaction brain.
"
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
	self overlay updatePositions
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
