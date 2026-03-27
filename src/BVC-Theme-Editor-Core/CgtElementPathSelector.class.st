Class {
	#name : 'CgtElementPathSelector',
	#superclass : 'BrBreadcrumb',
	#instVars : [
		'selector',
		'selectedSimpleSelector',
		'onSelectorSelectedBlock'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtElementPathSelector >> initialize [
	super initialize.
	self hFitContent
]

{ #category : 'accessing' }
CgtElementPathSelector >> selector [
	^ selector
]

{ #category : 'accessing' }
CgtElementPathSelector >> selector: aCgtThemeSelector [
	selector := aCgtThemeSelector.
	selectedSimpleSelector ifNil: [ selectedSimpleSelector := self firstSimpleSelector ].
	(self allSimpleSelectors includes: selectedSimpleSelector) ifFalse: [ selectedSimpleSelector := self firstSimpleSelector ].
	self rebuild
]

{ #category : 'accessing' }
CgtElementPathSelector >> selectedSimpleSelector [
	^ selectedSimpleSelector
]

{ #category : 'actions' }
CgtElementPathSelector >> selectedSimpleSelector: aCgtThemeSimpleSelector [
	selectedSimpleSelector := aCgtThemeSimpleSelector.
	self rebuild.
	onSelectorSelectedBlock ifNotNil: [ onSelectorSelectedBlock value: aCgtThemeSimpleSelector ]
]

{ #category : 'accessing' }
CgtElementPathSelector >> onSelectorSelectedDo: aBlock [
	onSelectorSelectedBlock := aBlock
]

{ #category : 'private' }
CgtElementPathSelector >> rebuild [
	self removeAllItems.
	selector ifNil: [ ^ self ].
	self addItems: (self allSimpleSelectors collect: [ :each | self newCrumbButtonFor: each ])
]

{ #category : 'private' }
CgtElementPathSelector >> allSimpleSelectors [
	^ self simpleSelectorsIn: selector into: OrderedCollection new
]

{ #category : 'private' }
CgtElementPathSelector >> simpleSelectorsIn: aCgtThemeSelector into: aCollection [
	aCgtThemeSelector ifNil: [ ^ aCollection ].
	(aCgtThemeSelector isKindOf: CgtThemeCombinatorSelector)
		ifTrue: [
			self simpleSelectorsIn: aCgtThemeSelector leftSelector into: aCollection.
			self simpleSelectorsIn: aCgtThemeSelector rightSelector into: aCollection.
			^ aCollection ].
	aCollection add: aCgtThemeSelector.
	^ aCollection
]

{ #category : 'private' }
CgtElementPathSelector >> firstSimpleSelector [
	^ self allSimpleSelectors ifEmpty: [ nil ] ifNotEmpty: [ :each | each first ]
]

{ #category : 'private' }
CgtElementPathSelector >> newCrumbButtonFor: aCgtThemeSimpleSelector [
	^ BrButton new
		label: aCgtThemeSimpleSelector displayString;
		aptitude: (self crumbAptitudeFor: aCgtThemeSimpleSelector);
		action: [ :aButton | self selectedSimpleSelector: aCgtThemeSimpleSelector ]
]

{ #category : 'private' }
CgtElementPathSelector >> crumbAptitudeFor: aCgtThemeSimpleSelector [
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
