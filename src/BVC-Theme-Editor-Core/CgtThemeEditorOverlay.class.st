Class {
	#name : 'CgtThemeEditorOverlay',
	#superclass : 'BlElement',
	#instVars : [
		'targetElement',
		'dimLayer',
		'dimElements',
		'highlight',
		'selection',
		'elementToHighlight',
		'elementToSelect',
		'eventHandler',
		'regions',
		'visualLayer',
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
	| aPreviousElementToHighlight targetRectangle startRectangle |
	aPreviousElementToHighlight := elementToHighlight.
	startRectangle := animatedHoverRectangle
		ifNil: [
			aPreviousElementToHighlight
				ifNotNil: [ self boundsRectFor: aPreviousElementToHighlight ]
				ifNil: [ nil ] ].
	elementToHighlight := anElementOrNil.
	self removeEventHandlerFromElementToHighlightOrSelect: aPreviousElementToHighlight.
	anElementOrNil
		ifNil: [
			highlight visibility: BlVisibility gone.
			self animateHoverRectangleFrom: startRectangle to: nil ]
		ifNotNil: [ :anElement |
			self addEventHandlerToElementToHighlightOrSelect: anElement.
			targetRectangle := self boundsRectFor: anElement.
			highlight visibility: BlVisibility visible.
			self animateHoverRectangleFrom: startRectangle to: targetRectangle ].
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
	hoverBoundsAnimation := nil.
	animatedHoverRectangle := nil.
	regions := OrderedCollection new.
	visualLayer := BlElement new
		constraintsDo: [ :c |
			c ignoreByLayout.
			c horizontal matchParent.
			c vertical matchParent ];
		preventMeAndChildrenMouseEvents;
		yourself.
	dimElements := OrderedCollection new.
	dimLayer := BlElement new
		constraintsDo: [ :c |
			c ignoreByLayout.
			c horizontal matchParent.
			c vertical matchParent ];
		yourself.
	highlight := BlPolygonElement new
		vertices: (self rectangleVerticesFor: ((0 @ 0) corner: (0 @ 0)));
		background: Color transparent;
		border: (BlBorder paint: (Color r: 0.9 g: 0.78 b: 0.28 alpha: 0.9) width: 2);
		visibility: BlVisibility gone.
	selection := BlPolygonElement new
		vertices: (self rectangleVerticesFor: ((0 @ 0) corner: (0 @ 0)));
		background: Color transparent;
		border: (BlBorder paint: (Color r: 0.65 g: 0.45 b: 1.0 alpha: 1.0) width: 2);
		visibility: BlVisibility gone.
	visualLayer addChild: dimLayer.
	visualLayer addChild: highlight.
	visualLayer addChild: selection.
	self addChild: visualLayer.
	self updatePositions
]

