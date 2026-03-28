Class {
	#name : 'CgtViewTreeOverlayModel',
	#superclass : 'Object',
	#instVars : [
		'hoverElement',
		'pathPresentations',
		'scopeStartTransparency',
		'scopeStepTransparency',
		'hoverTransparency',
		'hoverInsideAnchorTransparency',
		'maskOutset',
		'dimOpacity',
		'blurRadius',
		'defaultCornerRadius',
		'showsMatches',
		'hoverFadeInDurationMs',
		'hoverIdleDurationMs',
		'hoverFadeOutDurationMs',
		'outerPaneTransparency',
		'selectedElementTransparency',
		'childScopeTransparency',
		'maskLayerStep',
		'cornerRadiusStep',
		'outerPaneCornerRadius',
		'outerPaneInset'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtViewTreeOverlayModel >> initialize [
	super initialize.
	pathPresentations := OrderedCollection new.
	outerPaneTransparency := 0.2.
	scopeStartTransparency := 0.6.
	scopeStepTransparency := 0.1.
	selectedElementTransparency := 1.0.
	childScopeTransparency := 0.9.
	hoverTransparency := 0.9.
	hoverInsideAnchorTransparency := 0.05.
	maskOutset := 6.
	maskLayerStep := 8.
	cornerRadiusStep := 8.
	dimOpacity := 1.0.
	blurRadius := 6.
	defaultCornerRadius := 10.
	outerPaneCornerRadius := 36.
	outerPaneInset := 12.
	showsMatches := false.
	hoverFadeInDurationMs := 100.
	hoverIdleDurationMs := 2000.
	hoverFadeOutDurationMs := 2000
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> hoverElement [ ^ hoverElement ]
{ #category : 'accessing' }
CgtViewTreeOverlayModel >> hoverElement: anElementOrNil [ hoverElement := anElementOrNil ]
{ #category : 'accessing' }
CgtViewTreeOverlayModel >> pathPresentations [ ^ (pathPresentations ifNil: [ #() ]) asOrderedCollection copy ]
{ #category : 'accessing' }
CgtViewTreeOverlayModel >> pathPresentations: aCollection [ pathPresentations := (aCollection ifNil: [ #() ]) asOrderedCollection ]
{ #category : 'accessing' }
CgtViewTreeOverlayModel >> showsMatches [ ^ showsMatches ifNil: [ false ] ]
{ #category : 'accessing' }
CgtViewTreeOverlayModel >> showsMatches: aBoolean [ showsMatches := aBoolean ]
{ #category : 'accessing' }
CgtViewTreeOverlayModel >> maskOutset [ ^ maskOutset ]
{ #category : 'accessing' }
CgtViewTreeOverlayModel >> maskLayerStep [ ^ maskLayerStep ifNil: [ 8 ] ]
{ #category : 'accessing' }
CgtViewTreeOverlayModel >> cornerRadiusStep [ ^ cornerRadiusStep ifNil: [ 8 ] ]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> edgeCoincidenceTolerance [ ^ ((self maskLayerStep max: maskOutset) + 2) ]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> cornerCoincidenceTolerance [ ^ self edgeCoincidenceTolerance + 2 ]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> dimOpacity [ ^ dimOpacity ]
{ #category : 'accessing' }
CgtViewTreeOverlayModel >> blurRadius [ ^ blurRadius ]
{ #category : 'accessing' }
CgtViewTreeOverlayModel >> defaultCornerRadius [ ^ defaultCornerRadius ]
{ #category : 'accessing' }
CgtViewTreeOverlayModel >> outerPaneTransparency [ ^ outerPaneTransparency ifNil: [ 0.2 ] ]
{ #category : 'accessing' }
CgtViewTreeOverlayModel >> outerPaneCornerRadius [ ^ outerPaneCornerRadius ifNil: [ 36 ] ]
{ #category : 'accessing' }
CgtViewTreeOverlayModel >> outerPaneInset [ ^ outerPaneInset ifNil: [ 12 ] ]
{ #category : 'accessing' }
CgtViewTreeOverlayModel >> selectedElementTransparency [ ^ selectedElementTransparency ifNil: [ 1.0 ] ]
{ #category : 'accessing' }
CgtViewTreeOverlayModel >> childScopeTransparency [ ^ childScopeTransparency ifNil: [ 0.9 ] ]
{ #category : 'accessing' }
CgtViewTreeOverlayModel >> hoverTransparency [ ^ hoverTransparency ]
{ #category : 'accessing' }
CgtViewTreeOverlayModel >> scopeTransparencyAtIndex: anIndex totalCount: aCount [
	| count clampedIndex position |
	count := aCount ifNil: [ 0 ].
	count <= 1 ifTrue: [ ^ 0.65 ].
	clampedIndex := (anIndex max: 1) min: count.
	position := (clampedIndex - 1) asFloat / (count - 1) asFloat.
	^ 0.4 + (position * 0.25)
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> primaryPathPresentation [
	^ self pathPresentations detect: [ :each | each kind = #primary ] ifNone: [ nil ]
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> primaryPath [
	^ self primaryPathPresentation ifNotNil: [ :each | each elementPath ]
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> matchingPathPresentations [
	^ self pathPresentations select: [ :each | each kind ~= #primary ]
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> anchorElement [
	^ self primaryPath ifNotNil: [ :each | each anchorElement ]
]

{ #category : 'accessing - compatibility' }
CgtViewTreeOverlayModel >> selectedElement [ ^ self anchorElement ]

{ #category : 'accessing - compatibility' }
CgtViewTreeOverlayModel >> childScopeElement [
	| aPath |
	aPath := self primaryPath.
	^ aPath ifNil: [ nil ] ifNotNil: [ aPath downstreamElements ifEmpty: [ nil ] ifNotEmpty: [ :els | els last ] ]
]

{ #category : 'testing' }
CgtViewTreeOverlayModel >> hasPrimaryPath [ ^ self primaryPath notNil ]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> setPrimaryAnchorElement: anElementOrNil [
	anElementOrNil ifNil: [ ^ self deselect ].
	pathPresentations := OrderedCollection with: (CgtViewTreeOverlayPathPresentation path: (CgtElementPath anchorElement: anElementOrNil) kind: #primary)
]

{ #category : 'actions' }
CgtViewTreeOverlayModel >> deselect [
	pathPresentations := OrderedCollection new.
	hoverElement := nil
]

{ #category : 'testing' }
CgtViewTreeOverlayModel >> hoverIsAnchor [
	^ hoverElement notNil and: [ hoverElement == self anchorElement ]
]

{ #category : 'testing - compatibility' }
CgtViewTreeOverlayModel >> isHoverOnSelected [ ^ self hoverIsAnchor ]

{ #category : 'testing' }
CgtViewTreeOverlayModel >> hoverIsOnPrimaryUpstreamPath [
	| aPath |
	aPath := self primaryPath.
	aPath ifNil: [ ^ false ].
	^ aPath upstreamElements includes: hoverElement
]

{ #category : 'testing' }
CgtViewTreeOverlayModel >> hoverIsDescendantOfAnchor [
	^ self isDescendantOfSelection: hoverElement
]

{ #category : 'testing - compatibility' }
CgtViewTreeOverlayModel >> isDescendantOfSelection: anElement [
	| anchor |
	anchor := self anchorElement.
	(anchor isNil or: [ anElement isNil ]) ifTrue: [ ^ false ].
	anElement == anchor ifTrue: [ ^ false ].
	^ anElement hasParent: anchor
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> hoverTransparencyForCurrentHover [
	(self hoverIsDescendantOfAnchor) ifTrue: [ ^ hoverInsideAnchorTransparency ].
	^ hoverTransparency
]

{ #category : 'actions' }
CgtViewTreeOverlayModel >> clickBehaviorForHover [
	hoverElement ifNil: [ ^ #none ].
	self hasPrimaryPath ifFalse: [ ^ #select ].
	self hoverIsAnchor ifTrue: [ ^ #deselect ].
	self hoverIsOnPrimaryUpstreamPath ifTrue: [ ^ #toggleUpstream ].
	self hoverIsDescendantOfAnchor ifTrue: [ ^ #toggleDownstream ].
	^ #select
]

{ #category : 'actions' }
CgtViewTreeOverlayModel >> clickHoverElement [
	| behavior |
	behavior := self clickBehaviorForHover.
	behavior = #none ifTrue: [ ^ self ].
	behavior = #select ifTrue: [ ^ self setPrimaryAnchorElement: hoverElement ].
	behavior = #deselect ifTrue: [ ^ self deselect ].
	behavior = #toggleUpstream ifTrue: [ ^ self primaryPath toggleUpstreamElement: hoverElement ].
	behavior = #toggleDownstream ifTrue: [ ^ self primaryPath toggleDownstreamElement: hoverElement ]
]

{ #category : 'actions - compatibility' }
CgtViewTreeOverlayModel >> toggleScopeElement: anElement [
	self primaryPath ifNotNil: [ :aPath | aPath toggleUpstreamElement: anElement ]
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> observedElements [
	| elements |
	elements := OrderedCollection new.
	hoverElement ifNotNil: [ elements add: hoverElement ].
	self pathPresentations do: [ :eachPresentation |
		eachPresentation elementPath elements do: [ :eachElement |
			(elements includes: eachElement) ifFalse: [ elements add: eachElement ] ] ].
	^ elements
]


{ #category : 'accessing' }
CgtViewTreeOverlayModel >> hoverFadeInDurationMs [ ^ hoverFadeInDurationMs ifNil: [ 100 ] ]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> hoverFadeInDurationMs: aNumber [ hoverFadeInDurationMs := aNumber ]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> hoverIdleDurationMs [ ^ hoverIdleDurationMs ifNil: [ 2000 ] ]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> hoverIdleDurationMs: aNumber [ hoverIdleDurationMs := aNumber ]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> hoverFadeOutDurationMs [ ^ hoverFadeOutDurationMs ifNil: [ 2000 ] ]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> hoverFadeOutDurationMs: aNumber [ hoverFadeOutDurationMs := aNumber ]
