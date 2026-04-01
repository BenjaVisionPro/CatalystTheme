"
#Element Path Selector
I present the selected element path and its scopes. I am responsible for building the visible path crumbs, compacting hidden segments, and announcing user interaction with path nodes and selectors. I should expose interaction as events rather than by hiding behavior in callbacks.
"
Class {
	#name : 'CgtElementPathSelector',
	#superclass : 'BrBreadcrumb',
	#instVars : [
		'selector',
		'selectedSimpleSelector',
		'elementPath',
		'ancestorRevealCount',
		'hiddenCrumbLabel',
		'hierarchyRoot'
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
CgtElementPathSelector >> hierarchyRoot [
	^ hierarchyRoot
]

{ #category : 'accessing' }
CgtElementPathSelector >> hierarchyRoot: anElement [
	hierarchyRoot := anElement.
	ancestorRevealCount := 0.
	self rebuild
]

{ #category : 'accessing' }
CgtElementPathSelector >> pathRootElement [
	^ self hierarchyRoot
]

{ #category : 'accessing' }
CgtElementPathSelector >> pathRootElement: anElement [
	self hierarchyRoot: anElement
]
{ #category : 'accessing' }
CgtElementPathSelector >> selectedSimpleSelector [
	^ selectedSimpleSelector
]

{ #category : 'actions' }
CgtElementPathSelector >> selectedSimpleSelector: aCgtThemeSimpleSelector [
	selectedSimpleSelector := aCgtThemeSimpleSelector.
	self rebuild.
]


{ #category : 'updating' }
CgtElementPathSelector >> rebuild [
	self removeAllItems.
	elementPath ifNotNil: [ ^ self rebuildForElementPath ].
	selector ifNil: [ ^ self ].
	self addItems: (self allSimpleSelectors collect: [ :each | self newCrumbButtonFor: each ])
]

{ #category : 'updating' }
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

{ #category : 'path building' }
CgtElementPathSelector >> fullPathElements [
	| anchor upstream orderedAncestors current downstream stopParent |
	elementPath ifNil: [ ^ #() ].
	anchor := elementPath anchorElement.
	anchor ifNil: [ ^ #() ].
	upstream := OrderedCollection new.
	stopParent := hierarchyRoot ifNil: [ nil ] ifNotNil: [ hierarchyRoot parent ].
	current := anchor parent.
	[ current notNil and: [ current ~= stopParent ] ] whileTrue: [
		upstream add: current.
		current := current parent ].
	orderedAncestors := upstream reversed.
	downstream := elementPath selectedChildScopeElements.
	^ orderedAncestors , { anchor } , downstream
]

{ #category : 'path building' }
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

{ #category : 'crumb building' }
CgtElementPathSelector >> newElementCrumbFor: anElement [
	| aButton |
	aButton := BrButton new
		label: (self displayStringForElement: anElement);
		aptitude: (self elementCrumbAptitudeFor: anElement);
		action: [ :clickedButton |
			self fireEvent: (CgtElementPathNodeSelectedEvent new element: anElement) ];
		yourself.
	aButton when: BlElementHoveredEvent do: [ :anEvent |
		self fireEvent: (CgtElementPathNodeHoveredEvent new element: anElement) ].
	aButton when: BlElementUnhoveredEvent do: [ :anEvent |
		self fireEvent: (CgtElementPathNodeUnhoveredEvent new element: anElement) ].
	^ aButton
]

{ #category : 'crumb building' }
CgtElementPathSelector >> newHiddenCrumbForHiddenCount: aCount [
	^ BrButton new
		label: hiddenCrumbLabel;
		aptitude: self hiddenCrumbAptitude;
		action: [ :aButton | ancestorRevealCount := ancestorRevealCount + aCount. self rebuild ]
]

{ #category : 'crumb building' }
CgtElementPathSelector >> displayStringForElement: anElement [
	^ anElement id = BlElementId noId
		ifTrue: [ anElement class name ]
		ifFalse: [ anElement id asSymbol printString ]
]

{ #category : 'crumb building' }
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

{ #category : 'crumb building' }
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

{ #category : 'selector building' }
CgtElementPathSelector >> allSimpleSelectors [
	^ self simpleSelectorsIn: selector into: OrderedCollection new
]

{ #category : 'selector building' }
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

{ #category : 'selector building' }
CgtElementPathSelector >> firstSimpleSelector [
	^ self allSimpleSelectors ifEmpty: [ nil ] ifNotEmpty: [ :each | each first ]
]

{ #category : 'crumb building' }
CgtElementPathSelector >> newCrumbButtonFor: aCgtThemeSimpleSelector [
	^ BrButton new
		label: aCgtThemeSimpleSelector displayString;
		aptitude: (self crumbAptitudeFor: aCgtThemeSimpleSelector);
		action: [ :aButton | self selectedSimpleSelector: aCgtThemeSimpleSelector ]
]

{ #category : 'crumb building' }
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
