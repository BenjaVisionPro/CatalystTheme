
"
#Matcher Row Element
I render one visible matcher row for the upcoming custom style-rule selector widget. I am responsible for composing an optional incoming relation control with matcher chips and forwarding row-level hover, selection, and child edit events without owning selector semantics.
"
Class {
	#name : 'CgtMatcherRowElement',
	#superclass : 'BrHorizontalPane',
	#instVars : [
		'projectionNode',
		'incomingRelation',
		'relationElement',
		'chipsContainer',
		'classChipElement',
		'idChipElement',
		'nodeVisualPolicy',
		'layoutPolicy',
		'isSelected',
		'isCurrentRule',
		'isOtherRule',
		'isInScope',
		'isRevealedContext',
		'hoverNestingCount'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtMatcherRowElement >> initialize [
	super initialize.
	layoutPolicy := CgtMatcherLayoutPolicy new.
	nodeVisualPolicy := CgtMatcherNodeVisualPolicy new.
	isSelected := false.
	isCurrentRule := false.
	isOtherRule := false.
	isInScope := false.
	isRevealedContext := false.
	hoverNestingCount := 0.
	self
		vFitContent;
		hFitContent;
		alignCenterLeft;
		cellSpacing: layoutPolicy rowCellSpacing;
		padding: (BlInsets all: 0);
		background: Color transparent;
		border: BlBorder empty;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ].
	chipsContainer := BrVerticalPane new
		vFitContent;
		hFitContent;
		cellSpacing: layoutPolicy nodeCellSpacing;
		padding: layoutPolicy nodePadding;
		geometry: (BlRoundedRectangleGeometry cornerRadius: layoutPolicy rowCornerRadius);
		yourself.
	self when: BlClickEvent do: [ :anEvent | self onMouseSelect: anEvent ].
	self when: BlElementHoveredEvent do: [ :anEvent | self onMouseEnter: anEvent ].
	self when: BlElementUnhoveredEvent do: [ :anEvent | self onMouseLeave: anEvent ].
	self refreshContents
]

