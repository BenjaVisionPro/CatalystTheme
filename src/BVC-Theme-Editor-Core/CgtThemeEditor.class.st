Class {
	#name : #CgtThemeEditor,
	#superclass : #Object,
	#instVars : [
		'targetElement',
		'overlay',
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

{ #category : #accessing }
CgtThemeEditor >> isOpen [
	^ isOpen = true
]

{ #category : #accessing }
CgtThemeEditor >> overlay [
	^ overlay
]

{ #category : #initialization }
CgtThemeEditor >> initialize [
	super initialize.
	isOpen := false
]

{ #category : #opening }
CgtThemeEditor >> open [
	self isOpen ifTrue: [ ^ self ].
	overlay := CgtThemeEditorOverlay on: targetElement.
	isOpen := true
]

{ #category : #closing }
CgtThemeEditor >> close [
	self isOpen ifFalse: [ ^ self ].
	overlay ifNotNil: [ overlay detach ].
	overlay := nil.
	isOpen := false
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
