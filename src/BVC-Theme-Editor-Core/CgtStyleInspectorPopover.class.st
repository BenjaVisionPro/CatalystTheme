"
#Style Inspector Popover
I am the popover attached to the selected element in the Theme Editor. I host the selector widget and derive my displayed labels from that widget's current selector context instead of duplicating selector state locally.
"
Class {
	#name : 'CgtStyleInspectorPopover',
	#superclass : 'BrVerticalPane',
	#instVars : [
		'selectorWidget',
		'selectorScrollPane',
		'styleInspectorModel'
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
	styleInspectorModel := CgtThemeStyleInspectorModel new.
	selectorWidget := CgtThemeSelectorWidget new.
	selectorWidget selectorModel: styleInspectorModel selectorModel.
	selectorWidget when: CgtThemeSelectorChangedEvent do: [ :anEvent |
		self selectorChangedEvent: anEvent ].
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
	^ self styleInspectorModel selectorModel
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> styleInspectorModel [
	^ styleInspectorModel
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> styleInspectorModel: aCgtThemeStyleInspectorModel [
	styleInspectorModel := aCgtThemeStyleInspectorModel ifNil: [ CgtThemeStyleInspectorModel new ].
	selectorWidget selectorModel: styleInspectorModel selectorModel.
	self updateLabels.
	^ self
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
CgtStyleInspectorPopover >> configureForStyleInspectorModel: aCgtThemeStyleInspectorModel [
	self styleInspectorModel: aCgtThemeStyleInspectorModel.
	^ self
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> configureForStyleRule: aCgtThemeStyleRule selectedElement: anElement hierarchyRoot: aRootElement relatedStyleRules: aCollection [
	styleInspectorModel
		configureForStyleRule: aCgtThemeStyleRule
		selectedElement: anElement
		hierarchyRoot: aRootElement
		relatedStyleRules: aCollection.
	selectorWidget selectorModel: styleInspectorModel selectorModel.
	self updateLabels.
	^ self
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> selectedElement [
	^ self styleInspectorModel selectedElement
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> selectedElement: anElement [
	self styleInspectorModel selectedElement: anElement.
	selectorWidget selectorModel: self styleInspectorModel selectorModel.
	self updateLabels.
	^ self
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> hierarchyRoot [
	^ self styleInspectorModel hierarchyRoot
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> hierarchyRoot: anElement [
	self styleInspectorModel hierarchyRoot: anElement.
	selectorWidget selectorModel: self styleInspectorModel selectorModel.
	self updateLabels.
	^ self
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> relatedStyleRules [
	^ self styleInspectorModel relatedStyleRules
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> relatedStyleRules: aCollection [
	self styleInspectorModel relatedStyleRules: aCollection.
	selectorWidget selectorModel: self styleInspectorModel selectorModel.
	self updateLabels.
	^ self
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> styleRule [
	^ self styleInspectorModel activeStyleRule
]

{ #category : 'accessing' }
CgtStyleInspectorPopover >> styleRule: aCgtThemeStyleRule [
	self styleInspectorModel activeStyleRule: aCgtThemeStyleRule.
	selectorWidget selectorModel: self styleInspectorModel selectorModel.
	self updateLabels.
	^ self
]

{ #category : 'event handling' }
CgtStyleInspectorPopover >> selectorChangedEvent: anEvent [
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