{ #category : 'accessing' }
CgtMatcherRowElement >> projectionNode [
	^ projectionNode
]

{ #category : 'accessing' }
CgtMatcherRowElement >> projectionNode: aCgtMatcherProjectionNode [
	projectionNode := aCgtMatcherProjectionNode.
	hoverNestingCount := 0.
	self refreshContents.
	^ self
]

{ #category : 'accessing' }
CgtMatcherRowElement >> incomingRelation [
	^ incomingRelation
]

{ #category : 'accessing' }
CgtMatcherRowElement >> incomingRelation: aCgtMatcherProjectionRelation [
	incomingRelation := aCgtMatcherProjectionRelation.
	self refreshContents.
	^ self
]

{ #category : 'accessing' }
CgtMatcherRowElement >> nodeVisualPolicy [
	^ nodeVisualPolicy
]

{ #category : 'accessing' }
CgtMatcherRowElement >> nodeVisualPolicy: aCgtMatcherNodeVisualPolicy [
	nodeVisualPolicy := aCgtMatcherNodeVisualPolicy.
	self refreshContents.
	^ self
]

{ #category : 'accessing' }
CgtMatcherRowElement >> selected: aBoolean [
	isSelected := aBoolean.
	self refreshContents.
	^ self
]

{ #category : 'accessing' }
CgtMatcherRowElement >> currentRule: aBoolean [
	isCurrentRule := aBoolean.
	self refreshContents.
	^ self
]

{ #category : 'accessing' }
CgtMatcherRowElement >> otherRule: aBoolean [
	isOtherRule := aBoolean.
	self refreshContents.
	^ self
]


{ #category : 'accessing' }
CgtMatcherRowElement >> inScope: aBoolean [
	isInScope := aBoolean.
	self refreshContents.
	^ self
]

{ #category : 'accessing' }
CgtMatcherRowElement >> revealedContext: aBoolean [
	isRevealedContext := aBoolean.
	self refreshContents.
	^ self
]

{ #category : 'testing' }
CgtMatcherRowElement >> isInScope [
	^ isInScope
]

{ #category : 'testing' }
CgtMatcherRowElement >> isRevealedContext [
	^ isRevealedContext
]

{ #category : 'accessing' }
CgtMatcherRowElement >> relationElement [
	^ relationElement
]

{ #category : 'accessing' }
CgtMatcherRowElement >> classChipElement [
	^ classChipElement
]

{ #category : 'accessing' }
CgtMatcherRowElement >> idChipElement [
	^ idChipElement
]

{ #category : 'rendering' }
CgtMatcherRowElement >> refreshContents [
	self removeChildren.
	relationElement := nil.
	classChipElement := nil.
	idChipElement := nil.
	chipsContainer removeChildren.
	projectionNode ifNil: [ ^ self ].
	self updateVisualState.
	self buildRelationElementIfNeeded.
	self buildMatcherChips.
	relationElement ifNotNil: [ self addChild: relationElement ].
	self addChild: chipsContainer.
	^ self
]

{ #category : 'rendering' }
CgtMatcherRowElement >> buildRelationElementIfNeeded [
	isInScope ifFalse: [ ^ self ].
	relationElement := CgtMatcherRelationElement new
		projectionRelation: incomingRelation;
		yourself.
	relationElement when: CgtMatcherCombinatorChangedEvent do: [ :anEvent |
		self fireEvent: (CgtMatcherCombinatorChangedEvent new
			relation: anEvent relation;
			combinator: anEvent combinator;
			yourself) ]
]

{ #category : 'rendering' }
CgtMatcherRowElement >> buildMatcherChips [
	self buildClassChipIfNeeded.
	self buildIdChipIfNeeded.
]

{ #category : 'rendering' }
CgtMatcherRowElement >> buildClassChipIfNeeded [
	projectionNode className ifNil: [ ^ self ].
	classChipElement := CgtMatcherChipElement new
		chipKind: #class;
		projectionNode: projectionNode;
		matcherLabel: projectionNode className;
		enabled: projectionNode matchByClass;
		nodeVisualPolicy: nodeVisualPolicy;
		yourself.
	classChipElement when: CgtMatcherClassMatchToggledEvent do: [ :anEvent |
		self fireEvent: (CgtMatcherClassMatchToggledEvent new
			projectionNode: anEvent projectionNode;
			shouldMatch: anEvent shouldMatch;
			yourself) ].
	chipsContainer addChild: classChipElement
]

{ #category : 'rendering' }
CgtMatcherRowElement >> buildIdChipIfNeeded [
	self hasDisplayableElementId ifFalse: [ ^ self ].
	idChipElement := CgtMatcherChipElement new
		chipKind: #elementId;
		projectionNode: projectionNode;
		matcherLabel: self displayableElementIdLabel;
		enabled: projectionNode matchById;
		nodeVisualPolicy: nodeVisualPolicy;
		yourself.
	idChipElement when: CgtMatcherIdMatchToggledEvent do: [ :anEvent |
		self fireEvent: (CgtMatcherIdMatchToggledEvent new
			projectionNode: anEvent projectionNode;
			shouldMatch: anEvent shouldMatch;
			yourself) ].
	chipsContainer addChild: idChipElement
]

{ #category : 'rendering' }
CgtMatcherRowElement >> updateVisualState [
	self
		background: Color transparent;
		border: BlBorder empty;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ].
	chipsContainer
		background: (nodeVisualPolicy
			rowBackgroundForNode: projectionNode
			selected: isSelected
			inScope: isInScope
			revealedContext: isRevealedContext
			otherRule: isOtherRule);
		border: (nodeVisualPolicy
			rowBorderForNode: projectionNode
			selected: isSelected
			inScope: isInScope
			revealedContext: isRevealedContext
			otherRule: isOtherRule)
]

{ #category : 'rendering' }
CgtMatcherRowElement >> widthForCurrentState [
	isSelected ifTrue: [ ^ layoutPolicy selectedNodeWidth ].
	isInScope ifTrue: [ ^ layoutPolicy scopeNodeWidth ].
	isOtherRule ifTrue: [ ^ layoutPolicy scopeNodeWidth ].
	isRevealedContext ifTrue: [ ^ layoutPolicy contextNodeWidth ].
	^ layoutPolicy contextNodeWidth
]

{ #category : 'event handling' }
CgtMatcherRowElement >> onMouseEnter: anEvent [
	projectionNode ifNil: [ ^ self ].
	hoverNestingCount := hoverNestingCount + 1.
	hoverNestingCount = 1 ifFalse: [ ^ self ].
	self fireEvent: (CgtMatcherNodeHoveredEvent new
		projectionNode: projectionNode;
		yourself)
]

{ #category : 'event handling' }
CgtMatcherRowElement >> onMouseLeave: anEvent [
	projectionNode ifNil: [ ^ self ].
	hoverNestingCount := (hoverNestingCount - 1) max: 0.
	hoverNestingCount = 0 ifFalse: [ ^ self ].
	self fireEvent: (CgtMatcherNodeUnhoveredEvent new
		projectionNode: projectionNode;
		yourself)
]

{ #category : 'event handling' }
CgtMatcherRowElement >> onMouseSelect: anEvent [
	projectionNode ifNil: [ ^ self ].
	anEvent ifNotNil: [ anEvent consumed: true ].
	self fireEvent: (CgtMatcherNodeSelectedEvent new
		projectionNode: projectionNode;
		yourself)
]

{ #category : 'testing' }
CgtMatcherRowElement >> hasRelationElement [
	^ relationElement notNil
]

{ #category : 'testing' }
CgtMatcherRowElement >> hasClassMatcher [
	^ classChipElement notNil
]

{ #category : 'rendering' }
CgtMatcherRowElement >> displayableElementIdLabel [
	| rawLabel |
	rawLabel := projectionNode elementId asString.
	(rawLabel beginsWith: '#') ifTrue: [ ^ rawLabel allButFirst ].
	((rawLabel beginsWith: '''') and: [ (rawLabel endsWith: '''') and: [ rawLabel size >= 2 ] ])
		ifTrue: [ ^ rawLabel copyFrom: 2 to: rawLabel size - 1 ].
	^ rawLabel
]

{ #category : 'testing' }
CgtMatcherRowElement >> hasDisplayableElementId [
	| rawLabel normalized |
	projectionNode ifNil: [ ^ false ].
	projectionNode elementId ifNil: [ ^ false ].
	rawLabel := projectionNode elementId asString.
	normalized := rawLabel withBlanksCondensed.
	normalized isEmpty ifTrue: [ ^ false ].
	^ normalized asLowercase ~= 'nil'
]

{ #category : 'testing' }
CgtMatcherRowElement >> hasIdMatcher [
	^ idChipElement notNil
]
