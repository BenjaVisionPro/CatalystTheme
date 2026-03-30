"
#Matcher Node Element
I render one matcher projection node as a Bloc widget. I am responsible for presenting passive node data for the Mondrian matcher view and emitting explicit widget events for matcher edits without deciding editor semantics.
"
Class {
	#name : 'CgtMatcherNodeElement',
	#superclass : 'BrVerticalPane',
	#instVars : [
		'projectionNode',
		'incomingRelation'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtMatcherNodeElement >> initialize [
	super initialize.
	self
		vFitContent;
		hFitContent;
		padding: (BlInsets all: 8);
		background: (Color white alpha: 0.95);
		border: (BlBorder paint: (Color gray alpha: 0.3));
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ].
	self when: BlClickEvent do: [ :anEvent | self onNodeClicked: anEvent ]
]

{ #category : 'accessing' }
CgtMatcherNodeElement >> projectionNode [
	^ projectionNode
]

{ #category : 'accessing' }
CgtMatcherNodeElement >> projectionNode: aCgtMatcherProjectionNode [
	projectionNode := aCgtMatcherProjectionNode.
	self refreshContents.
	^ self
]


{ #category : 'accessing' }
CgtMatcherNodeElement >> incomingRelation [
	^ incomingRelation
]

{ #category : 'accessing' }
CgtMatcherNodeElement >> incomingRelation: aCgtMatcherProjectionRelation [
	incomingRelation := aCgtMatcherProjectionRelation.
	self refreshContents.
	^ self
]

{ #category : 'rendering' }
CgtMatcherNodeElement >> refreshContents [
	self removeChildren.
	projectionNode ifNil: [ ^ self ].
	self background: (self backgroundForNode: projectionNode).
	self addChild: (self newTitleLabelFor: projectionNode).
	self addChild: (self newElementIdLabelFor: projectionNode).
	(self shouldShowIncomingCombinatorControlsFor: projectionNode)
		ifTrue: [ self addChild: (self newIncomingCombinatorRowFor: projectionNode) ].
	self addChild: (self newMatchToggleRowFor: projectionNode).
	self addChild: (self newNodeStateRowFor: projectionNode)
]

{ #category : 'rendering' }
CgtMatcherNodeElement >> backgroundForNode: aProjectionNode [
	aProjectionNode kind = #selectedElement ifTrue: [ ^ Color veryVeryLightGray ].
	aProjectionNode kind = #compactedSection ifTrue: [ ^ (Color gray alpha: 0.12) ].
	aProjectionNode isInOtherRule ifTrue: [ ^ (Color orange alpha: 0.12) ].
	^ (Color white alpha: 0.95)
]

{ #category : 'rendering' }
CgtMatcherNodeElement >> newTitleLabelFor: aProjectionNode [
	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		text: (aProjectionNode kind = #compactedSection
			ifTrue: [ self compactedTitleFor: aProjectionNode ]
			ifFalse: [ aProjectionNode className ifNil: [ 'Unspecified element' ] ])
]

{ #category : 'rendering' }
CgtMatcherNodeElement >> compactedTitleFor: aProjectionNode [
	^ aProjectionNode hiddenNodeCount asString , ' hidden node' , (aProjectionNode hiddenNodeCount = 1 ifTrue: [ '' ] ifFalse: [ 's' ])
]

{ #category : 'rendering' }
CgtMatcherNodeElement >> newElementIdLabelFor: aProjectionNode [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
		text: (aProjectionNode kind = #compactedSection
			ifTrue: [ 'Compacted section' ]
			ifFalse: [ self elementIdTextFor: aProjectionNode ])
]

{ #category : 'rendering' }
CgtMatcherNodeElement >> elementIdTextFor: aProjectionNode [
	^ aProjectionNode elementId
		ifNil: [ 'No element id' ]
		ifNotNil: [ '#' , aProjectionNode elementId asString ]
]

{ #category : 'rendering' }
CgtMatcherNodeElement >> newMatchToggleRowFor: aProjectionNode [
	| row |
	row := BrHorizontalPane new
		vFitContent;
		hFitContent;
		cellSpacing: 4.
	row addChildren: {
		(self newClassToggleButtonFor: aProjectionNode).
		(self newIdToggleButtonFor: aProjectionNode) }.
	^ row
]

{ #category : 'rendering' }
CgtMatcherNodeElement >> newNodeStateRowFor: aProjectionNode [
	| row |
	row := BrHorizontalPane new
		vFitContent;
		hFitContent;
		cellSpacing: 4.
	row addChildren: {
		(self newBadgeLabeled: aProjectionNode kind asString active: aProjectionNode isInCurrentRule).
		(self newBadgeLabeled: 'Other rule' active: aProjectionNode isInOtherRule) }.
	^ row
]



{ #category : 'rendering' }
CgtMatcherNodeElement >> shouldShowIncomingCombinatorControlsFor: aProjectionNode [
	^ incomingRelation notNil
		and: [ incomingRelation kind = #matcher
		and: [ aProjectionNode isEditable
		and: [ aProjectionNode kind ~= #compactedSection ] ] ]
]

{ #category : 'rendering' }
CgtMatcherNodeElement >> newIncomingCombinatorRowFor: aProjectionNode [
	| row |
	row := BrHorizontalPane new
		vFitContent;
		hFitContent;
		cellSpacing: 4.
	row addChildren: {
		(self newBadgeLabeled: 'Relation' active: true).
		(self newCombinatorToggleButtonLabeled: 'Child' active: incomingRelation combinator ~= #descendant combinator: #child).
		(self newCombinatorToggleButtonLabeled: 'Desc' active: incomingRelation combinator = #descendant combinator: #descendant) }.
	^ row
]

{ #category : 'rendering' }
CgtMatcherNodeElement >> newCombinatorToggleButtonLabeled: aString active: aBoolean combinator: aSymbol [
	^ self
		newToggleButtonLabeled: aString
		active: aBoolean
		enabled: true
		action: [ self requestCombinatorChange: aSymbol ]
]

{ #category : 'rendering' }
CgtMatcherNodeElement >> newClassToggleButtonFor: aProjectionNode [
	^ self
		newToggleButtonLabeled: 'Class'
		active: aProjectionNode matchByClass
		enabled: (aProjectionNode isEditable and: [ aProjectionNode kind ~= #compactedSection ])
		action: [ self requestClassMatchToggleFor: aProjectionNode ]
]

{ #category : 'rendering' }
CgtMatcherNodeElement >> newIdToggleButtonFor: aProjectionNode [
	^ self
		newToggleButtonLabeled: 'Id'
		active: aProjectionNode matchById
		enabled: (aProjectionNode isEditable and: [ aProjectionNode kind ~= #compactedSection ])
		action: [ self requestIdMatchToggleFor: aProjectionNode ]
]

{ #category : 'rendering' }
CgtMatcherNodeElement >> newToggleButtonLabeled: aString active: aBoolean enabled: isEnabled action: anActionBlock [
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
CgtMatcherNodeElement >> toggleButtonAptitudeActive: aBoolean enabled: isEnabled [
	| base activeBackground inactiveBackground |
	base := (BrGlamorousButtonLabelAptitude new
			hoveredColor: Color black;
			pressedColor: Color black) +
		(BrGlamorousButtonRectangularAptitude
			paddingScale: 0.55
			heightScale: 0.8
			cornerRadius: 5).
	activeBackground := aBoolean ifTrue: [ Color black alpha: 0.08 ] ifFalse: [ Color gray alpha: 0.06 ].
	inactiveBackground := isEnabled
		ifTrue: [ activeBackground ]
		ifFalse: [ Color gray alpha: 0.03 ].
	^ base + (BrStyleCommonAptitude new
		default: [ :s | s background: inactiveBackground ];
		hovered: [ :s | isEnabled ifTrue: [ s background: (inactiveBackground alpha: ((inactiveBackground alpha + 0.08) min: 1.0)) ] ];
		pressed: [ :s | isEnabled ifTrue: [ s background: (inactiveBackground alpha: ((inactiveBackground alpha + 0.16) min: 1.0)) ] ])
]

{ #category : 'rendering' }
CgtMatcherNodeElement >> newBadgeLabeled: aString active: aBoolean [
	^ BrLabel new
		beSmallSize;
		padding: (BlInsets top: 2 right: 5 bottom: 2 left: 5);
		background: (aBoolean
			ifTrue: [ Color black alpha: 0.08 ]
			ifFalse: [ Color gray alpha: 0.06 ]);
		aptitude: (BrGlamorousLabelAptitude new
			foreground: (aBoolean ifTrue: [ Color black ] ifFalse: [ Color darkGray ]));
		text: aString
]

{ #category : 'events' }
CgtMatcherNodeElement >> onNodeClicked: aClickEvent [
	projectionNode ifNil: [ ^ self ].
	self fireEvent: (CgtMatcherNodeSelectedEvent new
		projectionNode: projectionNode;
		yourself).
]



{ #category : 'events' }
CgtMatcherNodeElement >> requestCombinatorChange: aSymbol [
	incomingRelation ifNil: [ ^ self ].
	self fireEvent: (CgtMatcherCombinatorChangedEvent new
		relation: incomingRelation;
		combinator: aSymbol;
		yourself)
]

{ #category : 'events' }
CgtMatcherNodeElement >> requestClassMatchToggleFor: aProjectionNode [
	self fireEvent: (CgtMatcherClassMatchToggledEvent new
		projectionNode: aProjectionNode;
		shouldMatch: aProjectionNode matchByClass not;
		yourself)
]

{ #category : 'events' }
CgtMatcherNodeElement >> requestIdMatchToggleFor: aProjectionNode [
	self fireEvent: (CgtMatcherIdMatchToggledEvent new
		projectionNode: aProjectionNode;
		shouldMatch: aProjectionNode matchById not;
		yourself)
]
