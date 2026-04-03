"
#Matcher Reveal Element
I render one grouped revealed-context section for the custom selector widget. I am responsible for hosting the revealed rows for one expanded gap in the normal layout flow while keeping reveal presentation concerns in the UI layer.
"
Class {
	#name : 'CgtMatcherRevealElement',
	#superclass : 'BrVerticalPane',
	#instVars : [
		'direction',
		'layoutPolicy',
		'contentContainer',
		'viewportContainer',
		'rowElements',
		'transitionPolicy',
		'structuralRefreshPlan'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtMatcherRevealElement >> initialize [
	super initialize.
	layoutPolicy := CgtMatcherLayoutPolicy new.
	transitionPolicy := CgtMatcherTransitionPolicy new.
	structuralRefreshPlan := CgtMatcherStructuralRefreshPlan new.
	rowElements := OrderedCollection new.
	self
		vFitContent;
		hFitContent;
		cellSpacing: 0;
		background: Color transparent;
		border: BlBorder empty;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ].
	contentContainer := BrVerticalPane new
		vFitContent;
		hFitContent;
		cellSpacing: layoutPolicy revealViewportCellSpacing;
		padding: layoutPolicy revealContentInset;
		background: Color transparent;
		border: BlBorder empty;
		yourself.
	viewportContainer := contentContainer asScrollableElement.
	viewportContainer
		background: Color transparent;
		border: BlBorder empty;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ].
	self addChild: viewportContainer.
	self refreshViewportPresentation
]

{ #category : 'accessing' }
CgtMatcherRevealElement >> contentContainer [
	^ contentContainer
]


{ #category : 'accessing' }
CgtMatcherRevealElement >> viewportContainer [
	^ viewportContainer
]

{ #category : 'accessing' }
CgtMatcherRevealElement >> transitionPolicy [
	^ transitionPolicy
]

{ #category : 'accessing' }
CgtMatcherRevealElement >> transitionPolicy: aTransitionPolicy [
	transitionPolicy := aTransitionPolicy ifNil: [ CgtMatcherTransitionPolicy new ].
	^ self
]

{ #category : 'accessing' }
CgtMatcherRevealElement >> structuralRefreshPlan [
	^ structuralRefreshPlan
]

{ #category : 'accessing' }
CgtMatcherRevealElement >> structuralRefreshPlan: aStructuralRefreshPlan [
	structuralRefreshPlan := aStructuralRefreshPlan ifNil: [ CgtMatcherStructuralRefreshPlan new ].
	self refreshViewportPresentation.
	^ self
]

{ #category : 'accessing' }
CgtMatcherRevealElement >> direction [
	^ direction ifNil: [ #upstream ]
]

{ #category : 'accessing' }
CgtMatcherRevealElement >> direction: aSymbol [
	direction := aSymbol ifNil: [ #upstream ].
	self refreshViewportPresentation.
	^ self
]

{ #category : 'accessing' }
CgtMatcherRevealElement >> rowElements [
	^ rowElements copy
]

{ #category : 'accessing' }
CgtMatcherRevealElement >> rowElements: aCollection [
	rowElements := (aCollection ifNil: [ #() ]) asOrderedCollection.
	self refreshContents;
		refreshViewportPresentation.
	^ self
]

{ #category : 'rendering' }
CgtMatcherRevealElement >> refreshContents [
	contentContainer removeChildren.
	rowElements do: [ :each | contentContainer addChild: each ].
	^ self
]

{ #category : 'rendering' }
CgtMatcherRevealElement >> refreshViewportPresentation [
	viewportContainer ifNil: [ ^ self ].
	viewportContainer
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ].
	^ self
]


{ #category : 'testing' }
CgtMatcherRevealElement >> isUpstreamReveal [
	^ self direction = #upstream
]

{ #category : 'testing' }
CgtMatcherRevealElement >> isDownstreamReveal [
	^ self direction = #downstream
]

{ #category : 'accessing' }
CgtMatcherRevealElement >> fixedEdge [
	^ self isUpstreamReveal
		ifTrue: [ #bottom ]
		ifFalse: [ #top ]
]

{ #category : 'accessing' }
CgtMatcherRevealElement >> openingDirection [
	^ self isUpstreamReveal
		ifTrue: [ #up ]
		ifFalse: [ #down ]
]

{ #category : 'testing' }
CgtMatcherRevealElement >> viewportUsesScrollContainer [
	^ viewportContainer notNil
		and: [ viewportContainer ~~ contentContainer ]
]

{ #category : 'testing' }
CgtMatcherRevealElement >> pinsViewportToBottomEdge [
	^ self fixedEdge = #bottom
]

{ #category : 'testing' }
CgtMatcherRevealElement >> pinsViewportToTopEdge [
	^ self fixedEdge = #top
]

{ #category : 'accessing' }
CgtMatcherRevealElement >> maximumViewportHeight [
	^ layoutPolicy revealViewportMaximumHeight
]

{ #category : 'accessing' }
CgtMatcherRevealElement >> minimumViewportHeight [
	^ layoutPolicy revealViewportMinimumHeight
]
