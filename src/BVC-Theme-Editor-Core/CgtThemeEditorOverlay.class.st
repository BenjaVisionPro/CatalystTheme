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
		'highlight',
		'selection',
		'elementToHighlight',
		'elementToSelect',
		'eventHandler',
		'dimAnimation',
		'hoverBoundsAnimation',
		'animatedHoverRectangle'
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

{ #category : 'animation' }
CgtThemeEditorOverlay >> animateDimmingIn [
	| animation |
	dimAnimation ifNotNil: [ dimAnimation stopIfRunning ].
	self setDimOpacity: 0.0.
	animation := BlNumberTransition new
		from: 0.0;
		to: 0.45;
		duration: 200 milliseconds;
		onStepDo: [ :value | self setDimOpacity: value ];
		onFinishedDo: [
			self setDimOpacity: 0.45.
			dimAnimation := nil ];
		yourself.
	dimAnimation := animation.
	self addAnimation: animation
]

{ #category : 'private - animation' }
CgtThemeEditorOverlay >> animateHoverRectangleTo: aRectangle [
	| startRectangle animation |
	aRectangle ifNil: [
		hoverBoundsAnimation ifNotNil: [ hoverBoundsAnimation stopIfRunning ].
		animatedHoverRectangle := nil.
		self updatePositions.
		^ self ].
	startRectangle := animatedHoverRectangle
		ifNil: [
			elementToHighlight
				ifNotNil: [ self boundsRectFor: elementToHighlight ]
				ifNil: [ aRectangle ] ].
	hoverBoundsAnimation ifNotNil: [ hoverBoundsAnimation stopIfRunning ].
	animation := BlNumberTransition new
		from: 0.0;
		to: 1.0;
		duration: 120 milliseconds;
		easing: CgtFastInSlowOutEasing new;
		onStepDo: [ :progress |
			animatedHoverRectangle := self
				interpolateRectangle: startRectangle
				to: aRectangle
				at: progress asFloat.
			self updatePositions ];
		onFinishedDo: [
			animatedHoverRectangle := aRectangle.
			hoverBoundsAnimation := nil.
			self updatePositions ];
		yourself.
	hoverBoundsAnimation := animation.
	self addAnimation: animation
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
	^ self dimColorWithAlpha: 0.45
]

{ #category : 'private - styling' }
CgtThemeEditorOverlay >> dimColorWithAlpha: anAlpha [
	^ Color black alpha: anAlpha
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
	| aPreviousElementToHighlight targetRectangle |
	aPreviousElementToHighlight := elementToHighlight.
	elementToHighlight := anElementOrNil.
	self removeEventHandlerFromElementToHighlightOrSelect: aPreviousElementToHighlight.
	anElementOrNil
		ifNil: [
			highlight visibility: BlVisibility gone.
			self animateHoverRectangleTo: nil ]
		ifNotNil: [ :anElement |
			self addEventHandlerToElementToHighlightOrSelect: anElement.
			targetRectangle := self boundsRectFor: anElement.
			highlight visibility: BlVisibility visible.
			self animateHoverRectangleTo: targetRectangle ].
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
	dimAnimation := nil.
	hoverBoundsAnimation := nil.
	animatedHoverRectangle := nil.
	fullDim := BlPolygonElement new
		background: (self dimColorWithAlpha: 0.0);
		visibility: BlVisibility visible.
	topDim := BlPolygonElement new
		background: (self dimColorWithAlpha: 0.0);
		visibility: BlVisibility gone.
	leftDim := BlPolygonElement new
		background: (self dimColorWithAlpha: 0.0);
		visibility: BlVisibility gone.
	rightDim := BlPolygonElement new
		background: (self dimColorWithAlpha: 0.0);
		visibility: BlVisibility gone.
	bottomDim := BlPolygonElement new
		background: (self dimColorWithAlpha: 0.0);
		visibility: BlVisibility gone.
	highlight := BlPolygonElement new
		background: self hoverColor;
		border: (BlBorder paint: (Color r: 0.9 g: 0.78 b: 0.28 alpha: 0.9) width: 2);
		visibility: BlVisibility gone.
	selection := BlPolygonElement new
		background: Color transparent;
		border: (BlBorder paint: (Color r: 0.65 g: 0.45 b: 1.0 alpha: 1.0) width: 2);
		visibility: BlVisibility gone.
	self addChild: fullDim.
	self addChild: topDim.
	self addChild: leftDim.
	self addChild: rightDim.
	self addChild: bottomDim.
	self addChild: highlight.
	self addChild: selection.
	self updatePositions
]

{ #category : 'private - geometry' }
CgtThemeEditorOverlay >> interpolatedPointFrom: aPoint to: anotherPoint at: progress [
	^ (aPoint x + ((anotherPoint x - aPoint x) * progress))
		@ (aPoint y + ((anotherPoint y - aPoint y) * progress))
]

{ #category : 'private - geometry' }
CgtThemeEditorOverlay >> interpolateRectangle: aRectangle to: anotherRectangle at: progress [
	^ (self interpolatedPointFrom: aRectangle topLeft to: anotherRectangle topLeft at: progress)
		corner: (self interpolatedPointFrom: aRectangle bottomRight to: anotherRectangle bottomRight at: progress)
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

{ #category : 'private' }
CgtThemeEditorOverlay >> removeEventHandlerFromElementToHighlightOrSelect: anElement [
	(elementToSelect ~= anElement
		and: [ elementToHighlight ~= anElement
		and: [ anElement notNil ] ])
		ifTrue: [ anElement removeEventHandler: eventHandler ]
]

{ #category : 'private - styling' }
CgtThemeEditorOverlay >> setDimOpacity: anAlpha [
	| aColor |
	aColor := self dimColorWithAlpha: anAlpha.
	fullDim background: aColor.
	topDim background: aColor.
	leftDim background: aColor.
	rightDim background: aColor.
	bottomDim background: aColor
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
CgtThemeEditorOverlay >> updateDimElement: anElement withRectangle: aRectangle [
	((aRectangle width <= 0) or: [ aRectangle height <= 0 ])
		ifTrue: [ anElement visibility: BlVisibility gone ]
		ifFalse: [
			anElement vertices: (self rectangleVerticesFor: aRectangle).
			anElement visibility: BlVisibility visible ]
]

{ #category : 'private' }
CgtThemeEditorOverlay >> updateDimmingForFocusRectangle: aRectangle [
	| overlayRect topRect leftRect rightRect bottomRect |
	overlayRect := (0 @ 0) corner: self extent.
	aRectangle ifNil: [
		fullDim vertices: (self rectangleVerticesFor: overlayRect).
		fullDim visibility: BlVisibility visible.
		topDim visibility: BlVisibility gone.
		leftDim visibility: BlVisibility gone.
		rightDim visibility: BlVisibility gone.
		bottomDim visibility: BlVisibility gone.
		^ self ].
	fullDim visibility: BlVisibility gone.
	topRect := overlayRect topLeft corner: (overlayRect right @ aRectangle top).
	leftRect := (overlayRect left @ aRectangle top) corner: (aRectangle left @ aRectangle bottom).
	rightRect := (aRectangle right @ aRectangle top) corner: overlayRect bottomRight x @ aRectangle bottom.
	bottomRect := (overlayRect left @ aRectangle bottom) corner: overlayRect bottomRight.
	self updateDimElement: topDim withRectangle: topRect.
	self updateDimElement: leftDim withRectangle: leftRect.
	self updateDimElement: rightDim withRectangle: rightRect.
	self updateDimElement: bottomDim withRectangle: bottomRect
]

{ #category : 'private' }
CgtThemeEditorOverlay >> updateOverlayElement: anOverlayElement toMatch: anOverlayedElement [
	| theAnchorPositions |
	theAnchorPositions := anOverlayedElement bounds inLocal bounds corners
		collect: [ :eachPoint | self globalPointToLocal: (anOverlayedElement localPointToGlobal: eachPoint) ].
	anOverlayElement vertices: theAnchorPositions
]

{ #category : 'private' }
CgtThemeEditorOverlay >> updatePositions [
	| focusRect |
	elementToSelect ifNotNil: [ :anOverlayedElement |
		self updateOverlayElement: selection toMatch: anOverlayedElement ].
	animatedHoverRectangle
		ifNotNil: [ highlight vertices: (self rectangleVerticesFor: animatedHoverRectangle) ]
		ifNil: [
			elementToHighlight ifNotNil: [ :anOverlayedElement |
				self updateOverlayElement: highlight toMatch: anOverlayedElement ] ].
	focusRect := elementToSelect
		ifNotNil: [ self boundsRectFor: elementToSelect ]
		ifNil: [ animatedHoverRectangle
			ifNotNil: [ animatedHoverRectangle ]
			ifNil: [ elementToHighlight
				ifNotNil: [ self boundsRectFor: elementToHighlight ]
				ifNil: [ nil ] ] ].
	self updateDimmingForFocusRectangle: focusRect.
	(elementToSelect notNil and: [ elementToHighlight notNil and: [ elementToHighlight ~= elementToSelect ] ])
		ifTrue: [ highlight background: Color transparent ]
		ifFalse: [ highlight background: self hoverColor ]
]
