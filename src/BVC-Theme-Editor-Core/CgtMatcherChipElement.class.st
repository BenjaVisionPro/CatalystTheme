
"
#Matcher Chip Element
I render one matcher chip for either the class or the element id of a matcher projection node. I am responsible for presenting the matcher label with enabled or disabled styling and emitting explicit matcher toggle events without owning selector semantics.
"
Class {
	#name : 'CgtMatcherChipElement',
	#superclass : 'BrFrame',
	#instVars : [
		'chipKind',
		'matcherLabel',
		'isEnabled',
		'projectionNode',
		'nodeVisualPolicy',
		'layoutPolicy',
		'labelElement'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtMatcherChipElement >> initialize [
	super initialize.
	layoutPolicy := CgtMatcherLayoutPolicy new.
	nodeVisualPolicy := CgtMatcherNodeVisualPolicy new.
	chipKind := #class.
	matcherLabel := ''.
	isEnabled := false.
	self
		vFitContent;
		hFitContent;
		padding: (BlInsets
			top: layoutPolicy chipVerticalPadding
			right: layoutPolicy chipHorizontalPadding
			bottom: layoutPolicy chipVerticalPadding
			left: layoutPolicy chipHorizontalPadding);
		background: Color transparent;
		border: BlBorder empty;
		constraintsDo: [ :c |
			c horizontal exact: self desiredChipWidth.
			c vertical fitContent ].
	labelElement := BrLabel new
		aptitude: BrGlamorousLabelAptitude new.
	self addChild: labelElement.
	self when: BlClickEvent do: [ :anEvent | self onChipClicked: anEvent ].
	self refreshContents
]

{ #category : 'accessing' }
CgtMatcherChipElement >> chipKind [
	^ chipKind
]

{ #category : 'accessing' }
CgtMatcherChipElement >> chipKind: aSymbol [
	((aSymbol = #class) or: [ aSymbol = #elementId ]) ifFalse: [
		self error: 'Matcher chips support only #class or #elementId kinds' ].
	chipKind := aSymbol.
	self refreshContents.
	^ self
]

{ #category : 'accessing' }
CgtMatcherChipElement >> matcherLabel [
	^ matcherLabel
]

{ #category : 'accessing' }
CgtMatcherChipElement >> matcherLabel: aString [
	matcherLabel := aString ifNil: [ '' ] ifNotNil: [ aString asString ].
	self refreshContents.
	^ self
]

{ #category : 'accessing' }
CgtMatcherChipElement >> enabled [
	^ isEnabled
]

{ #category : 'accessing' }
CgtMatcherChipElement >> enabled: aBoolean [
	isEnabled := aBoolean.
	self refreshContents.
	^ self
]

{ #category : 'accessing' }
CgtMatcherChipElement >> projectionNode [
	^ projectionNode
]

{ #category : 'accessing' }
CgtMatcherChipElement >> projectionNode: aCgtMatcherProjectionNode [
	projectionNode := aCgtMatcherProjectionNode.
	^ self
]

{ #category : 'accessing' }
CgtMatcherChipElement >> nodeVisualPolicy [
	^ nodeVisualPolicy
]

{ #category : 'accessing' }
CgtMatcherChipElement >> nodeVisualPolicy: aCgtMatcherNodeVisualPolicy [
	nodeVisualPolicy := aCgtMatcherNodeVisualPolicy.
	self refreshContents.
	^ self
]

{ #category : 'rendering' }
CgtMatcherChipElement >> refreshContents [
	labelElement ifNil: [ ^ self ].
	self applyTypographyToLabel.
	labelElement text: self displayLabel.
	labelElement aptitude: (BrGlamorousLabelAptitude new
		foreground: (nodeVisualPolicy chipForegroundForEnabled: isEnabled)).
	self
		background: (nodeVisualPolicy chipBackgroundForEnabled: isEnabled);
		border: (nodeVisualPolicy chipBorderForEnabled: isEnabled);
		constraintsDo: [ :c |
			c horizontal exact: self desiredChipWidth.
			c vertical fitContent ].
	^ self
]

{ #category : 'rendering' }
CgtMatcherChipElement >> applyTypographyToLabel [
	self isClassChip
		ifTrue: [ labelElement beSmallSize ]
		ifFalse: [ labelElement beLargeSize ]
]

{ #category : 'rendering' }
CgtMatcherChipElement >> desiredChipWidth [
	^ chipKind = #elementId
		ifTrue: [ layoutPolicy idChipWidth ]
		ifFalse: [ layoutPolicy classChipWidth ]
]

{ #category : 'events' }
CgtMatcherChipElement >> onChipClicked: aClickEvent [
	projectionNode ifNil: [ ^ self ].
	aClickEvent ifNotNil: [ aClickEvent consumed: true ].
	self toggleEnabled
]

{ #category : 'events' }
CgtMatcherChipElement >> toggleEnabled [
	^ self requestEnabled: isEnabled not
]

{ #category : 'events' }
CgtMatcherChipElement >> requestEnabled: aBoolean [
	projectionNode ifNil: [ ^ self ].
	chipKind = #class ifTrue: [
		^ self fireEvent: (CgtMatcherClassMatchToggledEvent new
			projectionNode: projectionNode;
			shouldMatch: aBoolean;
			yourself) ].
	^ self fireEvent: (CgtMatcherIdMatchToggledEvent new
		projectionNode: projectionNode;
		shouldMatch: aBoolean;
		yourself)
]

{ #category : 'testing' }
CgtMatcherChipElement >> isClassChip [
	^ chipKind = #class
]

{ #category : 'testing' }
CgtMatcherChipElement >> isIdChip [
	^ chipKind = #elementId
]

{ #category : 'rendering' }
CgtMatcherChipElement >> displayLabel [
	^ matcherLabel ifEmpty: [ self defaultLabel ]
]

{ #category : 'rendering' }
CgtMatcherChipElement >> defaultLabel [
	^ self isClassChip
		ifTrue: [ 'Class' ]
		ifFalse: [ 'Element id' ]
]
