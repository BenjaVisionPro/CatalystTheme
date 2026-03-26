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
		'presentationProgress',
		'previewTransformAnimation',
		'previewProgressAnimation',
		'detailsWeightAnimation'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'api - animation' }
CgtEditor >> animateCloseOnFinishedDo: aBlock [
	self
		animatePreviewProgressTo: 0.0
		detailsWeightTo: 0.0
		onFinishedDo: aBlock
]

{ #category : 'api - animation' }
CgtEditor >> animateDetailsOpen [
	selectedElement ifNil: [ ^ self ].
	self detailsWeight >= self openedDetailsWeight ifTrue: [ ^ self ].
	self
		animatePreviewProgressTo: self presentationProgress
		detailsWeightTo: self openedDetailsWeight
		onFinishedDo: [ ]
]

{ #category : 'api - animation' }
CgtEditor >> animateOpen [
	self animateOpenOnFinishedDo: [ ]
]

{ #category : 'api - animation' }
CgtEditor >> animateOpenOnFinishedDo: aBlock [
	self
		animatePreviewProgressTo: 1.0
		detailsWeightTo: self detailsTargetWeightForOpening
		onFinishedDo: aBlock
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
	| aToken aDuration |
	detailsAnimationToken := (detailsAnimationToken ifNil: [ 0 ]) + 1.
	aToken := detailsAnimationToken.
	detailsWeightAnimation ifNotNil: [ detailsWeightAnimation stopIfRunning ].
	aDuration := self durationForProgressDistance: (aWeight - self detailsWeight) abs.
	((aWeight - self detailsWeight) abs <= 0.0001 or: [ aDuration <= 0 milliSeconds ])
		ifTrue: [
			self detailsWeight: aWeight.
			^ aBlock value ].
	detailsWeightAnimation := BlNumberTransition new
		from: self detailsWeight;
		to: aWeight;
		duration: aDuration;
		easing: CgtFastInSlowOutEasing new;
		onStepDo: [ :eachWeight :anEditor |
			anEditor detailsAnimationToken = aToken
				ifTrue: [ anEditor detailsWeight: eachWeight ] ];
		onFinishedDo: [
			self detailsAnimationToken = aToken ifTrue: [
				detailsWeightAnimation := nil.
				aBlock value ] ];
		yourself.
	self addAnimation: detailsWeightAnimation
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
	presentationProgress := 0.0.
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
				addChild: aTargetContainer)}
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

{ #category : 'private - animation' }
CgtEditor >> animatePreviewProgressTo: aPreviewProgress detailsWeightTo: aDetailsWeight onFinishedDo: aBlock [
	| aToken aDuration aTargetScale |
	aToken := (previewAnimationToken ifNil: [ 0 ]) + 1.
	previewAnimationToken := aToken.
	previewTransformAnimation ifNotNil: [ previewTransformAnimation stopIfRunning ].
	previewProgressAnimation ifNotNil: [ previewProgressAnimation stopIfRunning ].
	isOpeningPreview := aPreviewProgress > self presentationProgress.
	isClosingPreview := aPreviewProgress < self presentationProgress.
	self animateDetailsWeightTo: aDetailsWeight onFinishedDo: [ ].
	aDuration := self durationForProgressDistance: (aPreviewProgress - self presentationProgress) abs.
	((aPreviewProgress - self presentationProgress) abs <= 0.0001 or: [ scenePreviewElement isNil ])
		ifTrue: [
			presentationProgress := aPreviewProgress.
			isOpeningPreview := false.
			isClosingPreview := false.
			^ aBlock value ].
	aTargetScale := self previewScaleForProgress: aPreviewProgress.
	previewProgressAnimation := BlNumberTransition new
		from: self presentationProgress;
		to: aPreviewProgress;
		duration: aDuration;
		easing: CgtFastInSlowOutEasing new;
		onStepDo: [ :eachProgress :anEditor |
			anEditor previewAnimationToken = aToken
				ifTrue: [ anEditor presentationProgress: eachProgress ] ];
		onFinishedDo: [
			self previewAnimationToken = aToken ifTrue: [
				previewProgressAnimation := nil ] ];
		yourself.
	previewTransformAnimation := BlTransformAnimation new
		absolute;
		transformDo: [ :aBuilder | aBuilder scaleBy: aTargetScale ];
		duration: aDuration;
		easing: CgtFastInSlowOutEasing new;
		onFinishedDo: [
			self previewAnimationToken = aToken ifTrue: [
				previewTransformAnimation := nil.
				presentationProgress := aPreviewProgress.
				isOpeningPreview := false.
				isClosingPreview := false.
				aBlock value ] ];
		yourself.
	self addAnimation: previewProgressAnimation.
	scenePreviewElement addAnimation: previewTransformAnimation
]

{ #category : 'accessing' }
CgtEditor >> detailsTargetWeightForOpening [
	^ selectedElement
		ifNil: [ 0.0 ]
		ifNotNil: [ self openedDetailsWeight ]
]

{ #category : 'private - animation' }
CgtEditor >> durationForProgressDistance: aDistance [
	^ ((1500.0 * aDistance) rounded max: 1) milliSeconds
]

{ #category : 'accessing' }
CgtEditor >> presentationProgress [
	^ presentationProgress ifNil: [ 0.0 ]
]

{ #category : 'accessing' }
CgtEditor >> presentationProgress: aNumber [
	presentationProgress := aNumber
]

{ #category : 'private - animation' }
CgtEditor >> previewScaleForProgress: aProgress [
	| aTargetScale |
	aTargetScale := self previewScale x.
	^ (1.0 - ((1.0 - aTargetScale) * aProgress)) @ (1.0 - ((1.0 - self previewScale y) * aProgress))
]

{ #category : 'accessing' }
CgtEditor >> targetContainer [
	^ targetContainer
]
