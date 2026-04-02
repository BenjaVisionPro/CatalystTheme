
"
#Matcher Relation Element
I render the incoming matcher relation for a visible selector row. I am responsible for presenting the requested parent relation and emitting explicit combinator-change events without owning selector semantics.
"
Class {
	#name : 'CgtMatcherRelationElement',
	#superclass : 'BrButton',
	#instVars : [
		'projectionRelation',
		'relationVisualPolicy',
		'currentCombinator'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtMatcherRelationElement >> initialize [
	super initialize.
	relationVisualPolicy := CgtMatcherRelationVisualPolicy new.
	currentCombinator := #child.
	self
		action: [ :aButton | self toggleCombinator ];
		beSmallSize;
		constraintsDo: [ :c |
			c horizontal exact: CgtMatcherLayoutPolicy new relationControlDiameter.
			c vertical exact: CgtMatcherLayoutPolicy new relationControlDiameter ].
	self refreshContents
]

{ #category : 'accessing' }
CgtMatcherRelationElement >> projectionRelation [
	^ projectionRelation
]

{ #category : 'accessing' }
CgtMatcherRelationElement >> projectionRelation: aCgtMatcherProjectionRelation [
	projectionRelation := aCgtMatcherProjectionRelation.
	currentCombinator := aCgtMatcherProjectionRelation
		ifNil: [ #child ]
		ifNotNil: [ aCgtMatcherProjectionRelation combinator ifNil: [ #child ] ].
	self refreshContents.
	^ self
]

{ #category : 'accessing' }
CgtMatcherRelationElement >> relationVisualPolicy [
	^ relationVisualPolicy
]

{ #category : 'accessing' }
CgtMatcherRelationElement >> relationVisualPolicy: aCgtMatcherRelationVisualPolicy [
	relationVisualPolicy := aCgtMatcherRelationVisualPolicy.
	self refreshContents.
	^ self
]

{ #category : 'accessing' }
CgtMatcherRelationElement >> combinator [
	^ currentCombinator
]

{ #category : 'accessing' }
CgtMatcherRelationElement >> combinator: aSymbol [
	currentCombinator := aSymbol.
	self refreshContents.
	^ self
]

{ #category : 'rendering' }
CgtMatcherRelationElement >> refreshContents [
	self
		label: self compactDisplayLabel;
		aptitude: (BrGlamorousButtonLabelAptitude new) + (BrGlamorousButtonRectangularAptitude new cornerRadius: 12);
		background: (Color transparent);
		border: (BlBorder paint: (Color gray alpha: 0.35) width: 1).
	^ self
]


{ #category : 'rendering' }
CgtMatcherRelationElement >> compactDisplayLabel [
	^ self isDirectChild
		ifTrue: [ '•' ]
		ifFalse: [ '◌' ]
]

{ #category : 'rendering' }
CgtMatcherRelationElement >> displayLabel [
	^ self isDirectChild
		ifTrue: [ relationVisualPolicy labelForDirectChild ]
		ifFalse: [ relationVisualPolicy labelForAnyDepth ]
]

{ #category : 'events' }
CgtMatcherRelationElement >> toggleCombinator [
	^ self isDirectChild
		ifTrue: [ self chooseAnyDepth ]
		ifFalse: [ self chooseDirectChild ]
]

{ #category : 'events' }
CgtMatcherRelationElement >> chooseDirectChild [
	^ self announceCombinatorChangedTo: #child
]

{ #category : 'events' }
CgtMatcherRelationElement >> chooseAnyDepth [
	^ self announceCombinatorChangedTo: #descendant
]

{ #category : 'events' }
CgtMatcherRelationElement >> announceCombinatorChangedTo: aSymbol [
	projectionRelation ifNil: [ ^ self ].
	currentCombinator := aSymbol.
	self refreshContents.
	self fireEvent: (CgtMatcherCombinatorChangedEvent new
		relation: projectionRelation;
		combinator: aSymbol;
		yourself)
]

{ #category : 'testing' }
CgtMatcherRelationElement >> isDirectChild [
	^ currentCombinator ~= #descendant
]

{ #category : 'testing' }
CgtMatcherRelationElement >> isAnyDepth [
	^ currentCombinator = #descendant
]
