
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
		aptitude: BrGlamorousButtonLabelAptitude + (BrGlamorousButtonRectangularAptitude paddingScale: 0.1; cornerRadius: 10);
		action: [ :aButton | self toggleCombinator ];
		beSmallSize.
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
		label: '';
		background: (self isDirectChild
			ifTrue: [ Color transparent ]
			ifFalse: [ Color black alpha: 0.05 ]);
		border: (BlBorder
			paint: (Color gray alpha: (self isDirectChild ifTrue: [ 0.38 ] ifFalse: [ 0.5 ]))
			width: 1);
		constraintsDo: [ :c |
			c horizontal exact: 18.
			c vertical exact: 18 ];
		aptitude: BrGlamorousButtonLabelAptitude + (BrGlamorousButtonRectangularAptitude paddingScale: 0.1; cornerRadius: 9).
	^ self
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
