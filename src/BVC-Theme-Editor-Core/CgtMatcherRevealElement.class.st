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
		'viewportContentContainer',
		'viewportSpacerElement',
		'viewportContainer',
		'rowElements',
		'transitionPolicy',
		'structuralRefreshPlan',
		'viewportPresentationProgress'
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
	viewportPresentationProgress := 1.
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
	viewportContentContainer := BrVerticalPane new
		vFitContent;
		hFitContent;
		cellSpacing: 0;
		background: Color transparent;
		border: BlBorder empty;
		yourself.
	viewportSpacerElement := BlElement new
		background: Color transparent;
		border: BlBorder empty;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: 0 ];
		yourself.
	viewportContainer := viewportContentContainer asScrollableElement.
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
CgtMatcherRevealElement >> viewportContentContainer [
	^ viewportContentContainer
]


{ #category : 'accessing' }
CgtMatcherRevealElement >> viewportSpacerElement [
	^ viewportSpacerElement
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



{ #category : 'accessing' }
CgtMatcherRevealElement >> viewportPresentationProgress [
	^ viewportPresentationProgress ifNil: [ 1 ]
]

{ #category : 'accessing' }
CgtMatcherRevealElement >> viewportPresentationProgress: aNumber [
	| progress |
	progress := (aNumber ifNil: [ 1 ]) asFloat.
	viewportPresentationProgress := (progress max: 0.0) min: 1.0.
	self refreshViewportPresentation.
	^ self
]

{ #category : 'accessing' }
CgtMatcherRevealElement >> currentViewportHeightForPresentationProgress: aNumber [
	| startHeight endHeight progress |
	startHeight := self viewportStartHeightForCurrentPlan.
	endHeight := self viewportEndHeightForCurrentPlan.
	progress := ((aNumber ifNil: [ 1 ]) asFloat max: 0.0) min: 1.0.
	^ startHeight + ((endHeight - startHeight) * progress)
]

{ #category : 'rendering' }
CgtMatcherRevealElement >> refreshContents [
	contentContainer removeChildren.
	self rowElementsForCurrentViewportPresentation do: [ :each | contentContainer addChild: each ].
	^ self
]

{ #category : 'rendering' }
CgtMatcherRevealElement >> refreshViewportPresentation [
	| viewportHeight |
	viewportContainer ifNil: [ ^ self ].
	viewportHeight := self currentViewportHeightForCurrentPlan.
	self refreshContents.
	self refreshViewportContentLayoutForHeight: viewportHeight.
	viewportContainer
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical exact: viewportHeight ].
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

{ #category : 'accessing' }
CgtMatcherRevealElement >> estimatedContentHeight [
	^ self estimatedHeightForRowElements: rowElements
]

{ #category : 'accessing' }
CgtMatcherRevealElement >> estimatedHeightForRowElements: aCollection [
	| rows verticalInset |
	rows := (aCollection ifNil: [ #() ]) asOrderedCollection.
	rows isEmpty ifTrue: [ ^ self minimumViewportHeight ].
	verticalInset := layoutPolicy revealContentInset top + layoutPolicy revealContentInset bottom.
	^ (rows inject: verticalInset into: [ :sum :each | sum + (self measuredHeightForRowElement: each) ])
		+ ((rows size - 1) * layoutPolicy revealViewportCellSpacing)
]

{ #category : 'accessing' }
CgtMatcherRevealElement >> visibleRowElements [
	^ rowElements first: (rowElements size min: self maximumVisibleRowCount)
]

{ #category : 'accessing' }
CgtMatcherRevealElement >> viewportHeightForVisibleRows [
	| estimated |
	estimated := self estimatedHeightForRowElements: self visibleRowElements.
	^ estimated max: self minimumViewportHeight
]

{ #category : 'testing' }
CgtMatcherRevealElement >> shouldUseScrollForOverflowRows [
	^ rowElements size > self maximumVisibleRowCount
]



{ #category : 'accessing' }
CgtMatcherRevealElement >> viewportStartHeightForCurrentPlan [
	structuralRefreshPlan ifNil: [ ^ self viewportHeightForVisibleRows ].
	structuralRefreshPlan isReveal ifTrue: [ ^ self minimumViewportHeight ].
	structuralRefreshPlan isCollapse ifTrue: [ ^ self viewportHeightForVisibleRows ].
	^ self viewportHeightForVisibleRows
]

{ #category : 'accessing' }
CgtMatcherRevealElement >> viewportEndHeightForCurrentPlan [
	structuralRefreshPlan ifNil: [ ^ self viewportHeightForVisibleRows ].
	structuralRefreshPlan isCollapse ifTrue: [ ^ self minimumViewportHeight ].
	^ self viewportHeightForVisibleRows
]



{ #category : 'accessing' }
CgtMatcherRevealElement >> currentViewportHeightForCurrentPlan [
	^ self currentViewportHeightForPresentationProgress: self viewportPresentationProgress
]


{ #category : 'accessing' }
CgtMatcherRevealElement >> rowElementsForCurrentViewportPresentation [
	(self shouldAnimateViewportHeight and: [ self viewportPresentationProgress < 1.0 ]) ifTrue: [
		^ self visibleRowElementsForCurrentViewportPresentation ].
	^ self visibleRowElements
]

{ #category : 'accessing' }
CgtMatcherRevealElement >> visibleRowElementsForCurrentViewportPresentation [
	^ self visibleRowElementsForViewportHeight: self currentViewportHeightForCurrentPlan
]

{ #category : 'accessing' }
CgtMatcherRevealElement >> visibleRowElementsForViewportHeight: aNumber [
	| visibleRows accumulatedHeight spacing |
	visibleRows := OrderedCollection new.
	accumulatedHeight := layoutPolicy revealContentInset top + layoutPolicy revealContentInset bottom.
	spacing := layoutPolicy revealViewportCellSpacing.
	self visibleRowElements do: [ :each |
		| rowHeight additionalHeight |
		rowHeight := self measuredHeightForRowElement: each.
		additionalHeight := rowHeight + (visibleRows isEmpty ifTrue: [ 0 ] ifFalse: [ spacing ]).
		(accumulatedHeight + additionalHeight) <= aNumber ifFalse: [ ^ visibleRows ].
		visibleRows add: each.
		accumulatedHeight := accumulatedHeight + additionalHeight ].
	^ visibleRows
]

{ #category : 'testing' }
CgtMatcherRevealElement >> shouldAnimateViewportHeight [
	^ transitionPolicy shouldAnimateStructuralRefreshPlan: structuralRefreshPlan
]

{ #category : 'testing' }
CgtMatcherRevealElement >> usesCollapsedStartHeightForRevealPlan [
	^ structuralRefreshPlan notNil
		and: [ structuralRefreshPlan isReveal
		and: [ self viewportStartHeightForCurrentPlan = self minimumViewportHeight ] ]
]

{ #category : 'testing' }
CgtMatcherRevealElement >> usesCollapsedEndHeightForCollapsePlan [
	^ structuralRefreshPlan notNil
		and: [ structuralRefreshPlan isCollapse
		and: [ self viewportEndHeightForCurrentPlan = self minimumViewportHeight ] ]
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
CgtMatcherRevealElement >> maximumVisibleRowCount [
	^ layoutPolicy revealMaximumVisibleRowCount
]



{ #category : 'private - layout' }
CgtMatcherRevealElement >> refreshViewportContentLayoutForHeight: aViewportHeight [
	| spacerHeight |
	viewportContentContainer ifNil: [ ^ self ].
	spacerHeight := self spacerHeightForViewportHeight: aViewportHeight.
	viewportSpacerElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: spacerHeight ].
	viewportContentContainer removeChildren.
	self shouldUseLeadingSpacerForFixedEdge
		ifTrue: [
			viewportContentContainer addChild: viewportSpacerElement.
			viewportContentContainer addChild: contentContainer ]
		ifFalse: [
			viewportContentContainer addChild: contentContainer.
			viewportContentContainer addChild: viewportSpacerElement ].
	^ self
]

{ #category : 'private - layout' }
CgtMatcherRevealElement >> spacerHeightForViewportHeight: aViewportHeight [
	| contentHeight |
	contentHeight := self estimatedContentHeight.
	^ (aViewportHeight - contentHeight) max: 0
]

{ #category : 'testing' }
CgtMatcherRevealElement >> shouldUseLeadingSpacerForFixedEdge [
	^ self fixedEdge = #bottom
]

{ #category : 'testing' }
CgtMatcherRevealElement >> shouldUseTrailingSpacerForFixedEdge [
	^ self shouldUseLeadingSpacerForFixedEdge not
]
{ #category : 'accessing' }
CgtMatcherRevealElement >> measuredHeightForRowElement: anElement [
	| measured boundsHeight |
	anElement ifNil: [ ^ layoutPolicy revealEstimatedRowHeight ].
	measured := [ anElement measuredBounds height ] on: Error do: [ 0 ].
	measured > 0 ifTrue: [ ^ measured ].
	boundsHeight := [ anElement bounds height ] on: Error do: [ 0 ].
	boundsHeight > 0 ifTrue: [ ^ boundsHeight ].
	^ layoutPolicy revealEstimatedRowHeight
]

{ #category : 'accessing' }
CgtMatcherRevealElement >> minimumViewportHeight [
	^ layoutPolicy revealViewportMinimumHeight
]
