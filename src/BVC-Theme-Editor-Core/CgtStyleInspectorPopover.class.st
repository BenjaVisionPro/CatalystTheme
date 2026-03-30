"
#Style Inspector Popover
I am the popover attached to the selected element in the Theme Editor. I am responsible for presenting style-oriented controls for the current selection, including the path selector. I host UI; I do not decide selection or hover semantics.
"
Class {
	#name : 'CgtStyleInspectorPopover',
	#superclass : 'BrVerticalPane',
	#instVars : [
		'styleRule',
		'selectorWidget',
		'selectorScrollPane',
		'elementPath',
		'pathRootElement'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtStyleInspectorPopover >> initialize [
	super initialize.
	self
		vFitContent;
		visibility: BlVisibility gone;
		padding: (BlInsets all: 12);
		background: self theme default contentBackground;
		addAptitude: BrShadowAptitude new beLarge;
		constraintsDo: [ :c |
			c ignoreByLayout.
			c ignored horizontal alignLeft.
			c ignored vertical alignTop ].
	selectorWidget := CgtElementPathSelector new.
	selectorScrollPane := selectorWidget asScrollableElement.
	selectorScrollPane eventDispatcher handlersDo: [ :eachHandler |
		(eachHandler isKindOf: BlScrollableElementEventHandler)
			ifTrue: [ selectorScrollPane removeEventHandler: eachHandler ] ].
	selectorScrollPane addEventHandler: CgtHorizontalScrollableElementEventHandler new.
	selectorScrollPane
		size: 1 @ 24;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: 24 ].
	self addChildren: {
		(BrLabel new
			id: #styleInspectorTitle;
			aptitude: BrGlamorousLabelAptitude;
			text: 'Style').
		(BrLabel new
			id: #styleInspectorElementLabel;
			aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
			text: '').
		selectorScrollPane.
		(BrLabel new
			id: #styleInspectorScopeLabel;
			aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
			text: '') }
]




{ #category : 'accessing' }
CgtStyleInspectorPopover >> selectorWidget [
	^ selectorWidget
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> elementPath [
	^ elementPath
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> elementPath: aCgtElementPath [
	elementPath := aCgtElementPath.
	selectorWidget elementPath: aCgtElementPath
]


{ #category : 'accessing' }
CgtStyleInspectorPopover >> pathRootElement [
	^ pathRootElement
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> pathRootElement: anElement [
	pathRootElement := anElement.
	selectorWidget pathRootElement: anElement
]
{ #category : 'accessing' }
CgtStyleInspectorPopover >> styleRule [
	^ styleRule
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> styleRule: aCgtThemeStyleRule [
	styleRule := aCgtThemeStyleRule.
	selectorWidget selector: (styleRule ifNotNil: [ styleRule selector ]).
	self
		childWithId: #styleInspectorScopeLabel
		ifFound: [ :aLabel |
			aLabel text: (styleRule
				ifNil: [ '' ]
				ifNotNil: [ styleRule selector ifNil: [ '' ] ifNotNil: [ styleRule selector displayString ] ]) ]
		ifNone: [ ].
]

