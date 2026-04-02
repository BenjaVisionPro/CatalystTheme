"
#Matcher Gap Element
I render one compacted matcher gap as a focused between-nodes control. I am responsible for presenting hidden in-between context and path depth controls without pretending they are properties of the following scope node.
"
Class {
	#name : 'CgtMatcherGapElement',
	#superclass : 'BrVerticalPane',
	#instVars : [
		'projectionNode',
		'outgoingRelation',
		'layoutPolicy',
		'direction'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtMatcherGapElement >> initialize [
	super initialize.
	layoutPolicy := CgtMatcherLayoutPolicy new.
	self
		vFitContent;
		hFitContent;
		cellSpacing: 2;
		padding: (BlInsets all: 2);
		background: Color transparent;
		border: BlBorder empty;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ]
]

{ #category : 'accessing' }
CgtMatcherGapElement >> projectionNode [
	^ projectionNode
]

{ #category : 'accessing' }
CgtMatcherGapElement >> projectionNode: aCgtMatcherProjectionNode [
	projectionNode := aCgtMatcherProjectionNode.
	self refreshContents.
	^ self
]

{ #category : 'accessing' }
CgtMatcherGapElement >> outgoingRelation [
	^ outgoingRelation
]


{ #category : 'accessing' }
CgtMatcherGapElement >> direction [
	^ direction ifNil: [ #upstream ]
]

{ #category : 'accessing' }
CgtMatcherGapElement >> direction: aSymbol [
	direction := aSymbol.
	self refreshContents.
	^ self
]


{ #category : 'accessing' }
CgtMatcherGapElement >> outgoingRelation: aCgtMatcherProjectionRelation [
	outgoingRelation := aCgtMatcherProjectionRelation.
	self refreshContents.
	^ self
]

{ #category : 'rendering' }
CgtMatcherGapElement >> refreshContents [
	self removeChildren.
	projectionNode ifNil: [ ^ self ].
	self addChild: self newCompactRevealHandle
]


{ #category : 'rendering' }
CgtMatcherGapElement >> newCompactRevealHandle [
	| wrapper handle label |
	wrapper := BrVerticalPane new
		vFitContent;
		hFitContent;
		cellSpacing: 2;
		padding: (BlInsets top: 1 right: 2 bottom: 1 left: 2);
		yourself.
	handle := BrButton new
		label: '';
		aptitude: (BrGlamorousButtonRectangularAptitude new
			cornerRadius: 8);
		background: (self compactRevealHandleBackground);
		border: (self compactRevealHandleBorder);
		constraintsDo: [ :c |
			c horizontal exact: 30.
			c vertical exact: 10 ];
		action: [ :aButton | self requestCompactedSectionExpansionFor: projectionNode ];
		yourself.
	label := BrLabel new
		beSmallSize;
		aptitude: (BrGlamorousLabelAptitude new foreground: (Color gray alpha: 0.75));
		text: self compactRevealHintText;
		yourself.
	wrapper addChildren: { handle. label }.
	^ wrapper
]

{ #category : 'rendering' }
CgtMatcherGapElement >> compactRevealHandleBackground [
	^ self isUpstreamGap
		ifTrue: [ Color gray alpha: 0.32 ]
		ifFalse: [ Color gray alpha: 0.24 ]
]

{ #category : 'rendering' }
CgtMatcherGapElement >> compactRevealHandleBorder [
	^ BlBorder paint: (self isUpstreamGap
		ifTrue: [ Color black alpha: 0.32 ]
		ifFalse: [ Color gray alpha: 0.34 ]) width: 1
]

{ #category : 'rendering' }
CgtMatcherGapElement >> compactRevealHintText [
	| countText |
	countText := projectionNode hiddenNodeCount asString , ' hidden'.
	^ self isUpstreamGap
		ifTrue: [ countText , ' above' ]
		ifFalse: [ countText , ' below' ]
]

{ #category : 'rendering' }
CgtMatcherGapElement >> newHiddenCountLabel [
	| text |
	text := projectionNode hiddenNodeCount = 1
		ifTrue: [ '1 hidden' ]
		ifFalse: [ projectionNode hiddenNodeCount asString , ' hidden' ].
	^ BrLabel new
		beSmallSize;
		aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
		text: text
]

{ #category : 'rendering' }
CgtMatcherGapElement >> newPathControlRow [
	| row |
	row := BrHorizontalPane new
		vFitContent;
		hFitContent;
		cellSpacing: 4.
	row addChildren: {
		(self newBadgeLabeled: 'Path' active: true).
		(self newCombinatorToggleButtonLabeled: 'Direct' active: self isDirectPath combinator: #child).
		(self newCombinatorToggleButtonLabeled: 'Deep' active: self isDeepPath combinator: #descendant) }.
	^ row
]

{ #category : 'rendering' }
CgtMatcherGapElement >> newRevealRow [
	| row |
	row := BrHorizontalPane new
		vFitContent;
		hFitContent;
		cellSpacing: 4.
	row addChildren: {
		(self newBadgeLabeled: 'Between' active: true).
		(self
			newToggleButtonLabeled: 'Reveal'
			active: false
			enabled: true
			action: [ self requestCompactedSectionExpansionFor: projectionNode ]) }.
	^ row
]

{ #category : 'rendering' }
CgtMatcherGapElement >> newBadgeLabeled: aString active: aBoolean [
	^ BrLabel new
		beSmallSize;
		aptitude: (BrGlamorousLabelAptitude new foreground: (aBoolean ifTrue: [ Color black ] ifFalse: [ Color gray ]));
		text: aString
]

{ #category : 'rendering' }
CgtMatcherGapElement >> newCombinatorToggleButtonLabeled: aString active: aBoolean combinator: aSymbol [
	^ self
		newToggleButtonLabeled: aString
		active: aBoolean
		enabled: outgoingRelation notNil
		action: [ self requestCombinatorChange: aSymbol ]
]

{ #category : 'rendering' }
CgtMatcherGapElement >> newToggleButtonLabeled: aString active: aBoolean enabled: isEnabled action: anActionBlock [
	| button |
	button := BrButton new
		label: aString;
		aptitude: (self toggleButtonAptitudeActive: aBoolean enabled: isEnabled);
		action: [ :aButton | isEnabled ifTrue: [ anActionBlock value ] ];
		yourself.
	isEnabled ifFalse: [ button preventMouseEvents ].
	^ button
]

{ #category : 'rendering' }
CgtMatcherGapElement >> toggleButtonAptitudeActive: aBoolean enabled: isEnabled [
	| base activeBackground inactiveBackground |
	base := (BrGlamorousButtonLabelAptitude new
			hoveredColor: Color black;
			pressedColor: Color black) +
		(BrGlamorousButtonRectangularAptitude
			paddingScale: 0.45;
			cornerRadius: 4).
	activeBackground := Color gray alpha: 0.18.
	inactiveBackground := Color transparent.
	^ base + (BrStyleCommonAptitude new default: [ :aStyle |
		aStyle background: (isEnabled
			ifTrue: [ aBoolean ifTrue: [ activeBackground ] ifFalse: [ inactiveBackground ] ]
			ifFalse: [ Color veryVeryLightGray alpha: 0.4 ]) ])
]


{ #category : 'testing' }
CgtMatcherGapElement >> isUpstreamGap [
	^ self direction ~= #downstream
]

{ #category : 'testing' }
CgtMatcherGapElement >> isDownstreamGap [
	^ self direction = #downstream
]

{ #category : 'testing' }
CgtMatcherGapElement >> isDeepPath [
	^ outgoingRelation notNil and: [ outgoingRelation combinator = #descendant ]
]

{ #category : 'testing' }
CgtMatcherGapElement >> isDirectPath [
	^ outgoingRelation isNil or: [ outgoingRelation combinator ~= #descendant ]
]

{ #category : 'events' }
CgtMatcherGapElement >> requestCombinatorChange: aSymbol [
	outgoingRelation ifNil: [ ^ self ].
	self fireEvent: (CgtMatcherCombinatorChangedEvent new
		relation: outgoingRelation;
		combinator: aSymbol;
		yourself)
]

{ #category : 'events' }
CgtMatcherGapElement >> requestCompactedSectionExpansionFor: aProjectionNode [
	self fireEvent: (CgtMatcherCompactedSectionExpandedEvent new
		projectionNode: aProjectionNode;
		yourself)
]