{ #category : 'private - animation' }
CgtThemeEditorOverlay >> animateHoverRectangleFrom: aStartRectangle to: anEndRectangle [
	| animation startRectangle endRectangle |
	hoverBoundsAnimation ifNotNil: [ hoverBoundsAnimation stopIfRunning ].
	anEndRectangle ifNil: [
		animatedHoverRectangle := nil.
		self updatePositions.
		^ self ].
	startRectangle := aStartRectangle ifNil: [ anEndRectangle ].
	endRectangle := anEndRectangle.
	animation := BlNumberTransition new
		from: 0.0;
		to: 1.0;
		duration: 120 milliseconds;
		easing: CgtFastInSlowOutEasing new;
		onStepDo: [ :progress |
			animatedHoverRectangle := self
				interpolateRectangle: startRectangle
				to: endRectangle
				at: progress asFloat.
			self updatePositions ];
		onFinishedDo: [
			animatedHoverRectangle := endRectangle.
			hoverBoundsAnimation := nil.
			self updatePositions ];
		yourself.
	hoverBoundsAnimation := animation.
	self addAnimation: animation
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


{ #category : 'private - geometry' }
CgtThemeEditorOverlay >> roundedCornerSegments [
	^ 6
]

{ #category : 'private - geometry' }
CgtThemeEditorOverlay >> arcVerticesCenter: aPoint radius: aRadius fromDegrees: startDegrees toDegrees: endDegrees segments: segmentCount [
	| effectiveSegmentCount step |
	aRadius <= 0 ifTrue: [ ^ Array with: aPoint ].
	effectiveSegmentCount := segmentCount max: 1.
	step := (endDegrees - startDegrees) asFloat / effectiveSegmentCount asFloat.
	^ (0 to: effectiveSegmentCount) collect: [ :index |
		| angleRadians angleDegrees |
		angleDegrees := startDegrees + (step * index).
		angleRadians := angleDegrees degreesToRadians.
		(aPoint x + (aRadius * angleRadians cos)) @ (aPoint y + (aRadius * angleRadians sin)) ]
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
	points addAll: ((self arcVerticesCenter: (right - radius) @ (top + radius) radius: radius fromDegrees: -90 toDegrees: 0 segments: self roundedCornerSegments) allButFirst).
	points addAll: ((self arcVerticesCenter: (right - radius) @ (bottom - radius) radius: radius fromDegrees: 0 toDegrees: 90 segments: self roundedCornerSegments) allButFirst).
	points addAll: ((self arcVerticesCenter: (left + radius) @ (bottom - radius) radius: radius fromDegrees: 90 toDegrees: 180 segments: self roundedCornerSegments) allButFirst).
	points addAll: ((self arcVerticesCenter: (left + radius) @ (top + radius) radius: radius fromDegrees: 180 toDegrees: 270 segments: self roundedCornerSegments) allButFirst).
	^ points asArray
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
			self updateOverlayElement: selection toMatch: anElement inset: self selectionInset.
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

{ #category : 'private - dimming' }
CgtThemeEditorOverlay >> cellAlphaFor: aRectangle default: aDefaultAlpha [
	| cellCenter coveringRegions winningRegion |
	cellCenter := aRectangle center.
	coveringRegions := regions select: [ :eachRegion |
		| regionRectangle |
		regionRectangle := eachRegion rectangleInOverlay: self.
		regionRectangle notNil and: [ regionRectangle containsPoint: cellCenter ] ].
	coveringRegions ifEmpty: [ ^ aDefaultAlpha ].
	winningRegion := coveringRegions
		inject: coveringRegions first
		into: [ :best :each |
			(self region: each isMoreSpecificThan: best)
				ifTrue: [ each ]
				ifFalse: [ best ] ].
	^ winningRegion dimAlpha
]

{ #category : 'private - dimming' }
CgtThemeEditorOverlay >> region: aRegion isMoreSpecificThan: anotherRegion [
	| aRectangle anotherRectangle aArea anotherArea |
	aRectangle := aRegion rectangleInOverlay: self.
	anotherRectangle := anotherRegion rectangleInOverlay: self.
	aRectangle ifNil: [ ^ false ].
	anotherRectangle ifNil: [ ^ true ].
	aArea := aRectangle width * aRectangle height.
	anotherArea := anotherRectangle width * anotherRectangle height.
	aArea = anotherArea
		ifTrue: [ ^ aRegion priority > anotherRegion priority ].
	^ aArea < anotherArea
]

{ #category : 'private - dimming' }
CgtThemeEditorOverlay >> clampRegionRectangle: aRectangle to: overlayRectangle [
	aRectangle ifNil: [ ^ nil ].
	^ ((aRectangle left max: overlayRectangle left) @ (aRectangle top max: overlayRectangle top))
		corner: ((aRectangle right min: overlayRectangle right) @ (aRectangle bottom min: overlayRectangle bottom))
]

{ #category : 'private - styling' }
CgtThemeEditorOverlay >> dimColorForAlpha: aNumber [
	^ Color black alpha: aNumber
]

{ #category : 'private - dimming' }
CgtThemeEditorOverlay >> ensureDimElementCount: aCount [
	[ dimElements size < aCount ] whileTrue: [
		| anElement |
		anElement := BlPolygonElement new
		vertices: (self rectangleVerticesFor: ((0 @ 0) corner: (0 @ 0)));
		visibility: BlVisibility gone.
		self addDimElement: anElement ].
	[ dimElements size > aCount ] whileTrue: [
		| anElement |
		anElement := dimElements removeLast.
		anElement removeFromParent ]
]

{ #category : 'private - dimming' }
CgtThemeEditorOverlay >> addDimElement: anElement [
	dimLayer addChild: anElement.
	dimElements add: anElement
]

{ #category : 'private - regions' }
CgtThemeEditorOverlay >> hoverRegion [
	elementToHighlight ifNil: [ ^ nil ].
	elementToHighlight = elementToSelect ifTrue: [ ^ nil ].
	^ CgtThemeEditorOverlayRegion new
		element: elementToHighlight;
		dimAlpha: 0.22;
		inset: 0;
		cornerRadius: 6;
		priority: 10;
		yourself
]

{ #category : 'private - regions' }
CgtThemeEditorOverlay >> rebuildRegions [
	regions := OrderedCollection new.
	self hoverRegion ifNotNil: [ :aRegion | regions add: aRegion ].
	self selectionRegion ifNotNil: [ :aRegion | regions add: aRegion ]
]

{ #category : 'private - dimming' }
CgtThemeEditorOverlay >> sortedBreakpointsFrom: numbers start: aStart end: anEnd [
	| filtered |
	filtered := ((numbers select: [ :each | each >= aStart and: [ each <= anEnd ] ]) copyWith: aStart) copyWith: anEnd.
	^ (filtered asSet asSortedCollection) asArray
]

{ #category : 'private - regions' }
CgtThemeEditorOverlay >> selectionInset [
	^ 4
]

{ #category : 'private - regions' }
CgtThemeEditorOverlay >> selectionRegion [
	elementToSelect ifNil: [ ^ nil ].
	^ CgtThemeEditorOverlayRegion new
		element: elementToSelect;
		dimAlpha: 0.0;
		inset: self selectionInset;
		cornerRadius: 10;
		priority: 20;
		yourself
]

{ #category : 'private - dimming' }
CgtThemeEditorOverlay >> updateDimming [
	| overlayRectangle xBreaks yBreaks patches patchIndex defaultAlpha |
	overlayRectangle := (0 @ 0) corner: self extent.
	(self extent x <= 0 or: [ self extent y <= 0 ]) ifTrue: [
		self ensureDimElementCount: 0.
		^ self ].
	self rebuildRegions.
	defaultAlpha := self dimColor alpha.
	xBreaks := self sortedBreakpointsFrom: (regions flatCollect: [ :each |
		| aRectangle |
		aRectangle := self clampRegionRectangle: (each rectangleInOverlay: self) to: overlayRectangle.
		aRectangle ifNil: [ #() ] ifNotNil: [ { aRectangle left. aRectangle right } ] ])
		start: overlayRectangle left
		end: overlayRectangle right.
	yBreaks := self sortedBreakpointsFrom: (regions flatCollect: [ :each |
		| aRectangle |
		aRectangle := self clampRegionRectangle: (each rectangleInOverlay: self) to: overlayRectangle.
		aRectangle ifNil: [ #() ] ifNotNil: [ { aRectangle top. aRectangle bottom } ] ])
		start: overlayRectangle top
		end: overlayRectangle bottom.
	patches := OrderedCollection new.
	1 to: xBreaks size - 1 do: [ :xi |
		1 to: yBreaks size - 1 do: [ :yi |
			| aRectangle alpha |
			aRectangle := (xBreaks at: xi) @ (yBreaks at: yi)
				corner: ((xBreaks at: xi + 1) @ (yBreaks at: yi + 1)).
			((aRectangle width > 0) and: [ aRectangle height > 0 ]) ifTrue: [
				alpha := self cellAlphaFor: aRectangle default: defaultAlpha.
				alpha > 0 ifTrue: [ patches add: { aRectangle. alpha } ] ] ] ].
	self ensureDimElementCount: patches size.
	patchIndex := 1.
	patches do: [ :eachPatch |
		| anElement aRectangle alpha |
		anElement := dimElements at: patchIndex.
		aRectangle := eachPatch first.
		alpha := eachPatch second.
		anElement vertices: (self rectangleVerticesFor: aRectangle).
		anElement background: (self dimColorForAlpha: alpha).
		anElement visibility: BlVisibility visible.
		patchIndex := patchIndex + 1 ]
]

{ #category : 'private' }
CgtThemeEditorOverlay >> updateOverlayElement: anOverlayElement toMatch: anOverlayedElement [
	self updateOverlayElement: anOverlayElement toMatch: anOverlayedElement inset: 0
]

{ #category : 'private' }
CgtThemeEditorOverlay >> updateOverlayElement: anOverlayElement toMatch: anOverlayedElement inset: aNumber [
	| aRectangle aRadius |
	aRectangle := self boundsRectFor: anOverlayedElement.
	aRectangle := ((aRectangle left - aNumber) @ (aRectangle top - aNumber))
		corner: ((aRectangle right + aNumber) @ (aRectangle bottom + aNumber)).
	aRadius := anOverlayElement == selection
		ifTrue: [ self selectionRegion cornerRadius ]
		ifFalse: [ self hoverRegion ifNil: [ 6 ] ifNotNil: [ self hoverRegion cornerRadius ] ].
	self updateOverlayElement: anOverlayElement toMatchRectangle: aRectangle radius: aRadius
]

{ #category : 'private' }
CgtThemeEditorOverlay >> updateOverlayElement: anOverlayElement toMatchRectangle: aRectangle radius: aRadius [
	anOverlayElement
		vertices: (self roundedRectangleVerticesFor: aRectangle radius: aRadius)
]

{ #category : 'private' }
CgtThemeEditorOverlay >> updatePositions [
	elementToSelect ifNotNil: [ :anOverlayedElement |
		self updateOverlayElement: selection toMatch: anOverlayedElement inset: self selectionInset ].
	(elementToHighlight notNil and: [ elementToHighlight ~= elementToSelect ])
		ifTrue: [
			animatedHoverRectangle
				ifNil: [ self updateOverlayElement: highlight toMatch: elementToHighlight ]
				ifNotNil: [ self
					updateOverlayElement: highlight
					toMatchRectangle: animatedHoverRectangle
					radius: self hoverRegion cornerRadius ] ].
	(elementToHighlight isNil or: [ elementToHighlight = elementToSelect ])
		ifTrue: [ highlight visibility: BlVisibility gone ]
		ifFalse: [ highlight visibility: BlVisibility visible ].
	self updateDimming
]



