Class {
	#name : 'CgtThemeEditor',
	#superclass : 'Object',
	#instVars : [
		'targetElement',
		'overlay',
		'eventHandler',
		'isOpen',
		'highlightedElement',
		'selectedElement',
		'viewHierarchyWidget',
		'layoutContainer',
		'contentContainer',
		'editorPane',
		'isViewVisible',
		'inspectorSpacer',
		'originalContentChildren',
		'brandButton',
		'inspectorWidthAnimation'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'instance creation' }
CgtThemeEditor class >> brandImagePath [
	^ '/opt/TestDevSetup/git_root/projects/CatalystTheme/resources/themeEditor.png'
]

{ #category : 'instance creation' }
CgtThemeEditor class >> closeOn: anElement [
	| anEditor |
	anEditor := self editorOn: anElement.
	anEditor ifNil: [ ^ nil ].
	anEditor close.
	anElement userData removeKey: self userDataKey ifAbsent: [ ].
	^ nil
]

{ #category : 'instance creation' }
CgtThemeEditor class >> editorOn: anElement [
	^ anElement userData at: self userDataKey ifAbsent: [ nil ]
]

{ #category : 'instance creation' }
CgtThemeEditor class >> on: anElement [
	^ self new
		targetElement: anElement;
		open;
		yourself
]

{ #category : 'instance creation' }
CgtThemeEditor class >> openOn: anElement [
	| anEditor |
	anEditor := self editorOn: anElement.
	anEditor ifNotNil: [ ^ anEditor ].
	anEditor := self on: anElement.
	anElement userData at: self userDataKey put: anEditor.
	^ anEditor
]

{ #category : 'instance creation' }
CgtThemeEditor class >> toggleOn: anElement [
	^ (self editorOn: anElement)
		ifNil: [ self openOn: anElement ]
		ifNotNil: [ self closeOn: anElement ]
]

{ #category : 'instance creation' }
CgtThemeEditor class >> userDataKey [
	^ #cgtThemeEditor
]

{ #category : 'private - pane' }
CgtThemeEditor >> addElements: elements into: aContainer [
	elements do: [ :each |
		each removeFromParent.
		aContainer addChild: each ]
]


{ #category : 'closing' }
CgtThemeEditor >> close [
	self isOpen ifFalse: [ ^ self ].
	self hideView.
	self restoreOriginalContentChildren.
	layoutContainer ifNotNil: [ layoutContainer removeFromParent ].
	overlay ifNotNil: [ overlay detach ].
	eventHandler ifNotNil: [ targetElement removeEventHandler: eventHandler ].
	overlay := nil.
	eventHandler := nil.
	viewHierarchyWidget := nil.
	editorPane := nil.
	contentContainer := nil.
	layoutContainer := nil.
	inspectorSpacer := nil.
	originalContentChildren := nil.
	brandButton := nil.
	inspectorWidthAnimation := nil.
	highlightedElement := nil.
	selectedElement := nil.
	isViewVisible := false.
	isOpen := false
]

{ #category : 'accessing' }
CgtThemeEditor >> editorPane [
	^ editorPane
]

{ #category : 'accessing' }
CgtThemeEditor >> eventHandler [
	^ eventHandler
]

{ #category : 'accessing' }
CgtThemeEditor >> highlightedElement [
	^ highlightedElement
]

{ #category : 'accessing' }
CgtThemeEditor >> highlightedElement: anElementOrNil [
	highlightedElement == anElementOrNil ifTrue: [ ^ self ].
	highlightedElement := anElementOrNil.
	overlay ifNotNil: [ overlay highlightElement: anElementOrNil ]
]

{ #category : 'accessing' }
CgtThemeEditor >> hierarchyRootChildren [
	^ contentContainer
		ifNil: [ self movableContentChildren ]
		ifNotNil: [ contentContainer children ]
]

{ #category : 'private - animation' }
CgtThemeEditor >> animateInspectorWidthTo: aWidth [
	| startWidth animation |
	inspectorSpacer ifNil: [ ^ self ].
	startWidth := self inspectorWidth.
	startWidth = aWidth ifTrue: [
		self updateInspectorWidth: aWidth.
		^ self ].
	animation := BlNumberTransition new
		from: startWidth;
		to: aWidth;
		duration: 500 milliSeconds;
		easing: CgtFastInSlowOutEasing new;
		onStepDo: [ :value | self updateInspectorWidth: value rounded ];
		onFinishedDo: [
			self updateInspectorWidth: aWidth.
			inspectorWidthAnimation := nil ];
		yourself.
	inspectorWidthAnimation := animation.
	animation start
]

{ #category : 'private - ui' }
CgtThemeEditor >> updateInspectorWidth: aWidth [
	inspectorSpacer ifNil: [ ^ self ].
	inspectorSpacer width: aWidth.
	self updateBrandButtonPosition.
	layoutContainer ifNotNil: [ layoutContainer requestLayout ].
	overlay ifNotNil: [ overlay invalidate ]
]

{ #category : 'accessing' }
CgtThemeEditor >> inspectorWidth [
	^ inspectorSpacer
		ifNil: [ 0 ]
		ifNotNil: [ inspectorSpacer width ]
]

{ #category : 'private - pane' }
CgtThemeEditor >> hideView [
	isViewVisible ifFalse: [ ^ self ].
	editorPane ifNotNil: [ editorPane removeFromParent ].
	editorPane := nil.
	isViewVisible := false.
	self animateInspectorWidthTo: 0
]

{ #category : 'initialization' }
CgtThemeEditor >> initialize [
	super initialize.
	isOpen := false.
	isViewVisible := false.
	highlightedElement := nil.
	selectedElement := nil.
	viewHierarchyWidget := nil.
	editorPane := nil.
	contentContainer := nil.
	layoutContainer := nil.
	inspectorSpacer := nil.
	originalContentChildren := nil.
	brandButton := nil.
	inspectorWidthAnimation := nil
]

{ #category : 'accessing' }
CgtThemeEditor >> isOpen [
	^ isOpen = true
]

{ #category : 'accessing' }
CgtThemeEditor >> isViewVisible [
	^ isViewVisible = true
]

{ #category : 'private - pane' }
CgtThemeEditor >> movableContentChildren [
	^ targetElement children reject: [ :each | each == overlay or: [ each == layoutContainer ] ]
]

{ #category : 'private - ui' }
CgtThemeEditor >> newBrandButton [
	| imageForm |
	imageForm := PNGReadWriter formFromFileNamed: self class brandImagePath.
	^ (brandButton := BrButton new)
		aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonExteriorAptitude;
		background: Color transparent;
		border: BlBorder empty;
		icon: imageForm;
		label: 'Theme Inspector';
		width: 100;
		height: 100;
		padding: (BlInsets all: 0);
		constraintsDo: [ :c |
			c ignoreByLayout.
			c ignored horizontal alignRight.
			c ignored vertical alignBottom.
			c margin: self brandButtonMargin ];
		action: [ self toggleView ];
		yourself
]

{ #category : 'private - ui' }
CgtThemeEditor >> brandButtonMargin [
	^ BlInsets bottom: 18 right: self brandButtonRightMargin
]

{ #category : 'private - ui' }
CgtThemeEditor >> brandButtonRightMargin [
	^ (isViewVisible ifTrue: [ 520 ] ifFalse: [ 0 ]) + 8
]


{ #category : 'private - ui' }
CgtThemeEditor >> updateBrandButtonPosition [
	brandButton ifNil: [ ^ self ].
	brandButton constraintsDo: [ :c |
		c ignoreByLayout.
		c ignored horizontal alignRight.
		c ignored vertical alignBottom.
		c margin: self brandButtonMargin ]
]

{ #category : 'private - ui' }
CgtThemeEditor >> newEditorPane [
	^ BrVerticalPane new
		constraintsDo: [ :c |
			c ignoreByLayout.
			c ignored horizontal alignRight.
			c vertical matchParent ];
		width: 520;
		padding: (BlInsets top: 10 left: 10 bottom: 10 right: 10);
		addAptitude: BrShadowAptitude new beLarge;
		background: targetElement theme default backdropBackground;
		addChildren: {
			(self newSectionLabel text: 'Theme Editor').
			(BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				hMatchParent;
				padding: (BlInsets top: 10 right: 12 bottom: 10 left: 12);
				background: targetElement theme header defaultBackgroundColor;
				text: 'View Hierarchy').
			viewHierarchyWidget }
]

{ #category : 'private - ui' }
CgtThemeEditor >> newLayoutContainer [
	^ BrHorizontalPane new
		matchParent;
		addChildren: {
			self newWorldContentContainer.
			self newInspectorSpacer }
]

{ #category : 'private - ui' }
CgtThemeEditor >> newInspectorSpacer [
	^ (inspectorSpacer := BlElement new)
		width: 0;
		height: 1;
		yourself
]

{ #category : 'private - ui' }
CgtThemeEditor >> newSectionLabel [
	^ BrLabel new aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray)
]

{ #category : 'private - ui' }
CgtThemeEditor >> newWorldContentContainer [
	^ (contentContainer := BrVerticalPane new)
		matchParent;
		constraintsDo: [ :c |
			c linear weight: 1 ];
		yourself
]

{ #category : 'opening' }
CgtThemeEditor >> open [
	self isOpen ifTrue: [ ^ self ].
	originalContentChildren := self movableContentChildren asArray.
	layoutContainer := self newLayoutContainer.
	self addElements: originalContentChildren into: contentContainer.
	targetElement addChild: layoutContainer.
	overlay := CgtThemeEditorOverlay on: targetElement.
	viewHierarchyWidget := CgtThemeEditorViewHierarchyWidget on: self.
	overlay addChild: self newBrandButton.
	self updateBrandButtonPosition.
	eventHandler := CgtThemeEditorEventHandler new.
	eventHandler editor: self.
	targetElement addEventHandler: eventHandler.
	isOpen := true
]

{ #category : 'private - pane' }
CgtThemeEditor >> restoreOriginalContentChildren [
	originalContentChildren ifNil: [ ^ self ].
	self addElements: originalContentChildren into: targetElement
]

{ #category : 'accessing' }
CgtThemeEditor >> overlay [
	^ overlay
]

{ #category : 'accessing' }
CgtThemeEditor >> selectedElement [
	^ selectedElement
]

{ #category : 'accessing' }
CgtThemeEditor >> selectedElement: anElementOrNil [
	selectedElement == anElementOrNil ifTrue: [ ^ self ].
	selectedElement := anElementOrNil.
	overlay ifNotNil: [ overlay selectElement: anElementOrNil ].
	viewHierarchyWidget ifNotNil: [ viewHierarchyWidget selectElement: anElementOrNil ]
]

{ #category : 'private - pane' }
CgtThemeEditor >> showView [
	isViewVisible ifTrue: [ ^ self ].
	viewHierarchyWidget ifNotNil: [ viewHierarchyWidget removeFromParent ].
	editorPane := self newEditorPane.
	overlay ifNotNil: [ overlay addChild: editorPane ].
	viewHierarchyWidget ifNotNil: [ viewHierarchyWidget refreshItems ].
	selectedElement ifNotNil: [ viewHierarchyWidget selectElement: selectedElement ].
	isViewVisible := true.
	self animateInspectorWidthTo: 520
]

{ #category : 'accessing' }
CgtThemeEditor >> targetElement [
	^ targetElement
]

{ #category : 'accessing' }
CgtThemeEditor >> targetElement: anElement [
	targetElement := anElement
]

{ #category : 'actions' }
CgtThemeEditor >> toggleView [
	self isViewVisible
		ifTrue: [ self hideView ]
		ifFalse: [ self showView ]
]

{ #category : 'accessing' }
CgtThemeEditor >> viewHierarchyWidget [
	^ viewHierarchyWidget
]
