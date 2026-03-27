Class {
	#name : 'CgtThemeSelectorWidget',
	#superclass : 'BrHorizontalPane',
	#instVars : [
		'selector',
		'selectedSimpleSelector',
		'onSelectorSelectedBlock'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtThemeSelectorWidget >> initialize [
	super initialize.
	self
		hMatchParent;
		vFitContent;
		cellSpacing: 6;
		alignCenterLeft
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> selector [
	^ selector
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> selector: aCgtThemeSelector [
	selector := aCgtThemeSelector.
	selectedSimpleSelector ifNil: [ selectedSimpleSelector := self firstSimpleSelector ].
	(self allSimpleSelectors includes: selectedSimpleSelector) ifFalse: [ selectedSimpleSelector := self firstSimpleSelector ].
	self rebuild
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> selectedSimpleSelector [
	^ selectedSimpleSelector
]

{ #category : 'actions' }
CgtThemeSelectorWidget >> selectedSimpleSelector: aCgtThemeSimpleSelector [
	selectedSimpleSelector := aCgtThemeSimpleSelector.
	self rebuild.
	onSelectorSelectedBlock ifNotNil: [ onSelectorSelectedBlock value: aCgtThemeSimpleSelector ]
]

{ #category : 'accessing' }
CgtThemeSelectorWidget >> onSelectorSelectedDo: aBlock [
	onSelectorSelectedBlock := aBlock
]

{ #category : 'private' }
CgtThemeSelectorWidget >> rebuild [
	self removeChildren.
	selector ifNil: [ ^ self ].
	self selectorSegments do: [ :each |
		each isSymbol
			ifTrue: [ self addChild: (self newCombinatorLabelFor: each) ]
			ifFalse: [ self addChild: (self newCrumbButtonFor: each) ] ]
]

{ #category : 'private' }
CgtThemeSelectorWidget >> selectorSegments [
	^ self segmentsForSelector: selector
]

{ #category : 'private' }
CgtThemeSelectorWidget >> segmentsForSelector: aCgtThemeSelector [
	| segments |
	aCgtThemeSelector ifNil: [ ^ #() ].
	aCgtThemeSelector isKindOf: CgtThemeCombinatorSelector ifTrue: [
		segments := OrderedCollection new.
		segments addAll: (self segmentsForSelector: aCgtThemeSelector leftSelector).
		segments add: aCgtThemeSelector combinator.
		segments addAll: (self segmentsForSelector: aCgtThemeSelector rightSelector).
		^ segments ].
	^ OrderedCollection with: aCgtThemeSelector
]

{ #category : 'private' }
CgtThemeSelectorWidget >> newCombinatorLabelFor: aSymbol [
	^ BrLabel new
		beSmallSize;
		aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
		text: (aSymbol = #child ifTrue: [ '>' ] ifFalse: [ aSymbol asString ])
]

{ #category : 'private' }
CgtThemeSelectorWidget >> newCrumbButtonFor: aCgtThemeSimpleSelector [
	^ BrButton new
		beTinySize;
		label: aCgtThemeSimpleSelector displayString;
		aptitude: self crumbAptitudeFor: aCgtThemeSimpleSelector;
		action: [ :aButton | self selectedSimpleSelector: aCgtThemeSimpleSelector ]
]

{ #category : 'private' }
CgtThemeSelectorWidget >> crumbAptitudeFor: aCgtThemeSimpleSelector [
	| base selected |
	base := (BrGlamorousButtonLabelAptitude new
			hoveredColor: Color black;
			pressedColor: Color black) +
		(BrGlamorousButtonRectangularAptitude
			paddingScale: 0.8
			heightScale: 0.85
			cornerRadius: 6).
	selected := selectedSimpleSelector == aCgtThemeSimpleSelector.
	^ base + (BrStyleCommonAptitude new
		default: [ :s | s background: (selected ifTrue: [ Color gray alpha: 0.28 ] ifFalse: [ Color gray alpha: 0.12 ]) ];
		hovered: [ :s | s background: (selected ifTrue: [ Color gray alpha: 0.36 ] ifFalse: [ Color gray alpha: 0.2 ]) ];
		pressed: [ :s | s background: (selected ifTrue: [ Color gray alpha: 0.44 ] ifFalse: [ Color gray alpha: 0.3 ]) ])
]

{ #category : 'private' }
CgtThemeSelectorWidget >> allSimpleSelectors [
	^ self selectorSegments reject: [ :each | each isSymbol ]
]

{ #category : 'private' }
CgtThemeSelectorWidget >> firstSimpleSelector [
	^ self allSimpleSelectors ifEmpty: [ nil ] ifNotEmpty: [ :each | each first ]
]
