"
#Matcher Reveal Element
I render one grouped revealed-context section for the custom selector widget. I am responsible for hosting the revealed rows for one expanded gap in the normal layout flow while keeping reveal presentation concerns in the UI layer.
"
Class {
	#name : 'CgtMatcherRevealElement',
	#superclass : 'BrVerticalPane',
	#instVars : [
		'direction',
		'layoutPolicy'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtMatcherRevealElement >> initialize [
	super initialize.
	layoutPolicy := CgtMatcherLayoutPolicy new.
	self
		vFitContent;
		hFitContent;
		cellSpacing: layoutPolicy widgetCellSpacing;
		background: Color transparent;
		border: BlBorder empty;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ]
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
