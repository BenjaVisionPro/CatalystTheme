Class {
	#name : 'CgtEditorOverlay',
	#superclass : 'BlElement',
	#instVars : [
		'state',
		'eventHandler',
		'maskLayer',
		'observedElements',
		'overlayOpacity',
		'fadeAnimationToken',
		'hoverAnimationToken',
		'animatedHoverBounds',
		'animatedHoverCornerRadius',
		'animatedHoverAlpha'
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
	(animatedHoverBounds isNil or: [ animatedHoverAlpha <= 0.0 ]) ifTrue: [ ^ self ].
	aCanvas transform
		by: [ :aTransform | aTransform translateBy: animatedHoverBounds origin ]
		during: [
				| aPath |
			aPath := ((BlRoundedRectangleGeometry cornerRadius: animatedHoverCornerRadius)
				matchExtent: animatedHoverBounds extent;
				yourself) buildPathOnSpartaCanvas: aCanvas.
			aCanvas fill
				path: aPath;
				paint: (Color white alpha: (animatedHoverAlpha * overlayOpacity));
				composeDestOut;
				draw ]
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
	hoverAnimationToken := 0.
	animatedHoverBounds := nil.
	animatedHoverCornerRadius := state defaultCornerRadius.
	animatedHoverAlpha := 0.0.
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


{ #category : 'private - hover animation' }
CgtEditorOverlay >> animateHoverTransition [
	| aTargetBounds aTargetRadius aTargetAlpha aStartBounds aStartRadius aStartAlpha aToken |
	aTargetBounds := self targetHoverBounds.
	aTargetRadius := self targetHoverCornerRadius.
	aTargetAlpha := self targetHoverAlpha.
	aStartBounds := animatedHoverBounds ifNil: [ aTargetBounds ].
	aStartRadius := animatedHoverCornerRadius ifNil: [ aTargetRadius ].
	aStartAlpha := animatedHoverAlpha ifNil: [ 0.0 ].
	(aStartBounds isNil and: [ aTargetBounds isNil ])
		ifTrue: [
			animatedHoverAlpha := 0.0.
			self updatePositions.
			^ self ].
	aStartBounds ifNil: [ aStartBounds := aTargetBounds ].
	aTargetBounds ifNil: [ aTargetBounds := aStartBounds ].
	hoverAnimationToken := hoverAnimationToken + 1.
	aToken := hoverAnimationToken.
	self addAnimation: (BlNumberTransition new
			from: 0.0;
			to: 1.0;
			duration: 120 milliSeconds;
			onStepDo: [ :aProgress :anOverlay |
				anOverlay hoverAnimationToken = aToken ifTrue: [
					anOverlay
						animatedHoverBounds: (anOverlay interpolateBoundsFrom: aStartBounds to: aTargetBounds progress: aProgress);
						animatedHoverCornerRadius: (anOverlay interpolateNumberFrom: aStartRadius to: aTargetRadius progress: aProgress);
						animatedHoverAlpha: (anOverlay interpolateNumberFrom: aStartAlpha to: aTargetAlpha progress: aProgress);
						updatePositions ] ];
			onFinishedDo: [ self hoverAnimationToken = aToken ifTrue: [
				animatedHoverBounds := aTargetAlpha > 0.0 ifTrue: [ aTargetBounds ] ifFalse: [ nil ].
				animatedHoverCornerRadius := aTargetRadius.
				animatedHoverAlpha := aTargetAlpha.
				self updatePositions ] ];
			yourself)
]

{ #category : 'accessing' }
CgtEditorOverlay >> animatedHoverAlpha: aNumber [
	animatedHoverAlpha := aNumber
]

{ #category : 'accessing' }
CgtEditorOverlay >> animatedHoverBounds: aRectangleOrNil [
	animatedHoverBounds := aRectangleOrNil
]

{ #category : 'accessing' }
CgtEditorOverlay >> animatedHoverCornerRadius: aNumber [
	animatedHoverCornerRadius := aNumber
]

{ #category : 'accessing' }
CgtEditorOverlay >> hoverAnimationToken [
	^ hoverAnimationToken
]

{ #category : 'private - hover animation' }
CgtEditorOverlay >> interpolateBoundsFrom: aStartBounds to: anEndBounds progress: aProgress [
	| anOrigin aCorner |
	anOrigin := self interpolatePointFrom: aStartBounds origin to: anEndBounds origin progress: aProgress.
	aCorner := self interpolatePointFrom: aStartBounds corner to: anEndBounds corner progress: aProgress.
	^ anOrigin corner: aCorner
]

{ #category : 'private - hover animation' }
CgtEditorOverlay >> interpolateNumberFrom: aStartNumber to: anEndNumber progress: aProgress [
	^ aStartNumber + ((anEndNumber - aStartNumber) * aProgress)
]

{ #category : 'private - hover animation' }
CgtEditorOverlay >> interpolatePointFrom: aStartPoint to: anEndPoint progress: aProgress [
	^ (self interpolateNumberFrom: aStartPoint x to: anEndPoint x progress: aProgress)
		@ (self interpolateNumberFrom: aStartPoint y to: anEndPoint y progress: aProgress)
]

{ #category : 'private - hover animation' }
CgtEditorOverlay >> targetHoverAlpha [
	(state hoverElement isNil or: [ state isHoverOnSelected ]) ifTrue: [ ^ 0.0 ].
	^ state hoverTransparencyForCurrentHover
]

{ #category : 'private - hover animation' }
CgtEditorOverlay >> targetHoverBounds [
	(state hoverElement isNil or: [ state isHoverOnSelected ]) ifTrue: [ ^ nil ].
	^ self overlayBoundsFor: state hoverElement
]

{ #category : 'private - hover animation' }
CgtEditorOverlay >> targetHoverCornerRadius [
	| aBounds |
	(state hoverElement isNil or: [ state isHoverOnSelected ]) ifTrue: [ ^ state defaultCornerRadius ].
	aBounds := self targetHoverBounds.
	aBounds ifNil: [ ^ state defaultCornerRadius ].
	^ (self roundedGeometryFor: state hoverElement bounds: aBounds) cornerRadii max
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
	self stateChanged
]

{ #category : 'private' }
CgtEditorOverlay >> stateChanged [
	self syncObservedElements.
	self updatePositions.
	self animateHoverTransition
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
