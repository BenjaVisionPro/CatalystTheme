Class {
	#name : 'CgtOverlayGeometryCalculator',
	#superclass : 'Object',
	#instVars : [
		'model',
		'overlay'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
	#comment : 'I am responsible for calculating overlay geometry and opacity stepping. I derive mask bounds, concentric outsets, corner radii, coincidence counts, and incremental opacity values so rendering policy stays out of the overlay element itself.'
}

{ #category : 'accessing' }
CgtOverlayGeometryCalculator >> model [
	^ model
]

{ #category : 'accessing' }
CgtOverlayGeometryCalculator >> model: anOverlayModel [
	model := anOverlayModel
]

{ #category : 'accessing' }
CgtOverlayGeometryCalculator >> overlay [
	^ overlay
]

{ #category : 'accessing' }
CgtOverlayGeometryCalculator >> overlay: anOverlay [
	overlay := anOverlay
]

{ #category : 'geometry - extents' }
CgtOverlayGeometryCalculator >> maskOutsetForLayerLevel: aLayerLevel [
	^ model maskOutset + ((aLayerLevel max: 0) * model maskLayerStep)
]

{ #category : 'geometry - extents' }
CgtOverlayGeometryCalculator >> outerPaneBounds [
	^ overlay dimBounds insetBy: model outerPaneInset
]

{ #category : 'geometry - extents' }
CgtOverlayGeometryCalculator >> overlayBoundsFor: anOverlayedElement layerLevel: aLayerLevel [
	| aBounds leftOutset rightOutset topOutset bottomOutset |
	aBounds := overlay elementLocalBoundsFor: anOverlayedElement.
	aBounds ifNil: [ ^ nil ].
	leftOutset := self leftOutsetFor: anOverlayedElement bounds: aBounds layerLevel: aLayerLevel.
	rightOutset := self rightOutsetFor: anOverlayedElement bounds: aBounds layerLevel: aLayerLevel.
	topOutset := self topOutsetFor: anOverlayedElement bounds: aBounds layerLevel: aLayerLevel.
	bottomOutset := self bottomOutsetFor: anOverlayedElement bounds: aBounds layerLevel: aLayerLevel.
	^ (aBounds origin x - leftOutset @ (aBounds origin y - topOutset))
		corner: (aBounds corner x + rightOutset @ (aBounds corner y + bottomOutset))
]

{ #category : 'geometry - corners' }
CgtOverlayGeometryCalculator >> cornerRadiusFor: anElement layerLevel: aLayerLevel [
	| aRadius extraCornerSteps |
	aRadius := model defaultCornerRadius.
	(anElement geometry isKindOf: BlRoundedRectangleGeometry)
		ifTrue: [ aRadius := anElement geometry cornerRadii max ].
	extraCornerSteps := self cornerSeparationStepCountFor: anElement.
	^ aRadius + ((aLayerLevel max: 0) * model cornerRadiusStep) + (extraCornerSteps * model cornerRadiusStep)
]

{ #category : 'rendering - opacity' }
CgtOverlayGeometryCalculator >> finalMaskOpacityForTransparency: aTransparency [
	^ (((1.0 - aTransparency) max: 0.0) min: 1.0)
]

{ #category : 'rendering - opacity' }
CgtOverlayGeometryCalculator >> cutAlphaToReachOpacity: aTargetOpacity fromCurrentOpacity: aCurrentOpacity [
	| currentOpacity targetOpacity |
	currentOpacity := (aCurrentOpacity max: 0.0) min: 1.0.
	targetOpacity := (aTargetOpacity max: 0.0) min: 1.0.
	currentOpacity <= 0.0 ifTrue: [ ^ 0.0 ].
	targetOpacity >= currentOpacity ifTrue: [ ^ 0.0 ].
	^ ((1.0 - (targetOpacity / currentOpacity)) max: 0.0) min: 1.0
]

{ #category : 'rendering - opacity' }
CgtOverlayGeometryCalculator >> scopeAlphaAtIndex: anIndex totalCount: aCount forPresentationKind: aSymbol [
	| alpha |
	alpha := model scopeTransparencyAtIndex: anIndex totalCount: aCount.
	^ aSymbol = #primary ifTrue: [ alpha ] ifFalse: [ alpha * 0.5 ]
]

{ #category : 'geometry - extents' }
CgtOverlayGeometryCalculator >> bounds: aBounds edge: anEdgeSymbol [
	anEdgeSymbol = #left ifTrue: [ ^ aBounds origin x ].
	anEdgeSymbol = #right ifTrue: [ ^ aBounds corner x ].
	anEdgeSymbol = #top ifTrue: [ ^ aBounds origin y ].
	anEdgeSymbol = #bottom ifTrue: [ ^ aBounds corner y ].
	^ 0
]

{ #category : 'geometry - extents' }
CgtOverlayGeometryCalculator >> leftOutsetFor: anElement bounds: aBounds layerLevel: aLayerLevel [
	^ (self maskOutsetForLayerLevel: aLayerLevel)
		+ ((self coincidentInnerEdgeCountFor: anElement bounds: aBounds edge: #left) * model maskLayerStep)
]

{ #category : 'geometry - extents' }
CgtOverlayGeometryCalculator >> rightOutsetFor: anElement bounds: aBounds layerLevel: aLayerLevel [
	^ (self maskOutsetForLayerLevel: aLayerLevel)
		+ ((self coincidentInnerEdgeCountFor: anElement bounds: aBounds edge: #right) * model maskLayerStep)
]

{ #category : 'geometry - extents' }
CgtOverlayGeometryCalculator >> topOutsetFor: anElement bounds: aBounds layerLevel: aLayerLevel [
	^ (self maskOutsetForLayerLevel: aLayerLevel)
		+ ((self coincidentInnerEdgeCountFor: anElement bounds: aBounds edge: #top) * model maskLayerStep)
]

{ #category : 'geometry - extents' }
CgtOverlayGeometryCalculator >> bottomOutsetFor: anElement bounds: aBounds layerLevel: aLayerLevel [
	^ (self maskOutsetForLayerLevel: aLayerLevel)
		+ ((self coincidentInnerEdgeCountFor: anElement bounds: aBounds edge: #bottom) * model maskLayerStep)
]

{ #category : 'geometry - extents' }
CgtOverlayGeometryCalculator >> coincidentInnerEdgeCountFor: anElement bounds: aBounds edge: anEdgeSymbol [
	| edgeValue innerBounds |
	edgeValue := self bounds: aBounds edge: anEdgeSymbol.
	innerBounds := self innerReferenceBoundsForUpstreamElement: anElement.
	^ innerBounds count: [ :eachBounds |
		((edgeValue - (self bounds: eachBounds edge: anEdgeSymbol)) abs) <= model edgeCoincidenceTolerance ]
]

{ #category : 'geometry - corners' }
CgtOverlayGeometryCalculator >> cornerSeparationStepCountFor: anElement [
	| aBounds innerBounds corners |
	aBounds := overlay elementLocalBoundsFor: anElement.
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

{ #category : 'geometry - corners' }
CgtOverlayGeometryCalculator >> coincidentInnerCornerCountFor: aPoint in: aCollection [
	^ aCollection count: [ :eachPoint |
		((aPoint x - eachPoint x) abs <= model cornerCoincidenceTolerance)
			and: [ (aPoint y - eachPoint y) abs <= model cornerCoincidenceTolerance ] ]
]

{ #category : 'geometry - references' }
CgtOverlayGeometryCalculator >> innerReferenceBoundsForUpstreamElement: anElement [
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
		eachBounds := overlay elementLocalBoundsFor: eachElement.
		eachBounds ifNotNil: [ bounds add: eachBounds ] ].
	^ bounds
]
