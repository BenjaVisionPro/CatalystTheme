Class {
	#name : #CgtThemeEditor,
	#superclass : #Object,
	#instVars : [
		'targetElement',
		'overlay',
		'eventHandler',
		'isOpen'
	],
	#category : #'BVC-Theme-Editor-Core'
}

{ #category : #'instance creation' }
CgtThemeEditor class >> on: anElement [
	^ self new
		targetElement: anElement;
		open;
		yourself
]

{ #category : #closing }
CgtThemeEditor >> close [
	self isOpen ifFalse: [ ^ self ].
	overlay ifNotNil: [ overlay detach ].
	eventHandler ifNotNil: [ targetElement removeEventHandler: eventHandler ].
	overlay := nil.
	eventHandler := nil.
	isOpen := false
]

{ #category : #accessing }
CgtThemeEditor >> eventHandler [
	^ eventHandler
]

{ #category : #initialization }
CgtThemeEditor >> initialize [
	super initialize.
	isOpen := false
]

{ #category : #accessing }
CgtThemeEditor >> isOpen [
	^ isOpen = true
]

{ #category : #opening }
CgtThemeEditor >> open [
	self isOpen ifTrue: [ ^ self ].
	overlay := CgtThemeEditorOverlay on: targetElement.
	eventHandler := CgtThemeEditorEventHandler new.
	eventHandler editor: self.
	targetElement addEventHandler: eventHandler.
	isOpen := true
]

{ #category : #accessing }
CgtThemeEditor >> overlay [
	^ overlay
]

{ #category : #accessing }
CgtThemeEditor >> targetElement [
	^ targetElement
]

{ #category : #accessing }
CgtThemeEditor >> targetElement: anElement [
	targetElement := anElement
]

{ #category : #toggling }
CgtThemeEditor >> toggle [
	self isOpen
		ifTrue: [ self close ]
		ifFalse: [ self open ]
]
