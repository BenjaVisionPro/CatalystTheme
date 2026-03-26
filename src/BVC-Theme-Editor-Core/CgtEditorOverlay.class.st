Class {
	#name : 'CgtEditorOverlay',
	#superclass : 'BlElement',
	#instVars : [
		'state',
		'eventHandler',
		'maskLayer',
		'observedElements',
		'overlayOpacity',
		'fadeAnimationToken'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'private' }
CgtEditorOverlay >> addEventHandlerToObservedElement: anElement [
	(anElement notNil and: [ (anElement hasEventHandler: eventHandler) not ])
		ifTrue: [ anElement addEventHandler: eventHandler ]
]

{ #category : 'actions' }
CgtEditorOverlay >> clickHoverElement [
	state clickHoverElement.
	self stateChanged
]

{ #category : 'accessing' }
CgtEditorOverlay >> childScopeElement [
	^ state childScopeElement
]


{ #category : 'api - animation' }
CgtEditorOverlay >> animateFadeIn [
	| aToken aStartOpacity |
	fadeAnimationToken := fadeAnimationToken + 1.
	aToken := fadeAnimationToken.
	aStartOpacity := overlayOpacity.
	self updatePositions.
	self addAnimation: (BlNumberTransition new
			from: aStartOpacity;
			to: 1.0;
			duration: 400 milliSeconds;
			easing: CgtFastInSlowOutEasing new;
			onStepDo: [ :anOpacity :anOverlay |
				anOverlay fadeAnimationToken = aToken
					ifTrue: [ anOverlay overlayOpacity: anOpacity ] ];
			yourself)
]

{ #category : 'api - animation' }
CgtEditorOverlay >> animateFadeOutOnFinishedDo: aBlock [
	| aToken |
	fadeAnimationToken := fadeAnimationToken + 1.
	aToken := fadeAnimationToken.
	self addAnimation: (BlNumberTransition new
			from: overlayOpacity;
			to: 0.0;
			duration: 400 milliSeconds;
			easing: CgtFastInSlowOutEasing new;
			onStepDo: [ :anOpacity :anOverlay |
				anOverlay fadeAnimationToken = aToken
					ifTrue: [ anOverlay overlayOpacity: anOpacity ] ];
			onFinishedDo: [ self fadeAnimationToken = aToken ifTrue: [ aBlock value ] ];
			yourself)
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> cutOutElement: anElement alpha: anAlpha onSpartaCanvas: aCanvas [
	| aBounds aGeometry |
	anElement ifNil: [ ^ self ].
	aBounds := self overlayBoundsFor: anElement.
	aBounds ifNil: [ ^ self ].
	aGeometry := self roundedGeometryFor: anElement bounds: aBounds.
	aCanvas transform
		by: [ :aTransform | aTransform translateBy: aBounds origin ]
		during: [
			aCanvas fill
				path: (aGeometry buildPathOnSpartaCanvas: aCanvas);
				paint: (Color white alpha: (anAlpha * overlayOpacity));
				composeDestOut;
				draw ]
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> dimBounds [
	^ self bounds inLocal asRectangle
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> drawDimOnSpartaCanvas: aCanvas [
	aCanvas fill
		path: self dimBounds;
		paint: (Color black alpha: (state dimOpacity * overlayOpacity));
		draw
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> drawHoverOnSpartaCanvas: aCanvas [
	| anElement |
	anElement := state hoverElement.
	anElement ifNil: [ ^ self ].
	state isHoverOnSelected ifTrue: [ ^ self ].
	self
		cutOutElement: anElement
		alpha: state hoverTransparencyForCurrentHover
		onSpartaCanvas: aCanvas
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> drawScopesOnSpartaCanvas: aCanvas [
	| theScopeElements |
	theScopeElements := state scopeElementsInDisplayOrder.
	theScopeElements withIndexDo: [ :eachElement :anIndex |
		self
			cutOutElement: eachElement
			alpha: (state scopeTransparencyAtIndex: anIndex)
			onSpartaCanvas: aCanvas ]
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> drawSelectionOnSpartaCanvas: aCanvas [
	self cutOutElement: state selectedElement alpha: 1.0 onSpartaCanvas: aCanvas.
	self cutOutElement: state childScopeElement alpha: 0.35 onSpartaCanvas: aCanvas
]


{ #category : 'accessing' }
CgtEditorOverlay >> fadeAnimationToken [
	^ fadeAnimationToken
]

{ #category : 'accessing' }
CgtEditorOverlay >> hideElement: anElement [
	(self observedElements includes: anElement)
		ifFalse: [ self stateChanged ]
]

{ #category : 'accessing' }
CgtEditorOverlay >> highlightElement: anElementOrNil [
	self hoverElement: anElementOrNil
]

{ #category : 'accessing' }
CgtEditorOverlay >> hoverElement [
	^ state hoverElement
]

{ #category : 'accessing' }
CgtEditorOverlay >> hoverElement: anElementOrNil [
	state hoverElement: anElementOrNil.
	self stateChanged
]

{ #category : 'initialization' }
CgtEditorOverlay >> initialize [
	super initialize.
	state := CgtEditorOverlayState new.
	overlayOpacity := 1.0.
	fadeAnimationToken := 0.
	observedElements := OrderedCollection new.
	self
		constraintsDo: [ :c |
			c ignoreByLayout.
			c horizontal matchParent.
			c vertical matchParent ];
		beInSeparateCompositionLayer.
	eventHandler := CgtEditorOverlayEventHandler new overlay: self.
	maskLayer := BlSpartaElement new
		constraintsDo: [ :c |
			c ignoreByLayout.
			c horizontal matchParent.
			c vertical matchParent ];
		effect: (BlBlurEffect radius: state blurRadius);
		rendering: [ :aCanvas :anElement | self renderOnSpartaCanvas: aCanvas ];
		yourself.
	self addChild: maskLayer
]

{ #category : 'testing' }
CgtEditorOverlay >> isDescendantOfSelection: anElement [
	^ state isDescendantOfSelection: anElement
]

{ #category : 'hooks - children' }
CgtEditorOverlay >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	self syncObservedElements
]

{ #category : 'hooks - geometry' }
CgtEditorOverlay >> onExtentChanged [
	super onExtentChanged.
	self updatePositions
]

{ #category : 'hooks - children' }
CgtEditorOverlay >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.
	observedElements do: [ :eachElement | eachElement removeEventHandler: eventHandler ].
	observedElements removeAll
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> overlayBoundsFor: anOverlayedElement [
	| theCorners minX maxX minY maxY |
	theCorners := anOverlayedElement bounds inLocal bounds corners
		collect: [ :eachPoint | self globalPointToLocal: (anOverlayedElement localPointToGlobal: eachPoint) ].
	theCorners ifEmpty: [ ^ nil ].
	minX := theCorners first x.
	maxX := theCorners first x.
	minY := theCorners first y.
	maxY := theCorners first y.
	theCorners allButFirstDo: [ :eachPoint |
		minX := minX min: eachPoint x.
		maxX := maxX max: eachPoint x.
		minY := minY min: eachPoint y.
		maxY := maxY max: eachPoint y ].
	^ ((minX @ minY) corner: (maxX @ maxY)) expandBy: state maskOutset
]

{ #category : 'private' }
CgtEditorOverlay >> removeEventHandlerFromObservedElement: anElement [
	(anElement notNil and: [ (observedElements includes: anElement) not ])
		ifTrue: [ anElement removeEventHandler: eventHandler ]
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> renderOnSpartaCanvas: aCanvas [
	aCanvas layer during: [
		self drawDimOnSpartaCanvas: aCanvas.
		self drawScopesOnSpartaCanvas: aCanvas.
		self drawSelectionOnSpartaCanvas: aCanvas.
		self drawHoverOnSpartaCanvas: aCanvas ]
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> roundedGeometryFor: anElement bounds: aRectangle [
	| aRadius |
	aRadius := state defaultCornerRadius.
	(anElement geometry isKindOf: BlRoundedRectangleGeometry)
		ifTrue: [ aRadius := anElement geometry cornerRadii max + state maskOutset ].
	^ (BlRoundedRectangleGeometry cornerRadius: aRadius)
		matchExtent: aRectangle extent;
		yourself
]



{ #category : 'accessing' }
CgtEditorOverlay >> overlayOpacity [
	^ overlayOpacity
]

{ #category : 'accessing' }
CgtEditorOverlay >> overlayOpacity: aNumber [
	overlayOpacity := aNumber.
	self updatePositions
]

{ #category : 'accessing' }
CgtEditorOverlay >> selectElement: anElementOrNil [
	state selectElement: anElementOrNil.
	self stateChanged
]

{ #category : 'accessing' }
CgtEditorOverlay >> selectedElement [
	^ state selectedElement
]

{ #category : 'accessing' }
CgtEditorOverlay >> showElement: anElement [
	(self observedElements includes: anElement)
		ifTrue: [ self stateChanged ]
]

{ #category : 'accessing' }
CgtEditorOverlay >> state [
	^ state
]

{ #category : 'accessing' }
CgtEditorOverlay >> state: aState [
	state := aState.
	maskLayer ifNotNil: [ maskLayer effect: (BlBlurEffect radius: state blurRadius) ].
	self stateChanged
]

{ #category : 'private' }
CgtEditorOverlay >> stateChanged [
	self syncObservedElements.
	self updatePositions
]

{ #category : 'private' }
CgtEditorOverlay >> syncObservedElements [
	| theNewObservedElements |
	theNewObservedElements := state observedElements asOrderedCollection.
	observedElements do: [ :eachElement |
		(theNewObservedElements includes: eachElement)
			ifFalse: [ eachElement removeEventHandler: eventHandler ] ].
	theNewObservedElements do: [ :eachElement |
		(observedElements includes: eachElement)
			ifFalse: [ eachElement addEventHandler: eventHandler ] ].
	observedElements := theNewObservedElements
]

{ #category : 'actions' }
CgtEditorOverlay >> toggleScopeElement: anElement [
	state toggleScopeElement: anElement.
	self stateChanged
]

{ #category : 'accessing' }
CgtEditorOverlay >> updatePositions [
	maskLayer invalidate
]
