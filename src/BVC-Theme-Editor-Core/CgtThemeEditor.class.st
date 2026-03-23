Class {
	#name : 'CgtThemeEditor',
	#superclass : 'Object',
	#instVars : [
		'targetElement',
		'overlay',
		'eventHandler',
		'isOpen',
		'highlightedElement',
		'selectedElement'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'instance creation' }
CgtThemeEditor class >> closeOn: anElement [
	| anEditor |
	anEditor := self editorOn: anElement.
	anEditor ifNil: [ ^ nil ].
	anEditor close.
	anElement userData removeKey: self userDataKey ifAbsent: [ ].
	^ nil
]

{ #category : 'instance creation' }
CgtThemeEditor class >> editorOn: anElement [
	^ anElement userData at: self userDataKey ifAbsent: [ nil ]
]

{ #category : 'instance creation' }
CgtThemeEditor class >> on: anElement [
	^ self new
		targetElement: anElement;
		open;
		yourself
]

{ #category : 'instance creation' }
CgtThemeEditor class >> openOn: anElement [
	| anEditor |
	anEditor := self editorOn: anElement.
	anEditor ifNotNil: [ ^ anEditor ].
	anEditor := self on: anElement.
	anElement userData at: self userDataKey put: anEditor.
	^ anEditor
]

{ #category : 'instance creation' }
CgtThemeEditor class >> toggleOn: anElement [
	^ (self editorOn: anElement)
		ifNil: [ self openOn: anElement ]
		ifNotNil: [ self closeOn: anElement ]
]

{ #category : 'instance creation' }
CgtThemeEditor class >> userDataKey [
	^ #cgtThemeEditor
]

{ #category : 'closing' }
CgtThemeEditor >> close [
	self isOpen ifFalse: [ ^ self ].
	overlay ifNotNil: [ overlay detach ].
	eventHandler ifNotNil: [ targetElement removeEventHandler: eventHandler ].
	overlay := nil.
	eventHandler := nil.
	highlightedElement := nil.
	selectedElement := nil.
	isOpen := false
]

{ #category : 'accessing' }
CgtThemeEditor >> eventHandler [
	^ eventHandler
]

{ #category : 'initialization' }
CgtThemeEditor >> initialize [
	super initialize.
	isOpen := false.
	highlightedElement := nil.
	selectedElement := nil
]

{ #category : 'accessing' }
CgtThemeEditor >> highlightedElement [
	^ highlightedElement
]

{ #category : 'accessing' }
CgtThemeEditor >> highlightedElement: anElementOrNil [
	highlightedElement := anElementOrNil.
	overlay ifNotNil: [ overlay highlightElement: anElementOrNil ]
]

{ #category : 'accessing' }
CgtThemeEditor >> selectedElement [
	^ selectedElement
]

{ #category : 'accessing' }
CgtThemeEditor >> selectedElement: anElementOrNil [
	selectedElement := anElementOrNil.
	overlay ifNotNil: [ overlay selectElement: anElementOrNil ]
]

{ #category : 'accessing' }
CgtThemeEditor >> isOpen [
	^ isOpen = true
]

{ #category : 'opening' }
CgtThemeEditor >> open [
	self isOpen ifTrue: [ ^ self ].
	overlay := CgtThemeEditorOverlay on: targetElement.
	eventHandler := CgtThemeEditorEventHandler new.
	eventHandler editor: self.
	targetElement addEventHandler: eventHandler.
	isOpen := true
]

{ #category : 'accessing' }
CgtThemeEditor >> overlay [
	^ overlay
]

{ #category : 'accessing' }
CgtThemeEditor >> targetElement [
	^ targetElement
]

{ #category : 'accessing' }
CgtThemeEditor >> targetElement: anElement [
	targetElement := anElement
]
