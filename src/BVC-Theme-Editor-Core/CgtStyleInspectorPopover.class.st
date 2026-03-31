"
#Style Inspector Popover
I am the popover attached to the selected element in the Theme Editor. I host the selector widget and derive my displayed labels from that widget's current selector context instead of duplicating selector state locally.
"
Class {
	#name : 'CgtStyleInspectorPopover',
	#superclass : 'BrVerticalPane',
	#instVars : [
		'selectorWidget',
		'selectorScrollPane'
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
	selectorWidget := CgtThemeSelectorWidget new.
	selectorWidget when: CgtMatcherSelectorChangedEvent do: [ :anEvent |
		self matcherSelectorChangedEvent: anEvent ].
	selectorScrollPane := selectorWidget asScrollableElement.
	selectorScrollPane eventDispatcher handlersDo: [ :eachHandler |
		(eachHandler isKindOf: BlScrollableElementEventHandler)
			ifTrue: [ selectorScrollPane removeEventHandler: eachHandler ] ].
	selectorScrollPane addEventHandler: CgtHorizontalScrollableElementEventHandler new.
	selectorScrollPane constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: CgtMatcherLayoutPolicy new popoverMatcherHeight ].
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
CgtStyleInspectorPopover >> selectorModel [
	^ selectorWidget selectorModel
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> selectorRendererWidget [
	^ selectorWidget selectorRendererWidget
]



{ #category : 'accessing' }
CgtStyleInspectorPopover >> selectorRendererWidgetClass [
	^ selectorWidget selectorRendererWidgetClass
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> selectorRendererWidgetClass: aClass [
	selectorWidget selectorRendererWidgetClass: aClass.
	^ self
]

{ #category : 'editing' }
CgtStyleInspectorPopover >> showOtherRuleContext [
	selectorWidget showOtherRuleContext.
	^ self
]

{ #category : 'editing' }
CgtStyleInspectorPopover >> hideOtherRuleContext [
	selectorWidget hideOtherRuleContext.
	^ self
]

{ #category : 'editing' }
CgtStyleInspectorPopover >> toggleOtherRuleContext [
	selectorWidget toggleOtherRuleContext.
	^ self
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> configureForStyleRule: aCgtThemeStyleRule selectedElement: anElement pathRootElement: aRootElement relatedStyleRules: aCollection [
	selectorWidget
		configureForStyleRule: aCgtThemeStyleRule
		selectedElement: anElement
		pathRootElement: aRootElement
		relatedStyleRules: aCollection.
	self updateLabels.
	^ self
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> selectedElement [
	^ selectorWidget selectedElement
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> selectedElement: anElement [
	selectorWidget selectedElement: anElement.
	self updateLabels.
	^ self
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> pathRootElement [
	^ selectorWidget pathRootElement
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> pathRootElement: anElement [
	selectorWidget pathRootElement: anElement.
	self updateLabels.
	^ self
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> relatedStyleRules [
	^ selectorWidget relatedStyleRules
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> relatedStyleRules: aCollection [
	selectorWidget relatedStyleRules: aCollection.
	self updateLabels.
	^ self
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> styleRule [
	^ selectorWidget currentStyleRule
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> styleRule: aCgtThemeStyleRule [
	selectorWidget styleRule: aCgtThemeStyleRule.
	self updateLabels.
	^ self
]

{ #category : 'event handling' }
CgtStyleInspectorPopover >> matcherSelectorChangedEvent: anEvent [
	self updateLabels
]

{ #category : 'private - labels' }
CgtStyleInspectorPopover >> updateLabels [
	self updateElementLabel.
	self updateScopeLabel
]

{ #category : 'private - labels' }
CgtStyleInspectorPopover >> updateElementLabel [
	self
		childWithId: #styleInspectorElementLabel
		ifFound: [ :aLabel |
			aLabel text: (self selectedElement
				ifNil: [ '' ]
				ifNotNil: [ self selectedElement class name ]) ]
		ifNone: [ ]
]

{ #category : 'private - labels' }
CgtStyleInspectorPopover >> updateScopeLabel [
	self
		childWithId: #styleInspectorScopeLabel
		ifFound: [ :aLabel |
			aLabel text: (self styleRule
				ifNil: [ '' ]
				ifNotNil: [ self styleRule selector ifNil: [ '' ] ifNotNil: [ self styleRule selector displayString ] ]) ]
		ifNone: [ ]
]
