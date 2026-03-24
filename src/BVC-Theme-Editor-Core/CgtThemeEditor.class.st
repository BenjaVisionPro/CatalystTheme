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
		'isViewVisible'
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
CgtThemeEditor >> addContentChildrenInto: aContainer [
	self movableContentChildren do: [ :each |
		each removeFromParent.
		aContainer addChild: each ]
]

{ #category : 'closing' }
CgtThemeEditor >> close [
	self isOpen ifFalse: [ ^ self ].
	self hideView.
	overlay ifNotNil: [ overlay detach ].
	eventHandler ifNotNil: [ targetElement removeEventHandler: eventHandler ].
	overlay := nil.
	eventHandler := nil.
	viewHierarchyWidget := nil.
	editorPane := nil.
	contentContainer := nil.
	layoutContainer := nil.
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
	^ self movableContentChildren
]

{ #category : 'private - pane' }
CgtThemeEditor >> hideView [
	isViewVisible ifFalse: [ ^ self ].
	editorPane ifNotNil: [ editorPane removeFromParent ].
	layoutContainer := nil.
	contentContainer := nil.
	editorPane := nil.
	isViewVisible := false
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
	layoutContainer := nil
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
	| imageForm iconElement |
	imageForm := PNGReadWriter formFromFileNamed: self class brandImagePath.
	iconElement := imageForm asElement asScalableElement.
	iconElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	^ BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonExteriorAptitude;
		width: 88;
		height: 88;
		padding: (BlInsets all: 4);
		label: '';
		icon: [ iconElement ] asStencil;
		constraintsDo: [ :c |
			c ignoreByLayout.
			c ignored horizontal alignRight.
			c ignored vertical alignBottom.
			c margin: (BlInsets bottom: 32 right: 16) ];
		action: [ self toggleView ];
		yourself
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
	| aContainer |
	aContainer := BrHorizontalPane new
		matchParent;
		addChildren: {
			(self newWorldContentContainer).
			(editorPane := self newEditorPane) }.
	^ aContainer
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
			c linear weight: 0.618 ];
		yourself
]

{ #category : 'opening' }
CgtThemeEditor >> open [
	self isOpen ifTrue: [ ^ self ].
	overlay := CgtThemeEditorOverlay on: targetElement.
	viewHierarchyWidget := CgtThemeEditorViewHierarchyWidget on: self.
	overlay addChild: self newBrandButton.
	eventHandler := CgtThemeEditorEventHandler new.
	eventHandler editor: self.
	targetElement addEventHandler: eventHandler.
	isOpen := true
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
	isViewVisible := true
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
