Class {
	#name : 'CgtEditorOverlay',
	#superclass : 'BlElement',
	#instVars : [
		'model',
		'eventHandler',
		'maskLayer',
		'observedElements',
		'overlayOpacity',
		'fadeAnimationToken',
		'hoverAnimationToken',
		'animatedHoverBounds',
		'animatedHoverCornerRadius',
		'animatedHoverAlpha',
		'hoverVisibility',
		'hoverVisibilityTarget',
		'hoverVisibilityAnimationToken'
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
	model clickHoverElement.
	self stateChanged
]

{ #category : 'accessing' }
CgtEditorOverlay >> childScopeElement [
	^ model childScopeElement
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
CgtEditorOverlay >> cutOutBounds: aBounds cornerRadius: aCornerRadius alpha: anAlpha onSpartaCanvas: aCanvas [
	| aGeometry |
	(aBounds isNil or: [ anAlpha <= 0.0 ]) ifTrue: [ ^ self ].
	aGeometry := (BlRoundedRectangleGeometry cornerRadius: aCornerRadius)
		matchExtent: aBounds extent;
		yourself.
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
CgtEditorOverlay >> cutOutElement: anElement alpha: anAlpha onSpartaCanvas: aCanvas [
	self
		cutOutElement: anElement
		alpha: anAlpha
		layerLevel: 0
		onSpartaCanvas: aCanvas
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> cutOutElement: anElement alpha: anAlpha layerLevel: aLayerLevel onSpartaCanvas: aCanvas [
	| aBounds aCornerRadius |
	anElement ifNil: [ ^ self ].
	aBounds := self overlayBoundsFor: anElement layerLevel: aLayerLevel.
	aBounds ifNil: [ ^ self ].
	aCornerRadius := self cornerRadiusFor: anElement layerLevel: aLayerLevel.
	self cutOutBounds: aBounds cornerRadius: aCornerRadius alpha: anAlpha onSpartaCanvas: aCanvas
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> dimBounds [
	^ self bounds inLocal asRectangle
]


{ #category : 'private - rendering' }
CgtEditorOverlay >> maskOutsetForLayerLevel: aLayerLevel [
	^ model maskOutset + ((aLayerLevel max: 0) * model maskLayerStep)
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> outerPaneBounds [
	^ self dimBounds insetBy: model outerPaneInset
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> drawDimOnSpartaCanvas: aCanvas [
	aCanvas fill
		path: self dimBounds;
		paint: (Color black alpha: (model dimOpacity * overlayOpacity));
		draw
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> drawHoverOnSpartaCanvas: aCanvas [
	| visibleAlpha |
	visibleAlpha := animatedHoverAlpha * self hoverVisibility.
	(animatedHoverBounds isNil or: [ visibleAlpha <= 0.0 ]) ifTrue: [ ^ self ].
	self
		cutOutBounds: animatedHoverBounds
		cornerRadius: animatedHoverCornerRadius
		alpha: visibleAlpha
		onSpartaCanvas: aCanvas
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> drawOuterPaneMaskOnSpartaCanvas: aCanvas [
	self
		cutOutBounds: self outerPaneBounds
		cornerRadius: model outerPaneCornerRadius
		alpha: model outerPaneTransparency
		onSpartaCanvas: aCanvas
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> drawUpstreamScopesOnSpartaCanvas: aCanvas [
	| previousOpacity targetTransparency targetOpacity cutAlpha upstreamCount |
	self primaryPathPresentation ifNil: [ ^ self ].
	upstreamCount := self upstreamElements size.
	previousOpacity := self finalMaskOpacityForTransparency: model outerPaneTransparency.
	self upstreamElements withIndexDo: [ :eachElement :anIndex |
		| layerLevel |
		layerLevel := upstreamCount - anIndex + 1.
		targetTransparency := self scopeAlphaAtIndex: anIndex totalCount: upstreamCount forPresentationKind: #primary.
		targetOpacity := self finalMaskOpacityForTransparency: targetTransparency.
		cutAlpha := self
			cutAlphaToReachOpacity: targetOpacity
			fromCurrentOpacity: previousOpacity.
		self
			cutOutElement: eachElement
			alpha: cutAlpha
			layerLevel: layerLevel
			onSpartaCanvas: aCanvas.
		previousOpacity := targetOpacity ]
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> finalMaskOpacityForTransparency: aTransparency [
	^ ((1.0 - aTransparency) max: 0.0) min: 1.0
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> cutAlphaToReachOpacity: aTargetOpacity fromCurrentOpacity: aCurrentOpacity [
	| currentOpacity targetOpacity |
	currentOpacity := (aCurrentOpacity max: 0.0) min: 1.0.
	targetOpacity := (aTargetOpacity max: 0.0) min: 1.0.
	currentOpacity <= 0.0 ifTrue: [ ^ 0.0 ].
	targetOpacity >= currentOpacity ifTrue: [ ^ 0.0 ].
	^ ((1.0 - (targetOpacity / currentOpacity)) max: 0.0) min: 1.0
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> drawSelectionOnSpartaCanvas: aCanvas [
	self anchorElement ifNotNil: [
		self
			cutOutElement: self anchorElement
			alpha: model selectedElementTransparency
			layerLevel: 0
			onSpartaCanvas: aCanvas ].
	self childScopeElement ifNotNil: [
		self
			cutOutElement: self childScopeElement
			alpha: model childScopeTransparency
			layerLevel: 0
			onSpartaCanvas: aCanvas ]
]




{ #category : 'accessing' }
CgtEditorOverlay >> anchorElement [
	^ model anchorElement
]

{ #category : 'testing' }
CgtEditorOverlay >> hoverIsAnchor [
	^ model hoverIsAnchor
]

{ #category : 'accessing' }
CgtEditorOverlay >> observedElements [
	^ observedElements ifNil: [ #() ]
]

{ #category : 'accessing' }
CgtEditorOverlay >> pathPresentations [
	^ model pathPresentations
]

{ #category : 'accessing' }
CgtEditorOverlay >> primaryPathPresentation [
	^ model primaryPathPresentation
]

{ #category : 'accessing' }
CgtEditorOverlay >> upstreamElements [
	| aPath |
	aPath := model primaryPath.
	^ aPath ifNil: [ #() ] ifNotNil: [ aPath upstreamElements ]
]

{ #category : 'accessing' }
CgtEditorOverlay >> downstreamElements [
	| aPath |
	aPath := model primaryPath.
	^ aPath ifNil: [ #() ] ifNotNil: [ aPath downstreamElements ]
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> anchorAlphaForPresentationKind: aSymbol [
	^ aSymbol = #primary ifTrue: [ 1.0 ] ifFalse: [ 0.55 ]
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> downstreamAlphaForPresentationKind: aSymbol [
	^ aSymbol = #primary ifTrue: [ 0.35 ] ifFalse: [ 0.2 ]
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> scopeAlphaAtIndex: anIndex totalCount: aCount forPresentationKind: aSymbol [
	| alpha |
	alpha := model scopeTransparencyAtIndex: anIndex totalCount: aCount.
	^ aSymbol = #primary ifTrue: [ alpha ] ifFalse: [ alpha * 0.5 ]
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> drawPathPresentation: aPathPresentation onSpartaCanvas: aCanvas [
	self drawUpstreamScopesOnSpartaCanvas: aCanvas.
	self drawSelectionOnSpartaCanvas: aCanvas
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
	^ model hoverElement
]

{ #category : 'accessing' }
CgtEditorOverlay >> hoverElement: anElementOrNil [
	model hoverElement == anElementOrNil ifTrue: [ ^ self ].
	model hoverElement: anElementOrNil.
	self stateChanged
]

{ #category : 'initialization' }
CgtEditorOverlay >> initialize [
	super initialize.
	model := CgtViewTreeOverlayModel new.
	overlayOpacity := 1.0.
	fadeAnimationToken := 0.
	hoverAnimationToken := 0.
	animatedHoverBounds := nil.
	animatedHoverCornerRadius := model defaultCornerRadius.
	animatedHoverAlpha := 0.0.
	hoverVisibility := 0.0.
	hoverVisibilityTarget := 0.0.
	hoverVisibilityAnimationToken := 0.
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
	^ model isDescendantOfSelection: anElement
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
CgtEditorOverlay >> elementLocalBoundsFor: anOverlayedElement [
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
	^ (minX @ minY) corner: (maxX @ maxY)
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> overlayBoundsFor: anOverlayedElement [
	^ self overlayBoundsFor: anOverlayedElement layerLevel: 0
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> overlayBoundsFor: anOverlayedElement layerLevel: aLayerLevel [
	| aBounds leftOutset rightOutset topOutset bottomOutset |
	aBounds := self elementLocalBoundsFor: anOverlayedElement.
	aBounds ifNil: [ ^ nil ].
	leftOutset := self leftOutsetFor: anOverlayedElement bounds: aBounds layerLevel: aLayerLevel.
	rightOutset := self rightOutsetFor: anOverlayedElement bounds: aBounds layerLevel: aLayerLevel.
	topOutset := self topOutsetFor: anOverlayedElement bounds: aBounds layerLevel: aLayerLevel.
	bottomOutset := self bottomOutsetFor: anOverlayedElement bounds: aBounds layerLevel: aLayerLevel.
	^ (aBounds origin x - leftOutset @ (aBounds origin y - topOutset))
		corner: (aBounds corner x + rightOutset @ (aBounds corner y + bottomOutset))
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
		self drawOuterPaneMaskOnSpartaCanvas: aCanvas.
		self drawUpstreamScopesOnSpartaCanvas: aCanvas.
		self drawSelectionOnSpartaCanvas: aCanvas.
		self drawHoverOnSpartaCanvas: aCanvas ]
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> cornerRadiusFor: anElement layerLevel: aLayerLevel [
	| aRadius extraCornerSteps |
	aRadius := model defaultCornerRadius.
	(anElement geometry isKindOf: BlRoundedRectangleGeometry)
		ifTrue: [ aRadius := anElement geometry cornerRadii max ].
	extraCornerSteps := self cornerSeparationStepCountFor: anElement.
	^ aRadius + model maskOutset + ((aLayerLevel max: 0) * model cornerRadiusStep) + (extraCornerSteps * model cornerRadiusStep)
]


{ #category : 'private - rendering' }
CgtEditorOverlay >> roundedGeometryFor: anElement bounds: aRectangle [
	^ (BlRoundedRectangleGeometry cornerRadius: (self cornerRadiusFor: anElement layerLevel: 0))
		matchExtent: aRectangle extent;
		yourself
]




{ #category : 'private - rendering' }
CgtEditorOverlay >> bounds: aBounds edge: anEdgeSymbol [
	anEdgeSymbol = #left ifTrue: [ ^ aBounds origin x ].
	anEdgeSymbol = #right ifTrue: [ ^ aBounds corner x ].
	anEdgeSymbol = #top ifTrue: [ ^ aBounds origin y ].
	anEdgeSymbol = #bottom ifTrue: [ ^ aBounds corner y ].
	^ 0
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> bottomOutsetFor: anElement bounds: aBounds layerLevel: aLayerLevel [
	^ (self maskOutsetForLayerLevel: aLayerLevel)
		+ ((self coincidentInnerEdgeCountFor: anElement bounds: aBounds edge: #bottom) * model maskLayerStep)
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> coincidentInnerCornerCountFor: aPoint in: aCollection [
	^ aCollection count: [ :eachPoint |
		((aPoint x - eachPoint x) abs <= model cornerCoincidenceTolerance)
			and: [ (aPoint y - eachPoint y) abs <= model cornerCoincidenceTolerance ] ]
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> coincidentInnerEdgeCountFor: anElement bounds: aBounds edge: anEdgeSymbol [
	| edgeValue innerBounds |
	edgeValue := self bounds: aBounds edge: anEdgeSymbol.
	innerBounds := self innerReferenceBoundsForUpstreamElement: anElement.
	^ innerBounds count: [ :eachBounds |
		((edgeValue - (self bounds: eachBounds edge: anEdgeSymbol)) abs) <= model edgeCoincidenceTolerance ]
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> cornerSeparationStepCountFor: anElement [
	| aBounds innerBounds corners |
	aBounds := self elementLocalBoundsFor: anElement.
	aBounds ifNil: [ ^ 0 ].
	innerBounds := self innerReferenceBoundsForUpstreamElement: anElement.
	innerBounds ifEmpty: [ ^ 0 ].
	corners := {
		aBounds origin.
		aBounds origin x @ aBounds corner y.
		aBounds corner x @ aBounds origin y.
		aBounds corner }.
	^ corners inject: 0 into: [ :maxCount :eachCorner |
		| innerCorners |
		innerCorners := OrderedCollection new.
		innerBounds do: [ :eachBounds |
			innerCorners
				add: eachBounds origin;
				add: (eachBounds origin x @ eachBounds corner y);
				add: (eachBounds corner x @ eachBounds origin y);
				add: eachBounds corner ].
		maxCount max: (self coincidentInnerCornerCountFor: eachCorner in: innerCorners) ]
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> innerReferenceBoundsForUpstreamElement: anElement [
	| aPath upstreamElements currentIndex innerElements bounds |
	aPath := model primaryPath.
	aPath ifNil: [ ^ #() ].
	upstreamElements := aPath upstreamElements asOrderedCollection.
	currentIndex := upstreamElements indexOf: anElement ifAbsent: [ ^ #() ].
	innerElements := OrderedCollection new.
	(currentIndex + 1 to: upstreamElements size) do: [ :anIndex |
		innerElements add: (upstreamElements at: anIndex) ].
	aPath anchorElement ifNotNil: [ :anAnchor | innerElements add: anAnchor ].
	bounds := OrderedCollection new.
	innerElements do: [ :eachElement |
		| eachBounds |
		eachBounds := self elementLocalBoundsFor: eachElement.
		eachBounds ifNotNil: [ bounds add: eachBounds ] ].
	^ bounds
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> leftOutsetFor: anElement bounds: aBounds layerLevel: aLayerLevel [
	^ (self maskOutsetForLayerLevel: aLayerLevel)
		+ ((self coincidentInnerEdgeCountFor: anElement bounds: aBounds edge: #left) * model maskLayerStep)
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> rightOutsetFor: anElement bounds: aBounds layerLevel: aLayerLevel [
	^ (self maskOutsetForLayerLevel: aLayerLevel)
		+ ((self coincidentInnerEdgeCountFor: anElement bounds: aBounds edge: #right) * model maskLayerStep)
]

{ #category : 'private - rendering' }
CgtEditorOverlay >> topOutsetFor: anElement bounds: aBounds layerLevel: aLayerLevel [
	^ (self maskOutsetForLayerLevel: aLayerLevel)
		+ ((self coincidentInnerEdgeCountFor: anElement bounds: aBounds edge: #top) * model maskLayerStep)
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
	(model hoverElement isNil or: [ self hoverIsAnchor ]) ifTrue: [ ^ 0.0 ].
	^ model hoverTransparencyForCurrentHover
]

{ #category : 'private - hover animation' }
CgtEditorOverlay >> targetHoverBounds [
	(model hoverElement isNil or: [ self hoverIsAnchor ]) ifTrue: [ ^ nil ].
	^ self overlayBoundsFor: model hoverElement
]

{ #category : 'private - hover animation' }
CgtEditorOverlay >> targetHoverCornerRadius [
	(model hoverElement isNil or: [ self hoverIsAnchor ]) ifTrue: [ ^ model defaultCornerRadius ].
	^ self cornerRadiusFor: model hoverElement layerLevel: 0
]

{ #category : 'accessing' }
CgtEditorOverlay >> selectElement: anElementOrNil [
	model setPrimaryAnchorElement: anElementOrNil.
	self stateChanged
]

{ #category : 'accessing' }
CgtEditorOverlay >> selectedElement [
	^ model anchorElement
]

{ #category : 'accessing' }
CgtEditorOverlay >> showElement: anElement [
	(self observedElements includes: anElement)
		ifTrue: [ self stateChanged ]
]

{ #category : 'accessing' }
CgtEditorOverlay >> state [
	^ model
]

{ #category : 'accessing' }
CgtEditorOverlay >> state: aState [
	model := aState.
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
	theNewObservedElements := model observedElements asOrderedCollection.
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
	model toggleScopeElement: anElement.
	self stateChanged
]

{ #category : 'accessing' }
CgtEditorOverlay >> updatePositions [
	maskLayer invalidate
]


{ #category : 'api - hover tracking' }
CgtEditorOverlay >> beginHoverTracking [
	self animateHoverVisibilityTo: 1.0 duration: self hoverFadeInDuration milliSeconds
]

{ #category : 'api - hover tracking' }
CgtEditorOverlay >> endHoverTracking [
	self animateHoverVisibilityTo: 0.0 duration: self hoverFadeOutDuration milliSeconds
]



{ #category : 'private - hover tracking' }
CgtEditorOverlay >> hoverFadeInDuration [
	^ model ifNil: [ 100 ] ifNotNil: [ model hoverFadeInDurationMs ifNil: [ 100 ] ]
]

{ #category : 'private - hover tracking' }
CgtEditorOverlay >> hoverFadeOutDuration [
	^ model ifNil: [ 300 ] ifNotNil: [ model hoverFadeOutDurationMs ifNil: [ 300 ] ]
]

{ #category : 'private - hover tracking' }
CgtEditorOverlay >> animateHoverVisibilityTo: aNumber duration: aDuration [
	| aToken aStartVisibility |
	(hoverVisibilityTarget ifNil: [ 0.0 ]) = aNumber ifTrue: [ ^ self ].
	hoverVisibilityTarget := aNumber.
	hoverVisibilityAnimationToken := (hoverVisibilityAnimationToken ifNil: [ 0 ]) + 1.
	aToken := hoverVisibilityAnimationToken.
	aStartVisibility := hoverVisibility ifNil: [ 0.0 ].
	self addAnimation: (BlNumberTransition new
			from: aStartVisibility;
			to: aNumber;
			duration: aDuration;
			onStepDo: [ :aVisibility :anOverlay |
				anOverlay hoverVisibilityAnimationToken = aToken ifTrue: [
					anOverlay hoverVisibility: aVisibility ] ];
			onFinishedDo: [ self hoverVisibilityAnimationToken = aToken ifTrue: [ self hoverVisibility: aNumber ] ];
			yourself)
]

{ #category : 'accessing' }
CgtEditorOverlay >> hoverVisibility [ ^ hoverVisibility ifNil: [ 0.0 ] ]

{ #category : 'accessing' }
CgtEditorOverlay >> hoverVisibility: aNumber [
	hoverVisibility := aNumber.
	self updatePositions
]

{ #category : 'accessing' }
CgtEditorOverlay >> hoverVisibilityAnimationToken [ ^ hoverVisibilityAnimationToken ifNil: [ 0 ] ]
