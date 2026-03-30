"
#Style Inspector Popover
I am the popover attached to the selected element in the Theme Editor. I am responsible for presenting style-oriented controls for the current selection, including the Mondrian matcher widget for editing the current selector rule in live hierarchy context. I host UI; I do not decide selection or hover semantics.
"
Class {
	#name : 'CgtStyleInspectorPopover',
	#superclass : 'BrVerticalPane',
	#instVars : [
		'styleRule',
		'selectorWidget',
		'selectorScrollPane',
		'elementPath',
		'pathRootElement',
		'selectedElement'
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
	selectorWidget := CgtThemeMatcherMondrianWidget new.
	selectorScrollPane := selectorWidget asScrollableElement.
	selectorScrollPane eventDispatcher handlersDo: [ :eachHandler |
		(eachHandler isKindOf: BlScrollableElementEventHandler)
			ifTrue: [ selectorScrollPane removeEventHandler: eachHandler ] ].
	selectorScrollPane addEventHandler: CgtHorizontalScrollableElementEventHandler new.
	selectorScrollPane constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
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
	self selectedElement: (aCgtElementPath ifNil: [ nil ] ifNotNil: [ aCgtElementPath anchorElement ])
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> selectedElement [
	^ selectedElement
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> selectedElement: anElement [
	selectedElement := anElement.
	self refreshMatcherProjection
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> pathRootElement [
	^ pathRootElement
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> pathRootElement: anElement [
	pathRootElement := anElement.
	self refreshMatcherProjection
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> styleRule [
	^ styleRule
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> styleRule: aCgtThemeStyleRule [
	styleRule := aCgtThemeStyleRule.
	self refreshMatcherProjection.
	self updateScopeLabel
]

{ #category : 'private - matcher' }
CgtStyleInspectorPopover >> refreshMatcherProjection [
	| projection |
	(styleRule isNil or: [ selectedElement isNil ]) ifTrue: [
		selectorWidget projection: nil.
		^ self ].
	projection := CgtMatcherProjectionBuilder
		projectionForStyleRule: styleRule
		selectedElement: selectedElement
		hierarchyRoot: pathRootElement.
	selectorWidget projection: projection.
	self updateScopeLabel
]

{ #category : 'private - matcher' }
CgtStyleInspectorPopover >> updateScopeLabel [
	self
		childWithId: #styleInspectorScopeLabel
		ifFound: [ :aLabel |
			aLabel text: (styleRule
				ifNil: [ '' ]
				ifNotNil: [ styleRule selector ifNil: [ '' ] ifNotNil: [ styleRule selector displayString ] ]) ]
		ifNone: [ ]
]
