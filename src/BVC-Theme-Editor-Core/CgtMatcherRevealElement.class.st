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
	viewportContainer := BrVerticalPane new
		vFitContent;
		hFitContent;
		cellSpacing: 0;
		padding: (BlInsets all: 0);
		background: Color transparent;
		border: BlBorder empty;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		yourself.
	contentContainer := BrVerticalPane new
		vFitContent;
		hFitContent;
		cellSpacing: layoutPolicy widgetCellSpacing;
		background: Color transparent;
		border: BlBorder empty;
		yourself.
	viewportContainer addChild: contentContainer.
	self addChild: viewportContainer
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
	^ self
]

{ #category : 'accessing' }
CgtMatcherRevealElement >> direction [
	^ direction ifNil: [ #upstream ]
]

{ #category : 'accessing' }
CgtMatcherRevealElement >> direction: aSymbol [
	direction := aSymbol ifNil: [ #upstream ].
	^ self
]

{ #category : 'accessing' }
CgtMatcherRevealElement >> rowElements [
	^ rowElements copy
]

{ #category : 'accessing' }
CgtMatcherRevealElement >> rowElements: aCollection [
	rowElements := (aCollection ifNil: [ #() ]) asOrderedCollection.
	self refreshContents.
	^ self
]

{ #category : 'rendering' }
CgtMatcherRevealElement >> refreshContents [
	contentContainer removeChildren.
	rowElements do: [ :each | contentContainer addChild: each ].
	^ self
]
