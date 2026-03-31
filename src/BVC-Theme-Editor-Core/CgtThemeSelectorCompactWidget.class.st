"
#Theme Selector Compact Widget
I am an early compact custom renderer for the theme selector seam. I render a supplied projection using a small hand-built UI instead of Mondrian so the selector host can evolve toward a denser custom editor without moving selector semantics out of the model.
"
Class {
	#name : 'CgtThemeSelectorCompactWidget',
	#superclass : 'CgtThemeSelectorRendererWidget',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtThemeSelectorCompactWidget >> initialize [
	super initialize.
	self
		vFitContent;
		hMatchParent;
		cellSpacing: 4
]

{ #category : 'rendering' }
CgtThemeSelectorCompactWidget >> refreshContents [
	| selectorLabel summaryRow |
	self removeChildren.
	projection ifNil: [ ^ self ].
	selectorLabel := BrLabel new
		id: #compactSelectorLabel;
		aptitude: BrGlamorousLabelAptitude;
		text: (self selectorLabelText);
		yourself.
	summaryRow := BrHorizontalPane new
		id: #compactNodeSummaryRow;
		vFitContent;
		hMatchParent;
		cellSpacing: 4;
		yourself.
	self summaryTexts do: [ :eachText |
		summaryRow addChild: (self newSummaryBadgeWithText: eachText) ].
	self addChildren: { selectorLabel. summaryRow }.
	^ self
]

{ #category : 'rendering' }
CgtThemeSelectorCompactWidget >> selectorLabelText [
	projection styleRule ifNil: [ ^ '' ].
	projection styleRule selector ifNil: [ ^ '' ].
	^ projection styleRule selector displayString
]

{ #category : 'rendering' }
CgtThemeSelectorCompactWidget >> summaryTexts [
	^ projection nodes collect: [ :aNode | self summaryTextForNode: aNode ]
]

{ #category : 'rendering' }
CgtThemeSelectorCompactWidget >> summaryTextForNode: aProjectionNode [
	aProjectionNode representedElement ifNotNil: [ :anElement |
		^ anElement id
			ifNil: [ aProjectionNode roleLabel ]
			ifNotNil: [ anElement id asString ] ].
	aProjectionNode className ifNotNil: [ :aClassName | ^ aClassName ].
	^ aProjectionNode roleLabel ifNil: [ aProjectionNode kind asString ]
]

{ #category : 'rendering' }
CgtThemeSelectorCompactWidget >> newSummaryBadgeWithText: aString [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
		text: aString;
		yourself
]
