Class {
	#name : 'CgtStyleInspectorPopover',
	#superclass : 'BrVerticalPane',
	#instVars : [
		'styleRule',
		'selectorWidget'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtStyleInspectorPopover >> initialize [
	super initialize.
	self
		visibility: BlVisibility gone;
		padding: (BlInsets all: 12);
		background: self theme default contentBackground;
		addAptitude: BrShadowAptitude new beLarge;
		constraintsDo: [ :c |
			c ignoreByLayout.
			c ignored horizontal alignLeft.
			c ignored vertical alignTop ].
	selectorWidget := CgtThemeSelectorWidget new.
	self addChildren: {
		(BrLabel new
			id: #styleInspectorTitle;
			aptitude: BrGlamorousLabelAptitude;
			text: 'Style').
		(BrLabel new
			id: #styleInspectorElementLabel;
			aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
			text: '').
		selectorWidget.
		(BrLabel new
			id: #styleInspectorScopeLabel;
			aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
			text: '') }
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
