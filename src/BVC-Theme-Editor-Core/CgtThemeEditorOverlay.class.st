Class {
	#name : 'CgtThemeEditorOverlay',
	#superclass : 'BlElement',
	#instVars : [
		'targetElement',
		'fullDim',
		'topDim',
		'leftDim',
		'rightDim',
		'bottomDim',
		'topLeftDim',
		'topRightDim',
		'bottomRightDim',
		'bottomLeftDim',
		'highlight',
		'selection',
		'elementToHighlight',
		'elementToSelect',
		'eventHandler'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'instance creation' }
CgtThemeEditorOverlay class >> on: anElement [
	^ self new
		targetElement: anElement;
		attach;
		yourself
]

{ #category : 'private' }
CgtThemeEditorOverlay >> addEventHandlerToElementToHighlightOrSelect: anElement [
	((elementToSelect = anElement or: [ elementToHighlight = anElement ])
		and: [ (anElement hasEventHandler: eventHandler) not ])
		ifTrue: [ anElement addEventHandler: eventHandler ]
]

{ #category : 'attaching' }
CgtThemeEditorOverlay >> attach [
	targetElement ifNotNil: [
		targetElement addChild: self ]
]

{ #category : 'private - geometry' }
CgtThemeEditorOverlay >> boundsRectFor: anOverlayedElement [
	| theAnchorPositions xs ys |
	theAnchorPositions := anOverlayedElement bounds inLocal bounds corners
		collect: [ :eachPoint | self globalPointToLocal: (anOverlayedElement localPointToGlobal: eachPoint) ].
	xs := theAnchorPositions collect: #x.
	ys := theAnchorPositions collect: #y.
	^ ((xs min) @ (ys min)) corner: ((xs max) @ (ys max))
]

{ #category : 'attaching' }
CgtThemeEditorOverlay >> detach [
	self removeFromParent
]

{ #category : 'private - styling' }
CgtThemeEditorOverlay >> dimColor [
	^ Color black alpha: 0.45
]

{ #category : 'accessing' }
CgtThemeEditorOverlay >> hideElement: anElement [
	(elementToHighlight = anElement or: [ elementToHighlight isNil ])
		ifTrue: [ highlight visibility: BlVisibility gone ].
	(elementToSelect = anElement or: [ elementToSelect isNil ])
		ifTrue: [ selection visibility: BlVisibility gone ].
	self updatePositions
]

{ #category : 'accessing' }
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
			highlight visibility: BlVisibility visible ].
	self updatePositions
]

{ #category : 'private - styling' }
CgtThemeEditorOverlay >> hoverColor [
	^ Color black alpha: 0.22
]

{ #category : 'initialization' }
CgtThemeEditorOverlay >> initialize [
	super initialize.
	self id: CgtThemeEditorOverlayElementId uniqueInstance.
	self constraintsDo: [ :c |
		c ignoreByLayout.
		c horizontal matchParent.
		c vertical matchParent ].
	self beInSeparateCompositionLayer.
	self allowMeAndChildrenMouseEvents.
	eventHandler := CgtThemeEditorOverlayEventHandler new overlay: self.
	fullDim := self newDimPolygonElement.
	topDim := self newDimPolygonElement.
	leftDim := self newDimPolygonElement.
	rightDim := self newDimPolygonElement.
	bottomDim := self newDimPolygonElement.
	topLeftDim := self newDimPolygonElement.
	topRightDim := self newDimPolygonElement.
	bottomRightDim := self newDimPolygonElement.
	bottomLeftDim := self newDimPolygonElement.
	highlight := BlPolygonElement new
		vertices: (self rectangleVerticesFor: ((0 @ 0) corner: (0 @ 0)));
		background: self hoverColor;
		border: (BlBorder paint: (Color r: 0.9 g: 0.78 b: 0.28 alpha: 0.9) width: 2);
		visibility: BlVisibility gone.
	selection := BlPolygonElement new
		vertices: (self rectangleVerticesFor: ((0 @ 0) corner: (0 @ 0)));
		background: Color transparent;
		border: (BlBorder paint: (Color r: 0.65 g: 0.45 b: 1.0 alpha: 1.0) width: 2);
		visibility: BlVisibility gone.
	self addChild: fullDim.
	self addChild: topDim.
	self addChild: leftDim.
	self addChild: rightDim.
	self addChild: bottomDim.
	self addChild: topLeftDim.
	self addChild: topRightDim.
	self addChild: bottomRightDim.
	self addChild: bottomLeftDim.
	self addChild: highlight.
	self addChild: selection.
	self updatePositions
]

{ #category : 'hooks - children' }
CgtThemeEditorOverlay >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	elementToHighlight ifNotNil: [ :anElement | self addEventHandlerToElementToHighlightOrSelect: anElement ].
	elementToSelect ifNotNil: [ :anElement | self addEventHandlerToElementToHighlightOrSelect: anElement ]
]

{ #category : 'hooks - geometry' }
CgtThemeEditorOverlay >> onExtentChanged [
	super onExtentChanged.
	self updatePositions
]

{ #category : 'hooks - children' }
CgtThemeEditorOverlay >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.
	elementToHighlight ifNotNil: [ :anElement | anElement removeEventHandler: eventHandler ].
	elementToSelect ifNotNil: [ :anElement | anElement removeEventHandler: eventHandler ]
]

{ #category : 'private - geometry' }
CgtThemeEditorOverlay >> rectangleVerticesFor: aRectangle [
	^ {
		aRectangle topLeft.
		aRectangle topRight.
		aRectangle bottomRight.
		aRectangle bottomLeft }
]


{ #category : 'private - geometry' }
CgtThemeEditorOverlay >> arcVerticesCenter: aPoint radius: aRadius fromDegrees: aStartAngle toDegrees: anEndAngle segments: aSegmentCount [
	| points step |
	points := OrderedCollection new.
	aRadius <= 0 ifTrue: [ ^ points ].
	step := (anEndAngle - aStartAngle) asFloat / aSegmentCount asFloat.
	0 to: aSegmentCount do: [ :index |
		| degrees radians |
		degrees := aStartAngle + (step * index).
		radians := degrees degreesToRadians.
		points add: ((aPoint x + (aRadius * radians cos)) @ (aPoint y + (aRadius * radians sin))) ].
	^ points
]

{ #category : 'private - geometry' }
CgtThemeEditorOverlay >> bottomLeftDimVerticesFor: aRectangle radius: aRadius [
	| left bottom center |
	left := aRectangle left.
	bottom := aRectangle bottom.
	center := (left + aRadius) @ (bottom - aRadius).
	^ OrderedCollection new
		add: (left @ (bottom - aRadius));
		addAll: ((self arcVerticesCenter: center radius: aRadius fromDegrees: 180 toDegrees: 90 segments: self roundedCornerSegments) allButFirst);
		add: ((left + aRadius) @ bottom);
		yourself
]

{ #category : 'private - geometry' }
CgtThemeEditorOverlay >> bottomRightDimVerticesFor: aRectangle radius: aRadius [
	| right bottom center |
	right := aRectangle right.
	bottom := aRectangle bottom.
	center := (right - aRadius) @ (bottom - aRadius).
	^ OrderedCollection new
		add: ((right - aRadius) @ bottom);
		addAll: ((self arcVerticesCenter: center radius: aRadius fromDegrees: 90 toDegrees: 0 segments: self roundedCornerSegments) allButFirst);
		add: (right @ (bottom - aRadius));
		yourself
]

{ #category : 'private - styling' }
CgtThemeEditorOverlay >> focusCornerRadius [
	^ elementToSelect
		ifNotNil: [ self selectionCornerRadius ]
		ifNil: [ elementToHighlight
			ifNotNil: [ self hoverCornerRadius ]
			ifNil: [ 0 ] ]
]

{ #category : 'private - styling' }
CgtThemeEditorOverlay >> hoverCornerRadius [
	^ 8
]

{ #category : 'private - geometry' }
CgtThemeEditorOverlay >> newDimPolygonElement [
	^ BlPolygonElement new
		vertices: (self rectangleVerticesFor: ((0 @ 0) corner: (0 @ 0)));
		background: self dimColor;
		visibility: BlVisibility gone;
		yourself
]

{ #category : 'private - geometry' }
CgtThemeEditorOverlay >> roundedCornerSegments [
	^ 6
]

{ #category : 'private - geometry' }
CgtThemeEditorOverlay >> roundedRectangleVerticesFor: aRectangle radius: aRequestedRadius [
	| left top right bottom radius points |
	left := aRectangle left.
	top := aRectangle top.
	right := aRectangle right.
	bottom := aRectangle bottom.
	radius := (aRequestedRadius min: (aRectangle width / 2.0)) min: (aRectangle height / 2.0).
	radius <= 0 ifTrue: [ ^ self rectangleVerticesFor: aRectangle ].
	points := OrderedCollection new.
	points add: ((left + radius) @ top).
	points addAll: ((self arcVerticesCenter: ((right - radius) @ (top + radius)) radius: radius fromDegrees: -90 toDegrees: 0 segments: self roundedCornerSegments) allButFirst).
	points addAll: ((self arcVerticesCenter: ((right - radius) @ (bottom - radius)) radius: radius fromDegrees: 0 toDegrees: 90 segments: self roundedCornerSegments) allButFirst).
	points addAll: ((self arcVerticesCenter: ((left + radius) @ (bottom - radius)) radius: radius fromDegrees: 90 toDegrees: 180 segments: self roundedCornerSegments) allButFirst).
	points addAll: ((self arcVerticesCenter: ((left + radius) @ (top + radius)) radius: radius fromDegrees: 180 toDegrees: 270 segments: self roundedCornerSegments) allButFirst).
	^ points
]

{ #category : 'private - styling' }
CgtThemeEditorOverlay >> selectionCornerRadius [
	^ 12
]

{ #category : 'private - geometry' }
CgtThemeEditorOverlay >> topLeftDimVerticesFor: aRectangle radius: aRadius [
	| left top center |
	left := aRectangle left.
	top := aRectangle top.
	center := (left + aRadius) @ (top + aRadius).
	^ OrderedCollection new
		add: (left @ top);
		add: ((left + aRadius) @ top);
		addAll: ((self arcVerticesCenter: center radius: aRadius fromDegrees: -90 toDegrees: -180 segments: self roundedCornerSegments) allButFirst);
		add: (left @ (top + aRadius));
		yourself
]

{ #category : 'private - geometry' }
CgtThemeEditorOverlay >> topRightDimVerticesFor: aRectangle radius: aRadius [
	| right top center |
	right := aRectangle right.
	top := aRectangle top.
	center := (right - aRadius) @ (top + aRadius).
	^ OrderedCollection new
		add: ((right - aRadius) @ top);
		add: (right @ top);
		add: (right @ (top + aRadius));
		addAll: ((self arcVerticesCenter: center radius: aRadius fromDegrees: 0 toDegrees: -90 segments: self roundedCornerSegments) allButFirst);
		yourself
]

{ #category : 'private' }
CgtThemeEditorOverlay >> removeEventHandlerFromElementToHighlightOrSelect: anElement [
	(elementToSelect ~= anElement
		and: [ elementToHighlight ~= anElement
		and: [ anElement notNil ] ])
		ifTrue: [ anElement removeEventHandler: eventHandler ]
]

{ #category : 'accessing' }
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
			selection visibility: BlVisibility visible ].
	self updatePositions
]

{ #category : 'accessing' }
CgtThemeEditorOverlay >> showElement: anElement [
	(elementToHighlight = anElement)
		ifTrue: [ highlight visibility: BlVisibility visible ].
	elementToHighlight ifNil: [ highlight visibility: BlVisibility gone ].
	(elementToSelect = anElement)
		ifTrue: [ selection visibility: BlVisibility visible ].
	elementToSelect ifNil: [ selection visibility: BlVisibility gone ].
	self updatePositions
]

{ #category : 'accessing' }
CgtThemeEditorOverlay >> targetElement [
	^ targetElement
]

{ #category : 'accessing' }
CgtThemeEditorOverlay >> targetElement: anElement [
	targetElement := anElement
]

{ #category : 'private' }
CgtThemeEditorOverlay >> updateDimElement: anElement withVertices: aCollectionOfVertices [
	(aCollectionOfVertices isNil or: [ aCollectionOfVertices size < 3 ])
		ifTrue: [ anElement visibility: BlVisibility gone ]
		ifFalse: [
			anElement vertices: aCollectionOfVertices.
			anElement visibility: BlVisibility visible ]
]

{ #category : 'private' }
CgtThemeEditorOverlay >> updateDimmingForFocusRectangle: aRectangle [
	| overlayRect radius topRect leftRect rightRect bottomRect |
	overlayRect := (0 @ 0) corner: self extent.
	aRectangle ifNil: [
		fullDim vertices: (self rectangleVerticesFor: overlayRect).
		fullDim visibility: BlVisibility visible.
		topDim visibility: BlVisibility gone.
		leftDim visibility: BlVisibility gone.
		rightDim visibility: BlVisibility gone.
		bottomDim visibility: BlVisibility gone.
		topLeftDim visibility: BlVisibility gone.
		topRightDim visibility: BlVisibility gone.
		bottomRightDim visibility: BlVisibility gone.
		bottomLeftDim visibility: BlVisibility gone.
		^ self ].
	radius := (self focusCornerRadius min: (aRectangle width / 2.0)) min: (aRectangle height / 2.0).
	fullDim visibility: BlVisibility gone.
	topRect := overlayRect topLeft corner: (overlayRect right @ aRectangle top).
	leftRect := (overlayRect left @ (aRectangle top + radius)) corner: (aRectangle left @ (aRectangle bottom - radius)).
	rightRect := (aRectangle right @ (aRectangle top + radius)) corner: (overlayRect right @ (aRectangle bottom - radius)).
	bottomRect := (overlayRect left @ aRectangle bottom) corner: overlayRect bottomRight.
	self updateDimElement: topDim withVertices: (self rectangleVerticesFor: topRect).
	self updateDimElement: leftDim withVertices: (self rectangleVerticesFor: leftRect).
	self updateDimElement: rightDim withVertices: (self rectangleVerticesFor: rightRect).
	self updateDimElement: bottomDim withVertices: (self rectangleVerticesFor: bottomRect).
	self updateDimElement: topLeftDim withVertices: (self topLeftDimVerticesFor: aRectangle radius: radius).
	self updateDimElement: topRightDim withVertices: (self topRightDimVerticesFor: aRectangle radius: radius).
	self updateDimElement: bottomRightDim withVertices: (self bottomRightDimVerticesFor: aRectangle radius: radius).
	self updateDimElement: bottomLeftDim withVertices: (self bottomLeftDimVerticesFor: aRectangle radius: radius)
]

{ #category : 'private' }
CgtThemeEditorOverlay >> updateOverlayElement: anOverlayElement toMatch: anOverlayedElement [
	| aRectangle aRadius |
	aRectangle := self boundsRectFor: anOverlayedElement.
	aRadius := anOverlayElement = selection
		ifTrue: [ self selectionCornerRadius ]
		ifFalse: [ self hoverCornerRadius ].
	anOverlayElement vertices: (self roundedRectangleVerticesFor: aRectangle radius: aRadius)
]

{ #category : 'private' }
CgtThemeEditorOverlay >> updatePositions [
	| focusRect |
	elementToSelect ifNotNil: [ :anOverlayedElement |
		self updateOverlayElement: selection toMatch: anOverlayedElement ].
	elementToHighlight ifNotNil: [ :anOverlayedElement |
		self updateOverlayElement: highlight toMatch: anOverlayedElement ].
	focusRect := elementToSelect
		ifNotNil: [ self boundsRectFor: elementToSelect ]
		ifNil: [ elementToHighlight
			ifNotNil: [ self boundsRectFor: elementToHighlight ]
			ifNil: [ nil ] ].
	self updateDimmingForFocusRectangle: focusRect.
	(elementToSelect notNil and: [ elementToHighlight notNil and: [ elementToHighlight ~= elementToSelect ] ])
		ifTrue: [ highlight background: Color transparent ]
		ifFalse: [ highlight background: self hoverColor ]
]
