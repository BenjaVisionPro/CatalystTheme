Class {
	#name : 'CgtViewTreeOverlayModel',
	#superclass : 'Object',
	#instVars : [
		'hoverElement',
		'primaryPathPresentation',
		'matchingPathPresentations',
		'scopeStartTransparency',
		'scopeStepTransparency',
		'matchingAnchorTransparency',
		'matchingScopeStartTransparency',
		'matchingScopeStepTransparency',
		'hoverTransparency',
		'hoverInsidePrimaryTransparency',
		'maskOutset',
		'dimOpacity',
		'defaultCornerRadius'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> anchorElement [
	^ self primaryPath ifNotNil: [ :aPath | aPath anchorElement ]
]

{ #category : 'actions' }
CgtViewTreeOverlayModel >> clearMatchingPaths [
	matchingPathPresentations removeAll
]

{ #category : 'actions' }
CgtViewTreeOverlayModel >> clickBehaviorForHover [
	hoverElement ifNil: [ ^ #none ].
	self hasPrimaryPath ifFalse: [ ^ #selectNewPrimary ].
	hoverElement == self anchorElement ifTrue: [ ^ #deselect ].
	(self includesUpstreamPathElement: hoverElement) ifTrue: [ ^ #togglePrimaryUpstream ].
	(self isDescendantOfAnchor: hoverElement) ifTrue: [ ^ #togglePrimaryDownstream ].
	^ #selectNewPrimary
]

{ #category : 'actions' }
CgtViewTreeOverlayModel >> clickHoverElement [
	| aBehavior |
	aBehavior := self clickBehaviorForHover.
	aBehavior = #none ifTrue: [ ^ self ].
	aBehavior = #deselect ifTrue: [ ^ self deselect ].
	aBehavior = #togglePrimaryUpstream ifTrue: [ ^ self togglePrimaryUpstreamElement: hoverElement ].
	aBehavior = #togglePrimaryDownstream ifTrue: [ ^ self togglePrimaryDownstreamElement: hoverElement ].
	aBehavior = #selectNewPrimary ifTrue: [ ^ self selectElement: hoverElement ]
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> defaultCornerRadius [
	^ defaultCornerRadius
]

{ #category : 'actions' }
CgtViewTreeOverlayModel >> deselect [
	primaryPathPresentation := nil.
	self clearMatchingPaths
]

{ #category : 'private' }
CgtViewTreeOverlayModel >> descendantDistanceFrom: anAncestor to: anElement [
	| aDistance eachParent |
	aDistance := 1.
	eachParent := anElement parent.
	[ eachParent notNil ] whileTrue: [
		eachParent == anAncestor ifTrue: [ ^ aDistance ].
		eachParent := eachParent parent.
		aDistance := aDistance + 1 ].
	^ aDistance
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> dimOpacity [
	^ dimOpacity
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> hasPrimaryPath [
	^ primaryPathPresentation notNil and: [ self primaryPath notNil ]
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> hoverElement [
	^ hoverElement
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> hoverElement: anElementOrNil [
	hoverElement := anElementOrNil
]

{ #category : 'testing' }
CgtViewTreeOverlayModel >> hoverIsAnchor [
	^ hoverElement notNil and: [ hoverElement == self anchorElement ]
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> hoverTransparencyForCurrentHover [
	(self hasPrimaryPath and: [ self isDescendantOfAnchor: hoverElement ])
		ifTrue: [ ^ hoverInsidePrimaryTransparency ].
	^ hoverTransparency
]

{ #category : 'testing' }
CgtViewTreeOverlayModel >> includesUpstreamPathElement: anElement [
	self hasPrimaryPath ifFalse: [ ^ false ].
	anElement ifNil: [ ^ false ].
	^ (self upstreamCandidateElements includes: anElement)
]

{ #category : 'initialization' }
CgtViewTreeOverlayModel >> initialize [
	super initialize.
	matchingPathPresentations := OrderedCollection new.
	scopeStartTransparency := 0.85.
	scopeStepTransparency := 0.025.
	matchingAnchorTransparency := 0.55.
	matchingScopeStartTransparency := 0.30.
	matchingScopeStepTransparency := 0.025.
	hoverTransparency := 0.85.
	hoverInsidePrimaryTransparency := 0.05.
	maskOutset := 6.
	dimOpacity := 0.35.
	defaultCornerRadius := 10
]

{ #category : 'testing' }
CgtViewTreeOverlayModel >> isDescendant: anElement of: anAncestor [
	anElement ifNil: [ ^ false ].
	anAncestor ifNil: [ ^ false ].
	anElement == anAncestor ifTrue: [ ^ false ].
	^ anElement hasParent: anAncestor
]

{ #category : 'testing' }
CgtViewTreeOverlayModel >> isDescendantOfAnchor: anElement [
	| anAnchor |
	anAnchor := self anchorElement.
	anAnchor ifNil: [ ^ false ].
	anElement ifNil: [ ^ false ].
	anElement == anAnchor ifTrue: [ ^ false ].
	^ anElement hasParent: anAnchor
]

{ #category : 'testing' }
CgtViewTreeOverlayModel >> isHoverOnSelected [
	^ self hoverIsAnchor
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> maskOutset [
	^ maskOutset
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> matchingAnchorTransparency [
	^ matchingAnchorTransparency
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> matchingPathPresentations [
	^ matchingPathPresentations copy
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> matchingPaths: aCollection [
	matchingPathPresentations := aCollection collect: [ :each |
		(each isKindOf: CgtViewTreeOverlayPathPresentation)
			ifTrue: [ each ]
			ifFalse: [ CgtViewTreeOverlayPathPresentation kind: #matching path: each ] ] as: OrderedCollection
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> matchingScopeStartTransparency [
	^ matchingScopeStartTransparency
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> matchingScopeTransparencyForDistance: aDistance [
	^ (matchingScopeStartTransparency - ((aDistance - 1) * matchingScopeStepTransparency)) max: 0.0
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> observedElements [
	| theElements |
	theElements := OrderedCollection new.
	self pathPresentations do: [ :eachPresentation |
		eachPresentation elementPath elements do: [ :eachElement |
			(theElements includes: eachElement) ifFalse: [ theElements add: eachElement ] ] ].
	hoverElement ifNotNil: [ (theElements includes: hoverElement) ifFalse: [ theElements add: hoverElement ] ].
	^ theElements
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> pathDistanceFromAnchorFor: anElement in: aPath [
	| anAnchor aDistance eachParent |
	anAnchor := aPath anchorElement.
	anAnchor ifNil: [ ^ 0 ].
	anElement == anAnchor ifTrue: [ ^ 0 ].
	eachParent := anAnchor parent.
	aDistance := 1.
	[ eachParent notNil ] whileTrue: [
		eachParent == anElement ifTrue: [ ^ aDistance ].
		eachParent := eachParent parent.
		aDistance := aDistance + 1 ].
	^ (self isDescendant: anElement of: anAnchor)
		ifTrue: [ self descendantDistanceFrom: anAnchor to: anElement ]
		ifFalse: [ 1 ]
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> pathPresentations [
	| thePresentations |
	thePresentations := OrderedCollection new.
	primaryPathPresentation ifNotNil: [ thePresentations add: primaryPathPresentation ].
	thePresentations addAll: matchingPathPresentations.
	^ thePresentations
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> presentationAlphaFor: aPresentation element: anElement [
	| aDistance |
	aDistance := self pathDistanceFromAnchorFor: anElement in: aPresentation elementPath.
	aDistance = 0 ifTrue: [
		^ aPresentation isPrimary
			ifTrue: [ 1.0 ]
			ifFalse: [ matchingAnchorTransparency ] ].
	^ aPresentation isPrimary
		ifTrue: [ self scopeTransparencyForDistance: aDistance ]
		ifFalse: [ self matchingScopeTransparencyForDistance: aDistance ]
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> primaryPath [
	^ primaryPathPresentation ifNotNil: [ :aPresentation | aPresentation elementPath ]
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> primaryPathPresentation [
	^ primaryPathPresentation
]

{ #category : 'actions' }
CgtViewTreeOverlayModel >> resetForNewAnchorElement: anElementOrNil [
	anElementOrNil
		ifNil: [ primaryPathPresentation := nil. self clearMatchingPaths. ^ self ].
	primaryPathPresentation := CgtViewTreeOverlayPathPresentation
		kind: #primary
		path: (CgtElementPath anchorElement: anElementOrNil).
	self clearMatchingPaths
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> scopeStartTransparency [
	^ scopeStartTransparency
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> scopeTransparencyForDistance: aDistance [
	^ (scopeStartTransparency - ((aDistance - 1) * scopeStepTransparency)) max: 0.0
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> selectElement: anElementOrNil [
	self resetForNewAnchorElement: anElementOrNil
]

{ #category : 'actions' }
CgtViewTreeOverlayModel >> togglePrimaryDownstreamElement: anElement [
	| aPath |
	(self isDescendantOfAnchor: anElement) ifFalse: [ ^ self ].
	aPath := self primaryPath ifNil: [ ^ self ].
	(aPath includesElement: anElement)
		ifTrue: [ aPath removeElement: anElement ]
		ifFalse: [ aPath addElement: anElement ].
	self clearMatchingPaths
]

{ #category : 'actions' }
CgtViewTreeOverlayModel >> togglePrimaryUpstreamElement: anElement [
	| aPath |
	(self includesUpstreamPathElement: anElement) ifFalse: [ ^ self ].
	aPath := self primaryPath ifNil: [ ^ self ].
	(aPath includesElement: anElement)
		ifTrue: [ aPath removeElement: anElement ]
		ifFalse: [ aPath addElement: anElement ].
	self clearMatchingPaths
]

{ #category : 'accessing' }
CgtViewTreeOverlayModel >> upstreamCandidateElements [
	| thePath eachParent anAnchor |
	anAnchor := self anchorElement.
	anAnchor ifNil: [ ^ #() ].
	thePath := OrderedCollection new.
	eachParent := anAnchor parent.
	[ eachParent notNil ] whileTrue: [
		thePath add: eachParent.
		eachParent := eachParent parent ].
	^ thePath
]
