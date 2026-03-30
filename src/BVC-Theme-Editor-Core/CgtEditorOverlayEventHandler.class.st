Class {
	#name : 'CgtEditorOverlayEventHandler',
	#superclass : 'BlCustomEventHandler',
	#instVars : [
		'overlay'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
	#comment : 'I am responsible for handling low-level events that are specific to the overlay element itself. I support the overlay''s input behavior without owning editor semantics or the meaning of selection and hover.'
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
