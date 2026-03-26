Class {
	#name : 'CgtEditor',
	#superclass : 'BlElement',
	#instVars : [
		'targetContainer',
		'selectedElement',
		'inspector',
		'elementsTree',
		'scenePage',
		'detailsPage',
		'isOpeningPreview',
		'isClosingPreview',
		'scenePreviewElement',
		'sceneContainer',
		'previewAnimationToken',
		'detailsAnimationToken',
		'currentPreviewScale'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'api - animation' }
CgtEditor >> animateCloseOnFinishedDo: aBlock [
	isClosingPreview := true.
	isOpeningPreview := false.
	self
		animateDetailsWeightTo: 0.0
		onFinishedDo: [ ].
	self
		animatePreviewScaleTo: 1.0
		onFinishedDo: [
			isClosingPreview := false.
			aBlock value ]
]

{ #category : 'api - animation' }
CgtEditor >> animateDetailsOpen [
	selectedElement ifNil: [ ^ self ].
	self detailsWeight >= self openedDetailsWeight ifTrue: [ ^ self ].
	self
		animateDetailsWeightTo: self openedDetailsWeight
		onFinishedDo: [ ]
]

{ #category : 'api - animation' }
CgtEditor >> animateOpen [
	self animateOpenOnFinishedDo: [ ]
]

{ #category : 'api - animation' }
CgtEditor >> animateOpenOnFinishedDo: aBlock [
	isOpeningPreview := true.
	isClosingPreview := false.
	self
		animatePreviewScaleTo: self previewScale x
		onFinishedDo: [
			isOpeningPreview := false.
			aBlock value ].
	(selectedElement notNil and: [ self detailsWeight > 0.0 ])
		ifTrue: [ self
			animateDetailsWeightTo: self openedDetailsWeight
			onFinishedDo: [ ] ]
]

{ #category : 'private - tree' }
CgtEditor >> bindElementTreeValue: eachElement toRowElement: aRowElement [	
	aRowElement
		childWithId: #elementLabel
		ifFound: [ :anElementLabel | anElementLabel text: eachElement class name ]
		ifNone: [  ].

	aRowElement
		childWithId: #elementId
		ifFound: [ :anElementIdButton |
			eachElement id = BlElementId noId
				ifTrue: [
					anElementIdButton model: nil.
					anElementIdButton label: ''.
					anElementIdButton visibility: BlVisibility gone ]
				ifFalse: [
					anElementIdButton model: eachElement id.
					anElementIdButton label: eachElement id asSymbol printString.
					anElementIdButton visibility: BlVisibility visible
				] ]
		ifNone: [  ].

	aRowElement
		childWithId: #elementResizers
		ifFound: [ :anElementResizersLabel |
			anElementResizersLabel text: (String streamContents: [ :aStream |
				aStream
					nextPutAll: 'h: ';
					nextPutAll: eachElement constraints horizontal resizer asString asLowercase;
					nextPutAll: '   ';
					nextPutAll: 'v: ';
					nextPutAll: eachElement constraints vertical resizer asString asLowercase
			]) ]
		ifNone: [  ].
		
	self bindElementTreeValuePhlowContext: eachElement toRowElement: aRowElement.
	self bindElementTreeValueWhenAddedToSceneGraph: eachElement toRowElement: aRowElement
]

{ #category : 'private - tree' }
CgtEditor >> bindElementTreeValuePhlowContext: eachElement toRowElement: aRowElement [ 
	aRowElement
		childWithId: #phlowContext
		ifFound: [ :anPhlowContextButton | 
			((eachElement userData includesKey: #phlow)  and: [
				eachElement phlow hasActivePhlowContexts])
			ifTrue: [
				anPhlowContextButton model: eachElement phlow.
				anPhlowContextButton label: ('phlow: ', eachElement phlow activePhlowContextsDescription).
				anPhlowContextButton visibility: BlVisibility visible]
			ifFalse: [
				anPhlowContextButton model: nil.
				anPhlowContextButton label: ''.
				anPhlowContextButton visibility: BlVisibility gone ] ]
		ifNone: [  ].
]

{ #category : 'private - tree' }
CgtEditor >> bindElementTreeValueWhenAddedToSceneGraph: eachElement toRowElement: aRowElement [
	aRowElement
		childWithId: #whenAddedToSceneGraph
		ifFound: [ :anElementIdButton |
			| anOverridenMethod isOverriden eventHandlers|
			
			anOverridenMethod := eachElement class lookupSelector: #onAddedToSceneGraph.
			isOverriden := anOverridenMethod
				ifNil: [ false ]
				ifNotNil: [ :aMethod | aMethod methodClass ~= BlElement ].
				
			eventHandlers := Array
				streamContents: [ :aStream |
					eachElement eventDispatcher
						handlersDo: [ :eachEventHandler |
							(self doesEventHandler: eachEventHandler want: BlElementAddedToSceneGraphEvent)
								ifTrue: [ aStream nextPut: eachEventHandler ] ];
						filtersDo: [ :eachEventHandler |
							(self doesEventHandler: eachEventHandler want: BlElementAddedToSceneGraphEvent)
								ifTrue: [ aStream nextPut: eachEventHandler ] ] ].

			(isOverriden not and: [ eventHandlers isEmpty ])
				ifTrue: [
					anElementIdButton model: nil.
					anElementIdButton label: ''.
					anElementIdButton visibility: BlVisibility gone ]
				ifFalse: [
					| aLabel aModel |
				
					aLabel := String streamContents: [ :aStream |
						isOverriden
							ifTrue: [ aStream nextPutAll: '#onAddedToSceneGraph' ].
						eventHandlers ifNotEmpty: [ :theHandlers |
							isOverriden ifTrue: [ aStream nextPutAll: ' and ' ].
							aStream
								print: theHandlers size;
								space;
								nextPutAll: 'AddedToSceneGraph event handlers' ] ].
					
					(isOverriden and: [ eventHandlers isNotEmpty ])
						ifTrue: [ aModel := OrderedDictionary new
							at: anOverridenMethod  printString put: anOverridenMethod;
							at: 'AddedToSceneGraph event handlers' put: eventHandlers;
							yourself ].
							
					(isOverriden and: [ eventHandlers isEmpty ])
						ifTrue: [ aModel := anOverridenMethod ].
					
					(isOverriden not and: [ eventHandlers isNotEmpty ])
						ifTrue: [ aModel := eventHandlers ].
				
					anElementIdButton model: aModel.
					anElementIdButton label: aLabel.
					anElementIdButton visibility: BlVisibility visible
				] ]
		ifNone: [  ].
]

{ #category : 'accessing' }
CgtEditor >> detailsWeight [
	^ 1.0 - self sceneWeight
]

{ #category : 'accessing' }
CgtEditor >> detailsWeight: aWeight [
	| aSceneWeight |
	aSceneWeight := 1.0 - aWeight.

	detailsPage visibility: (aWeight <= 0.0
		ifTrue: [ BlVisibility gone ]
		ifFalse: [ BlVisibility visible ]).

	scenePage constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent.
		c linear weight: aSceneWeight ].

	detailsPage constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent.
		c linear weight: aWeight ]
]

{ #category : 'private - animation' }
CgtEditor >> animateDetailsWeightTo: aWeight onFinishedDo: aBlock [
	| aToken |
	detailsAnimationToken := detailsAnimationToken + 1.
	aToken := detailsAnimationToken.
	self
		addAnimation: (BlNumberTransition new
				from: self detailsWeight;
				to: aWeight;
				duration: 800 milliSeconds;
				easing: CgtFastInSlowOutEasing new;
				onStepDo: [ :eachWeight :anEditor |
					anEditor detailsAnimationToken = aToken
						ifTrue: [ anEditor detailsWeight: eachWeight ] ];
				onFinishedDo: [ self detailsAnimationToken = aToken ifTrue: [ aBlock value ] ];
				yourself)
]

{ #category : 'private - animation' }
CgtEditor >> animatePreviewScaleTo: aScale onFinishedDo: aBlock [
	| aToken |
	previewAnimationToken := previewAnimationToken + 1.
	aToken := previewAnimationToken.
	scenePreviewElement ifNil: [ ^ self ].
	scenePreviewElement
		addAnimation: (BlNumberTransition new
				from: currentPreviewScale;
				to: aScale;
				duration: 1500 milliSeconds;
				easing: CgtFastInSlowOutEasing new;
				onStepDo: [ :eachScale :anElement |
					self previewAnimationToken = aToken
						ifTrue: [ self applyPreviewScale: eachScale ] ];
				onFinishedDo: [ self previewAnimationToken = aToken ifTrue: [ aBlock value ] ];
				yourself)
]

{ #category : 'private - animation' }
CgtEditor >> applyPreviewScale: aScale [
	currentPreviewScale := aScale.
	scenePreviewElement ifNotNil: [ scenePreviewElement scale: aScale @ aScale ]
]


{ #category : 'private - tree' }
CgtEditor >> doesEventHandler: anEventHandler want: anEventClass [
	<return: #Boolean>

	((anEventHandler isKindOf: BlEventHandler) and: [ anEventHandler eventClass = anEventClass ])
		ifTrue: [ ^ true ].
		
	(anEventHandler isKindOf: BlEventForwarder)
		ifTrue: [ ^ self doesEventHandler: anEventHandler eventHandler want: anEventClass ].
		
	^ false
]

{ #category : 'initialization' }
CgtEditor >> initialize [
	super initialize.
	isOpeningPreview := false.
	isClosingPreview := false.
	previewAnimationToken := 0.
	detailsAnimationToken := 0.
	currentPreviewScale := 1.0.
	self
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		layout: BlLinearLayout horizontal;
		background: self theme header defaultBackgroundColor
]

{ #category : 'initialization' }
CgtEditor >> initializeWith: aTargetContainer [
	targetContainer := aTargetContainer.

	scenePage := BlElement new
		layout: BlLinearLayout vertical alignCenter;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c linear weight: 1.0 ];
		addChild: (self newSceneContainerFor: aTargetContainer).

	detailsPage := BlElement new
		visibility: BlVisibility gone;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c linear weight: 0.0 ];
		addChild: (self newPagerFor: aTargetContainer).

	self addChildren: { scenePage. detailsPage }.

	self addChildren: { 
		self newCloseButtonFor: aTargetContainer }
]

{ #category : 'accessing' }
CgtEditor >> inspectElement: anElement [
	selectedElement == anElement
		ifTrue: [ ^ self ].

	selectedElement := anElement.
	elementsTree phlow spawnObject: selectedElement
]

{ #category : 'instance creation' }
CgtEditor >> newCloseButtonFor: aTargetContainer [
	^ BrButton new
		aptitude: BrGlamorousButtonCircularAptitude + BrGlamorousButtonIconAptitude + BrGlamorousButtonFlatExteriorAptitude + BrGlamorousButtonLayoutAptitude;
		icon: [ (BrGlamorousVectorIcons close asElement
				outskirts: BlOutskirts centered;
				background: Color gray;
				border: (BlBorder paint: Color transparent width: 0.8)) ] asStencil;
		beLargeSize;
		constraintsDo: [ :c |
			c ignoreByLayout.
			c ignored horizontal alignRight.
			c ignored vertical alignTop.
			c margin: (BlInsets top: 5) ];
		action: [ :e | e fireEvent: CgtEditorHideWish new ]
]

{ #category : 'instance creation' }
CgtEditor >> newElementsTree [	
	^ BrSimpleTree new
		matchParent;
		padding: (BlInsets top: 5);
		rowStencil: (CgtEditorTreeRowStencilBuilder new
			whenHovered: [ :anEvent |
				| thisRow thisRowValue |
				
				thisRow := anEvent currentTarget.
				thisRowValue := (elementsTree nodeAt: thisRow constraints infinite holder dataSourcePosition) value.
				thisRow fireEvent: (CgtEditorHighlightElementWish new element: thisRowValue) ];
			whenUnhovered: [ :anEvent | anEvent currentTarget fireEvent: (CgtEditorHideHighlightWish new) ]);
		addEventHandler: (GtPhlowListToSelectHandler new transformation: (GtPhlowSendTransformation object: [ :aTreeNode | aTreeNode value ]));
		when: GtPhlowObjectEvent do: [ :anEvent |
			"only visual elements can be selected in a theme editor"
			(anEvent object isKindOf: BlElement)
				ifTrue: [ self fireEvent: (CgtEditorSelectElementWish new element: anEvent object) ] ];
		nodeStencil: [ self newTreeRowElement ];
		nodeDataBinder: [ :eachLabel :eachElement | self bindElementTreeValue: eachElement toRowElement: eachLabel ];
		yourself
]

{ #category : 'instance creation' }
CgtEditor >> newPagerFor: aTargetContainer [
	^ BrVerticalPane new
		matchParent;
		constraintsDo: [ :c | c linear weight: 0.7 ];
		padding: (BlInsets
				top: 10
				left: 10
				bottom: 10
				right: 0);
		addAptitude: BrShadowAptitude new beLarge;
		background: self theme default backdropBackground;
		addChildren: {self newSectionLabel text: 'Details'.
				(GtPagerSettings usedPager
					createWrappedOn: (BrVerticalPane new
							matchParent;
							addChild: (BrLabel new
									aptitude: BrGlamorousLabelAptitude;
									hMatchParent;
									padding: (BlInsets
											top: 10.0
											right: 12.0
											bottom: 10.0
											left: 12.0);
									background: self theme header defaultBackgroundColor;
									text: 'Elements');
							addChild: (elementsTree := self newElementsTree)))
					id: '#bvc-themeEditor--pager'}
]

{ #category : 'instance creation' }
CgtEditor >> newSceneContainerFor: aTargetContainer [
	^ (sceneContainer := BrVerticalPane new)
		hMatchParent;
		vFitContent;
		constraintsDo: [ :c | c linear weight: 0.3 ];
		padding: (BlInsets all: 0);
		addChildren:
			{(scenePreviewElement := BlScalableElement new
				fitWidth;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical fitContent ];
				addAptitude:
					(BrShadowAptitude new beLarge
						color:
							self theme default defaultShadowColor darker);
				background: self theme default contentBackground;
				addChild: aTargetContainer;
				scale: 1.0 @ 1.0)}
]

{ #category : 'instance creation' }
CgtEditor >> newSectionLabel [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray)
]

{ #category : 'private - tree' }
CgtEditor >> newTreeRowElement [
	^ BrHorizontalPane new
		hMatchParent;
		vFitContent;
		alignCenterLeft;
		addChildren: {
			BrLabel new
				beSmallSize;
				id: #elementLabel;
				aptitude: BrGlamorousLabelAptitude new.
			BrButton new
				beTinySize;
				id: #elementId;
				aptitude: (BrGlamorousButtonLabelAptitude new
							hoveredColor: Color black;
							pressedColor: Color black) +
						(BrGlamorousButtonRectangularAptitude
							paddingScale: 0.8
							heightScale: 0.85
							cornerRadius: 3) + (BrStyleCommonAptitude new
					default: [ :s | s background: (Color gray alpha: 0.1) ];
					hovered: [ :s | s background: (Color gray alpha: 0.2) ];
					pressed: [ :s | s background: (Color gray alpha: 0.3) ]);
				action: [ :aButtonElement | aButtonElement phlow spawnObject: aButtonElement model ].
			BrLabel new
				beSmallSize;
				id: #elementResizers;
				aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray).
			BrButton new
				beTinySize;
				id: #phlowContext;
				aptitude: (BrGlamorousButtonLabelAptitude new
							hoveredColor: Color black;
							pressedColor: Color black) +
						(BrGlamorousButtonRectangularAptitude
							paddingScale: 0.8
							heightScale: 0.85
							cornerRadius: 3) + (BrStyleCommonAptitude new
					default: [ :s | s background: (Color gray alpha: 0.1) ];
					hovered: [ :s | s background: (Color gray alpha: 0.2) ];
					pressed: [ :s | s background: (Color gray alpha: 0.3) ]);
				action: [ :aButtonElement | aButtonElement phlow spawnObject: aButtonElement model ].
			BrButton new
				beTinySize;
				id: #whenAddedToSceneGraph;
				aptitude: (BrGlamorousButtonLabelAptitude new
							hoveredColor: Color black;
							pressedColor: Color black) +
						(BrGlamorousButtonRectangularAptitude
							paddingScale: 0.8
							heightScale: 0.85
							cornerRadius: 3) + (BrStyleCommonAptitude new
					default: [ :s | s background: (self theme  status failureBackgroundColor alpha: 0.6) ];
					hovered: [ :s | s background: (self theme  status failureBackgroundColor alpha: 0.8) ];
					pressed: [ :s | s background: (self theme  status failureBackgroundColor alpha: 1.0) ]);
				action: [ :aButtonElement | aButtonElement phlow spawnObject: aButtonElement model ] }
]

{ #category : 'accessing' }
CgtEditor >> detailsAnimationToken [
	^ detailsAnimationToken
]

{ #category : 'accessing' }
CgtEditor >> previewAnimationToken [
	^ previewAnimationToken
]

{ #category : 'accessing' }
CgtEditor >> openedDetailsWeight [
	^ 0.3
]

{ #category : 'accessing' }
CgtEditor >> previewScale [
	^ 0.9 @ 0.9
]

{ #category : 'accessing' }
CgtEditor >> previewScaleRecipricol [
	^ 1 @ 1 / self previewScale
]

{ #category : 'accessing' }
CgtEditor >> sceneWeight [
	| aLayoutConstraints |
	aLayoutConstraints := scenePage constraints.
	^ aLayoutConstraints linear weight
]

{ #category : 'accessing' }
CgtEditor >> selectElement: anElement [
	| wasNil |
	selectedElement == anElement ifTrue: [ ^ self ].
	wasNil := selectedElement isNil.
	selectedElement := anElement.
	elementsTree items: targetContainer children lazy: [ :each | each children ].
	selectedElement ifNil: [ ^ self ].
	elementsTree expandSuchThat: [ :aTreeNode | (selectedElement hasParent: aTreeNode value) or: [ selectedElement == aTreeNode value ] ].
	elementsTree selectAndScrollTo: selectedElement.
	elementsTree phlow spawnObject: selectedElement.
	wasNil ifTrue: [ isOpeningPreview ifFalse: [ self animateDetailsOpen ] ]
]


{ #category : 'testing' }
CgtEditor >> isAnimatingPreview [
	^ isOpeningPreview or: [ isClosingPreview ]
]

{ #category : 'testing' }
CgtEditor >> isClosingPreview [
	^ isClosingPreview
]

{ #category : 'accessing' }
CgtEditor >> targetContainer [
	^ targetContainer
]
