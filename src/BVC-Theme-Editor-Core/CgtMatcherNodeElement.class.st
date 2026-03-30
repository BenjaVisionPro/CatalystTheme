"
#Matcher Node Element
I render one matcher projection node as a Bloc widget. I am responsible for presenting passive node data for the Mondrian matcher view and emitting explicit widget events for matcher edits without deciding editor semantics.
"
Class {
	#name : 'CgtMatcherNodeElement',
	#superclass : 'BrVerticalPane',
	#instVars : [
		'projectionNode',
		'incomingRelation',
		'visualPolicy'
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
			c horizontal exact: 220.
			c vertical fitContent ].
	visualPolicy := CgtMatcherNodeVisualPolicy new.
	self when: BlClickEvent do: [ :anEvent | self onNodeClicked: anEvent ].
	self when: BlElementHoveredEvent do: [ :anEvent | self onNodeHovered: anEvent ].
	self when: BlElementUnhoveredEvent do: [ :anEvent | self onNodeUnhovered: anEvent ]
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


{ #category : 'accessing' }
CgtMatcherNodeElement >> visualPolicy [
	^ visualPolicy
]

{ #category : 'accessing' }
CgtMatcherNodeElement >> visualPolicy: aCgtMatcherNodeVisualPolicy [
	visualPolicy := aCgtMatcherNodeVisualPolicy.
	self refreshContents.
	^ self
]

{ #category : 'event handling' }
CgtMatcherNodeElement >> onNodeHovered: anEvent [
	projectionNode ifNil: [ ^ self ].
	self fireEvent: (CgtMatcherNodeHoveredEvent new
		projectionNode: projectionNode;
		yourself)
]

{ #category : 'event handling' }
CgtMatcherNodeElement >> onNodeUnhovered: anEvent [
	projectionNode ifNil: [ ^ self ].
	self fireEvent: (CgtMatcherNodeUnhoveredEvent new
		projectionNode: projectionNode;
		yourself)
]


{ #category : 'rendering' }
CgtMatcherNodeElement >> refreshContents [
	self removeChildren.
	projectionNode ifNil: [ ^ self ].
	self
		background: (self backgroundForNode: projectionNode);
		border: (self borderForNode: projectionNode).
	self addChild: (self newTitleLabelFor: projectionNode).
	self addChild: (self newElementIdLabelFor: projectionNode).
	self addChild: (self newMatchSummaryLabelFor: projectionNode).
	(self shouldShowIncomingCombinatorControlsFor: projectionNode)
		ifTrue: [ self addChild: (self newIncomingCombinatorRowFor: projectionNode) ].
	self addChild: (self newMatchToggleRowFor: projectionNode).
	(self shouldShowCompactedSectionActionsFor: projectionNode)
		ifTrue: [ self addChild: (self newCompactedSectionActionRowFor: projectionNode) ].
	self addChild: (self newNodeStateRowFor: projectionNode)
]

{ #category : 'rendering' }
CgtMatcherNodeElement >> backgroundForNode: aProjectionNode [
	^ visualPolicy backgroundForNode: aProjectionNode
]

{ #category : 'rendering' }
CgtMatcherNodeElement >> borderForNode: aProjectionNode [
	^ visualPolicy borderForNode: aProjectionNode
]



{ #category : 'rendering' }
CgtMatcherNodeElement >> wireNodeHoverForwardingOn: anElement [
	anElement when: BlElementHoveredEvent do: [ :anEvent | self onNodeHovered: anEvent ].
	anElement when: BlElementUnhoveredEvent do: [ :anEvent | self onNodeUnhovered: anEvent ].
	^ anElement
]

{ #category : 'rendering' }
CgtMatcherNodeElement >> newTitleLabelFor: aProjectionNode [
	^ self wireNodeHoverForwardingOn: (BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		text: (visualPolicy titleForNode: aProjectionNode))
]

{ #category : 'rendering' }
CgtMatcherNodeElement >> newElementIdLabelFor: aProjectionNode [
	^ self wireNodeHoverForwardingOn: (BrLabel new
		aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
		text: (visualPolicy elementIdTextForNode: aProjectionNode))
]

{ #category : 'rendering' }
CgtMatcherNodeElement >> newMatchSummaryLabelFor: aProjectionNode [
	^ self wireNodeHoverForwardingOn: (BrLabel new
		beSmallSize;
		aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
		text: (visualPolicy matchSummaryForNode: aProjectionNode))
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
	| row badges |
	row := BrHorizontalPane new
		vFitContent;
		hFitContent;
		cellSpacing: 4.
	badges := OrderedCollection new.
	badges add: (self newBadgeLabeled: (visualPolicy roleLabelForNode: aProjectionNode) active: true).
	aProjectionNode isInCurrentRule ifTrue: [ badges add: (self newBadgeLabeled: 'Current rule' active: true) ].
	aProjectionNode isInOtherRule ifTrue: [ badges add: (self newBadgeLabeled: 'Other rule' active: true) ].
	aProjectionNode isEditable ifFalse: [ badges add: (self newBadgeLabeled: 'Read only' active: false) ].
	row addChildren: badges asArray.
	^ row
]





{ #category : 'rendering' }
CgtMatcherNodeElement >> shouldShowCompactedSectionActionsFor: aProjectionNode [
	^ aProjectionNode isCompactedSection
]

{ #category : 'rendering' }
CgtMatcherNodeElement >> newCompactedSectionActionRowFor: aProjectionNode [
	| row |
	row := BrHorizontalPane new
		vFitContent;
		hFitContent;
		cellSpacing: 4.
	row addChildren: {
		(self newBadgeLabeled: 'Context' active: true).
		(self
			newToggleButtonLabeled: 'Reveal'
			active: false
			enabled: true
			action: [ self requestCompactedSectionExpansionFor: aProjectionNode ]) }.
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
	^ self wireNodeHoverForwardingOn: button
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
	^ self wireNodeHoverForwardingOn: (BrLabel new
		beSmallSize;
		padding: (BlInsets top: 2 right: 5 bottom: 2 left: 5);
		background: (aBoolean
			ifTrue: [ Color black alpha: 0.08 ]
			ifFalse: [ Color gray alpha: 0.06 ]);
		aptitude: (BrGlamorousLabelAptitude new
			foreground: (aBoolean ifTrue: [ Color black ] ifFalse: [ Color darkGray ]));
		text: aString)
]

{ #category : 'events' }
CgtMatcherNodeElement >> onNodeClicked: aClickEvent [
	projectionNode ifNil: [ ^ self ].
	self fireEvent: (CgtMatcherNodeSelectedEvent new
		projectionNode: projectionNode;
		yourself).
]





{ #category : 'events' }
CgtMatcherNodeElement >> requestCompactedSectionExpansionFor: aProjectionNode [
	self fireEvent: (CgtMatcherCompactedSectionExpandedEvent new
		projectionNode: aProjectionNode;
		yourself)
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
