Class {
	#name : #CgtThemeEditorOverlay,
	#superclass : #BlElement,
	#instVars : [
		'targetElement',
		'highlightedElement',
		'selectedElement',
		'eventHandler'
	],
	#category : #'BVC-Theme-Editor-Core'
}

{ #category : #'instance creation' }
CgtThemeEditorOverlay class >> on: anElement [
	^ self new
		targetElement: anElement;
		attach;
		yourself
]

{ #category : #initialization }
CgtThemeEditorOverlay >> initialize [
	super initialize.
	self constraintsDo: [ :c |
		c ignoreByLayout.
		c horizontal matchParent.
		c vertical matchParent ].
	self beInSeparateCompositionLayer.
	self preventChildrenMouseEvents.
	eventHandler := CgtThemeEditorOverlayEventHandler new
]

{ #category : #attaching }
CgtThemeEditorOverlay >> attach [
	"Framework shell only. The concrete composition-layer attachment will be refined later."
	targetElement ifNotNil: [
		targetElement addChild: self.
		targetElement addEventHandler: eventHandler ]
]

{ #category : #attaching }
CgtThemeEditorOverlay >> detach [
	targetElement ifNotNil: [
		targetElement removeEventHandler: eventHandler ifAbsent: [ ].
		self removeFromParent ]
]

{ #category : #accessing }
CgtThemeEditorOverlay >> highlightedElement [
	^ highlightedElement
]

{ #category : #accessing }
CgtThemeEditorOverlay >> highlightedElement: anElement [
	highlightedElement := anElement
]

{ #category : #accessing }
CgtThemeEditorOverlay >> selectedElement [
	^ selectedElement
]

{ #category : #accessing }
CgtThemeEditorOverlay >> selectedElement: anElement [
	selectedElement := anElement
]

{ #category : #accessing }
CgtThemeEditorOverlay >> targetElement [
	^ targetElement
]

{ #category : #accessing }
CgtThemeEditorOverlay >> targetElement: anElement [
	targetElement := anElement.
	eventHandler overlay: self
]
