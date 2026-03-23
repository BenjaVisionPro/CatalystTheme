Class {
	#name : 'CgtThemeEditorEventHandler',
	#superclass : 'BlCustomEventHandler',
	#instVars : [
		'editor'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'private - accessing' }
CgtThemeEditorEventHandler >> childToStyleAt: aPoint in: aTargetElement ifFound: aFoundBlock ifNone: aNoneBlock [
	| theChildrenAt |
	theChildrenAt := aTargetElement withAllLeafChildrenAt: aPoint.
	editor overlay ifNotNil: [ :anOverlay |
		theChildrenAt := theChildrenAt copyWithout: anOverlay ].
	theChildrenAt := theChildrenAt reject: [ :each | each == editor overlay ].
	theChildrenAt := theChildrenAt sorted: [ :a :b | a compositionDepth > b compositionDepth ].
	theChildrenAt ifEmpty: [ ^ aNoneBlock value ].
	^ aFoundBlock value: theChildrenAt first
]

{ #category : 'event handling' }
CgtThemeEditorEventHandler >> clickEvent: aClickEvent [
	| anElement |
	anElement := self
		childToStyleAt: aClickEvent localPosition
		in: editor targetElement
		ifFound: #yourself
		ifNone: [ nil ].
	anElement ifNil: [ ^ self ].
	editor selectedElement: anElement.
	aClickEvent consumed: true
]

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
	^ {
		BlMouseMoveEvent.
		BlClickEvent }
]

{ #category : 'event handling' }
CgtThemeEditorEventHandler >> mouseMoveEvent: aMouseMoveEvent [
	| anElement |
	anElement := self
		childToStyleAt: aMouseMoveEvent localPosition
		in: editor targetElement
		ifFound: #yourself
		ifNone: [ nil ].
	editor highlightedElement: anElement
]
