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
	selectorScrollPane := selectorWidget asPannableElement.
	selectorScrollPane
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ].
	selectorScrollPane children ifNotEmpty: [ :theChildren |
		| aZoomable |
		aZoomable := theChildren first.
		(aZoomable respondsTo: #layout) ifTrue: [
			(aZoomable layout isKindOf: BlZoomableLayout) ifTrue: [
				aZoomable layout
					defaultScale: 1;
					animationDuration: 0 milliSeconds ] ] ].
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
