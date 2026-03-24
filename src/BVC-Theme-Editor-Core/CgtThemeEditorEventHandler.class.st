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
	theChildrenAt := self leafChildrenToEditAt: aPoint in: aTargetElement.
	theChildrenAt ifEmpty: [ ^ aNoneBlock value ].
	^ aFoundBlock value: theChildrenAt first
]

{ #category : 'private - accessing' }
CgtThemeEditorEventHandler >> leafChildrenToEditAt: aPoint in: aTargetElement [
	| theChildrenAt |
	theChildrenAt := OrderedCollection new.
	aTargetElement children reversed do: [ :eachChild |
		(self isToolingElement: eachChild) ifFalse: [
			eachChild
				withAllLeafChildrenAt: (eachChild parentPointToLocal: aPoint)
				do: [ :eachLeaf |
					(self isToolingElement: eachLeaf) ifFalse: [ theChildrenAt add: eachLeaf ] ] ] ].
	^ theChildrenAt asArray sorted: [ :a :b | a compositionDepth > b compositionDepth ]
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
		(current == editor overlay or: [ current id = CgtThemeEditorOverlayElementId uniqueInstance ])
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
