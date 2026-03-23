Class {
	#name : #CgtThemeEditorOverlay,
	#superclass : #BlElement,
	#instVars : [
		'targetElement',
		'highlight',
		'selection',
		'elementToHighlight',
		'elementToSelect',
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

{ #category : #private }
CgtThemeEditorOverlay >> addEventHandlerToElementToHighlightOrSelect: anElement [
	((elementToSelect = anElement or: [ elementToHighlight = anElement ])
		and: [ (anElement hasEventHandler: eventHandler) not ])
		ifTrue: [ anElement addEventHandler: eventHandler ]
]

{ #category : #attaching }
CgtThemeEditorOverlay >> attach [
	targetElement ifNotNil: [
		targetElement addChild: self ]
]

{ #category : #attaching }
CgtThemeEditorOverlay >> detach [
	self removeFromParent
]

{ #category : #accessing }
CgtThemeEditorOverlay >> hideElement: anElement [
	(elementToHighlight = anElement or: [ elementToHighlight isNil ])
		ifTrue: [ highlight visibility: BlVisibility gone ].
	(elementToSelect = anElement or: [ elementToSelect isNil ])
		ifTrue: [ selection visibility: BlVisibility gone ]
]

{ #category : #accessing }
CgtThemeEditorOverlay >> highlightElement: anElementOrNil [
	| aPreviousElementToHighlight |
	aPreviousElementToHighlight := elementToHighlight.
	elementToHighlight := anElementOrNil.
	self removeEventHandlerFromElementToHighlightOrSelect: aPreviousElementToHighlight.
	anElementOrNil
		ifNil: [ highlight visibility: BlVisibility gone ]
		ifNotNil: [ :anElement |
			self addEventHandlerToElementToHighlightOrSelect: anElement.
			self updateOverlayElement: highlight toMatch: anElement.
			highlight visibility: BlVisibility visible ]
]

{ #category : #initialization }
CgtThemeEditorOverlay >> initialize [
	super initialize.
	self constraintsDo: [ :c |
		c ignoreByLayout.
		c horizontal matchParent.
		c vertical matchParent ].
	self beInSeparateCompositionLayer.
	eventHandler := CgtThemeEditorOverlayEventHandler new overlay: self.
	highlight := BlPolygonElement new
		background: (Color r: 1.0 g: 0.8396871945259042 b: 0.3998044965786901 alpha: 0.2);
		visibility: BlVisibility gone.
	selection := BlPolygonElement new
		background: (Color r: 0.2 g: 0.6 b: 1.0 alpha: 0.2);
		visibility: BlVisibility gone.
	self addChild: highlight.
	self addChild: selection
]

{ #category : #'hooks - children' }
CgtThemeEditorOverlay >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	elementToHighlight ifNotNil: [ :anElement | self addEventHandlerToElementToHighlightOrSelect: anElement ].
	elementToSelect ifNotNil: [ :anElement | self addEventHandlerToElementToHighlightOrSelect: anElement ]
]

{ #category : #'hooks - geometry' }
CgtThemeEditorOverlay >> onExtentChanged [
	super onExtentChanged.
	self updatePositions
]

{ #category : #'hooks - children' }
CgtThemeEditorOverlay >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.
	elementToHighlight ifNotNil: [ :anElement | anElement removeEventHandler: eventHandler ].
	elementToSelect ifNotNil: [ :anElement | anElement removeEventHandler: eventHandler ]
]

{ #category : #private }
CgtThemeEditorOverlay >> removeEventHandlerFromElementToHighlightOrSelect: anElement [
	(elementToSelect ~= anElement
		and: [ elementToHighlight ~= anElement
		and: [ anElement notNil ] ])
		ifTrue: [ anElement removeEventHandler: eventHandler ]
]

{ #category : #accessing }
CgtThemeEditorOverlay >> selectElement: anElementOrNil [
	| aPreviousElementToSelect |
	aPreviousElementToSelect := elementToSelect.
	elementToSelect := anElementOrNil.
	self removeEventHandlerFromElementToHighlightOrSelect: aPreviousElementToSelect.
	anElementOrNil
		ifNil: [ selection visibility: BlVisibility gone ]
		ifNotNil: [ :anElement |
			self addEventHandlerToElementToHighlightOrSelect: anElement.
			self updateOverlayElement: selection toMatch: anElement.
			selection visibility: BlVisibility visible ]
]

{ #category : #accessing }
CgtThemeEditorOverlay >> showElement: anElement [
	(elementToHighlight = anElement)
		ifTrue: [ highlight visibility: BlVisibility visible ].
	elementToHighlight ifNil: [ highlight visibility: BlVisibility gone ].
	(elementToSelect = anElement)
		ifTrue: [ selection visibility: BlVisibility visible ].
	elementToSelect ifNil: [ selection visibility: BlVisibility gone ]
]

{ #category : #accessing }
CgtThemeEditorOverlay >> targetElement [
	^ targetElement
]

{ #category : #accessing }
CgtThemeEditorOverlay >> targetElement: anElement [
	targetElement := anElement
]

{ #category : #private }
CgtThemeEditorOverlay >> updateOverlayElement: anOverlayElement toMatch: anOverlayedElement [
	| theAnchorPositions |
	theAnchorPositions := anOverlayedElement bounds inLocal bounds corners
		collect: [ :eachPoint | self globalPointToLocal: (anOverlayedElement localPointToGlobal: eachPoint) ].
	anOverlayElement vertices: theAnchorPositions
]

{ #category : #private }
CgtThemeEditorOverlay >> updatePositions [
	elementToSelect ifNotNil: [ :anOverlayedElement |
		self updateOverlayElement: selection toMatch: anOverlayedElement ].
	elementToHighlight ifNotNil: [ :anOverlayedElement |
		self updateOverlayElement: highlight toMatch: anOverlayedElement ]
]
