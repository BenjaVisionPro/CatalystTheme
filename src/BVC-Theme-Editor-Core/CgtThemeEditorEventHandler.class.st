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
CgtThemeEditorEventHandler >> childToEditAt: aPoint in: aTargetElement ifFound: aFoundBlock ifNone: aNoneBlock [
	| theChildrenAt |
	theChildrenAt := aTargetElement withAllLeafChildrenAt: aPoint.
	editor overlay ifNotNil: [ :anOverlay |
		theChildrenAt := theChildrenAt copyWithout: anOverlay ].
	theChildrenAt := (theChildrenAt reject: [ :each | self isToolingElement: each ])
		sorted: [ :a :b | a compositionDepth > b compositionDepth ].
	theChildrenAt ifEmpty: [ ^ aNoneBlock value ].
	^ aFoundBlock value: theChildrenAt first
]

{ #category : 'event handling' }
CgtThemeEditorEventHandler >> clickEvent: aClickEvent [
	| anElement |
	anElement := self
		childToEditAt: aClickEvent localPosition
		in: aClickEvent currentTarget
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
	^ { BlMouseMoveEvent. BlClickEvent }
]

{ #category : 'private - testing' }
CgtThemeEditorEventHandler >> isToolingElement: anElement [
	| current |
	current := anElement.
	[ current notNil ] whileTrue: [
		(current == editor overlay or: [ current elementId = CgtThemeEditorToggleElementId uniqueInstance ])
			ifTrue: [ ^ true ].
		current := current parent ].
	^ false
]

{ #category : 'event handling' }
CgtThemeEditorEventHandler >> mouseMoveEvent: aMouseMoveEvent [
	| anElement |
	anElement := self
		childToEditAt: aMouseMoveEvent localPosition
		in: aMouseMoveEvent currentTarget
		ifFound: #yourself
		ifNone: [ nil ].
	editor highlightedElement: anElement
]
