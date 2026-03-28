Class {
	#name : 'CgtElementPathSelector',
	#superclass : 'BrBreadcrumb',
	#instVars : [
		'selector',
		'selectedSimpleSelector',
		'onSelectorSelectedBlock',
		'elementPath',
		'ancestorRevealCount',
		'hiddenCrumbLabel',
		'onElementPathNodeSelectedBlock',
		'pathRootElement'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtElementPathSelector >> initialize [
	super initialize.
	ancestorRevealCount := 0.
	hiddenCrumbLabel := '…'.
	self
		hFitContent;
		constraintsDo: [ :c | c vertical exact: 24 ];
		aptitude: (BrGlamorousBreadcrumbAptitude new
				separator: [ BrLabel new
						aptitude: (BrGlamorousLabelAptitude new thin foreground: Color gray);
						text: '>';
						margin: (BlInsets left: 4 right: 4) ])
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
CgtElementPathSelector >> elementPath [
	^ elementPath
]

{ #category : 'accessing' }
CgtElementPathSelector >> elementPath: aCgtElementPath [
	elementPath := aCgtElementPath.
	ancestorRevealCount := 0.
	self rebuild
]


{ #category : 'accessing' }
CgtElementPathSelector >> pathRootElement [
	^ pathRootElement
]

{ #category : 'accessing' }
CgtElementPathSelector >> pathRootElement: anElement [
	pathRootElement := anElement.
	ancestorRevealCount := 0.
	self rebuild
]
{ #category : 'accessing' }
CgtElementPathSelector >> onElementPathNodeSelectedDo: aBlock [
	onElementPathNodeSelectedBlock := aBlock
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
	elementPath ifNotNil: [ ^ self rebuildForElementPath ].
	selector ifNil: [ ^ self ].
	self addItems: (self allSimpleSelectors collect: [ :each | self newCrumbButtonFor: each ])
]

{ #category : 'private' }
CgtElementPathSelector >> rebuildForElementPath [
	| fullPath visibleIndexes items previousIndex hiddenLeftCount |
	fullPath := self fullPathElements.
	fullPath ifEmpty: [ ^ self ].
	visibleIndexes := self visibleIndexesForFullPath: fullPath.
	items := OrderedCollection new.
	previousIndex := 0.
	visibleIndexes do: [ :eachIndex |
		hiddenLeftCount := eachIndex - previousIndex - 1.
		hiddenLeftCount > 0 ifTrue: [ items add: (self newHiddenCrumbForHiddenCount: hiddenLeftCount) ].
		items add: (self newElementCrumbFor: (fullPath at: eachIndex)).
		previousIndex := eachIndex ].
	self addItems: items
]

{ #category : 'private' }
CgtElementPathSelector >> fullPathElements [
	| anchor upstream orderedAncestors current downstream stopParent |
	elementPath ifNil: [ ^ #() ].
	anchor := elementPath anchorElement.
	anchor ifNil: [ ^ #() ].
	upstream := OrderedCollection new.
	stopParent := pathRootElement ifNil: [ nil ] ifNotNil: [ pathRootElement parent ].
	current := anchor parent.
	[ current notNil and: [ current ~= stopParent ] ] whileTrue: [
		upstream add: current.
		current := current parent ].
	orderedAncestors := upstream reversed.
	downstream := elementPath downstreamElements.
	^ orderedAncestors , { anchor } , downstream
]

{ #category : 'private' }
CgtElementPathSelector >> visibleIndexesForFullPath: fullPath [
	| pathElements scopeIndexes firstScopeIndex startIndex indexes |
	elementPath ifNil: [ ^ (1 to: fullPath size) asOrderedCollection ].
	pathElements := elementPath elements.
	scopeIndexes := OrderedCollection new.
	fullPath doWithIndex: [ :eachElement :anIndex |
		(pathElements includes: eachElement) ifTrue: [ scopeIndexes add: anIndex ] ].
	scopeIndexes ifEmpty: [ ^ OrderedCollection with: (fullPath indexOf: elementPath anchorElement ifAbsent: [ 1 ]) ].
	firstScopeIndex := scopeIndexes first.
	startIndex := (firstScopeIndex - ancestorRevealCount) max: 1.
	indexes := OrderedCollection new.
	(startIndex to: firstScopeIndex - 1) do: [ :each | indexes add: each ].
	scopeIndexes do: [ :each | (indexes includes: each) ifFalse: [ indexes add: each ] ].
	^ indexes
]

{ #category : 'private' }
CgtElementPathSelector >> newElementCrumbFor: anElement [
	^ BrButton new
		label: (self displayStringForElement: anElement);
		aptitude: (self elementCrumbAptitudeFor: anElement);
		action: [ :aButton | onElementPathNodeSelectedBlock ifNotNil: [ onElementPathNodeSelectedBlock value: anElement ] ]
]

{ #category : 'private' }
CgtElementPathSelector >> newHiddenCrumbForHiddenCount: aCount [
	^ BrButton new
		label: hiddenCrumbLabel;
		aptitude: self hiddenCrumbAptitude;
		action: [ :aButton | ancestorRevealCount := ancestorRevealCount + aCount. self rebuild ]
]

{ #category : 'private' }
CgtElementPathSelector >> displayStringForElement: anElement [
	^ anElement id = BlElementId noId
		ifTrue: [ anElement class name ]
		ifFalse: [ anElement id asSymbol printString ]
]

{ #category : 'private' }
CgtElementPathSelector >> elementCrumbAptitudeFor: anElement [
	| selected scope base background |
	base := (BrGlamorousButtonLabelAptitude new
			hoveredColor: Color black;
			pressedColor: Color black) +
		(BrGlamorousButtonRectangularAptitude
			paddingScale: 0.8
			heightScale: 0.85
			cornerRadius: 6).
	scope := elementPath notNil and: [ elementPath includesElement: anElement ].
	selected := elementPath notNil and: [ elementPath anchorElement == anElement ].
	background := selected
		ifTrue: [ Color gray alpha: 0.32 ]
		ifFalse: [ scope ifTrue: [ Color gray alpha: 0.2 ] ifFalse: [ Color gray alpha: 0.08 ] ].
	^ base + (BrStyleCommonAptitude new
		default: [ :s | s background: background ];
		hovered: [ :s | s background: (background alpha: ((background alpha + 0.08) min: 1.0)) ];
		pressed: [ :s | s background: (background alpha: ((background alpha + 0.16) min: 1.0)) ])
]

{ #category : 'private' }
CgtElementPathSelector >> hiddenCrumbAptitude [
	^ (BrGlamorousButtonLabelAptitude new
			hoveredColor: Color black;
			pressedColor: Color black) +
		(BrGlamorousButtonRectangularAptitude
			paddingScale: 0.6
			heightScale: 0.8
			cornerRadius: 6) +
		(BrStyleCommonAptitude new
			default: [ :s | s background: (Color gray alpha: 0.05) ];
			hovered: [ :s | s background: (Color gray alpha: 0.14) ];
			pressed: [ :s | s background: (Color gray alpha: 0.22) ])
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
