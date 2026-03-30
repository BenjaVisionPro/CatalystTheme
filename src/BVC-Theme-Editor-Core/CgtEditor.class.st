"
#Theme Editor
I am the main UI of the Theme Editor. I am responsible for composing the preview pane, the inspector, the style inspector popover, and the other visible editor pieces. I wire those pieces together and keep the interface synchronized with the current interaction state. I do not own the interaction rules themselves; that responsibility belongs to {{gtClass:CgtEditorInteractionState}}.
##More
See {{gtClass:CgtEditorEventHandler}} for adding me to a scene, {{gtClass:CgtEditorInteractionState}} for interaction semantics, and {{gtClass:CgtEditorOverlay}} for the overlay drawn over the preview.
"
Class {
	#name : 'CgtEditor',
	#superclass : 'BlElement',
	#instVars : [
		'targetContainer',
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
		'detailsWeightAnimation',
		'closeButton',
		'styleInspectorPopover',
		'interactionState'
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
	self selectedElement ifNil: [ ^ self ].
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
	interactionState := CgtEditorInteractionState new.
	self
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		layout: BlLinearLayout horizontal;
		background: self theme header defaultBackgroundColor
]
{ #category : 'initialization' }
CgtEditor >> initializeWith: aTargetContainer [
	^ self initializeWith: aTargetContainer interactionState: CgtEditorInteractionState new
]

{ #category : 'initialization' }
CgtEditor >> initializeWith: aTargetContainer interactionState: aCgtEditorInteractionState [
	targetContainer := aTargetContainer.
	interactionState := aCgtEditorInteractionState ifNil: [ CgtEditorInteractionState new ].

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
		(closeButton := self newCloseButtonFor: aTargetContainer) }.
	self updateCloseButtonOpacity
]
{ #category : 'accessing' }
CgtEditor >> inspectElement: anElement [
	self requestSelectionOf: anElement.
	elementsTree phlow spawnObject: anElement
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


{ #category : 'private - preview' }
CgtEditor >> detachPreviewChildren [
	| previewChildren |
	previewChildren := targetContainer children asArray.
	targetContainer removeChildren.
	^ previewChildren
]

{ #category : 'accessing' }
CgtEditor >> hoverIdleDurationMs [
	^ self overlayModel hoverIdleDurationMs
]

{ #category : 'accessing' }
CgtEditor >> previewExtent: anExtent [
	targetContainer size: anExtent
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

{ #category : 'private - selection' }
CgtEditor >> synchronizeSelectionInterfaceTo: anElement [
	elementsTree items: targetContainer children lazy: [ :each | each children ].
	anElement ifNil: [
		self hideStyleInspectorPopover.
		^ self ].
	elementsTree expandSuchThat: [ :aTreeNode | (anElement hasParent: aTreeNode value) or: [ anElement == aTreeNode value ] ].
	elementsTree selectAndScrollTo: anElement.
	self showStyleInspectorPopover.
	self updateStyleInspectorPopoverPosition
]
{ #category : 'private - selection' }
CgtEditor >> refreshSelectionInterface [
	self synchronizeSelectionInterfaceTo: self selectedElement
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
	^ 0.0
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
	presentationProgress := aNumber.
	self updateCloseButtonOpacity.
	self updateStyleInspectorPopoverPosition
]

{ #category : 'private - animation' }
CgtEditor >> previewScaleForProgress: aProgress [
	| aTargetScale |
	aTargetScale := self previewScale x.
	^ (1.0 - ((1.0 - aTargetScale) * aProgress)) @ (1.0 - ((1.0 - self previewScale y) * aProgress))
]



{ #category : 'private - animation' }
CgtEditor >> updateCloseButtonOpacity [
	closeButton ifNil: [ ^ self ].
	closeButton opacity: self presentationProgress
]



{ #category : 'private - style inspector' }
CgtEditor >> ensureStyleInspectorPopover [
	styleInspectorPopover ifNotNil: [ ^ styleInspectorPopover ].
	styleInspectorPopover := self newStyleInspectorPopover.
	self wireStyleInspectorPopover: styleInspectorPopover.
	self addChild: styleInspectorPopover.
	^ styleInspectorPopover
]

{ #category : 'private - style inspector' }
CgtEditor >> hideStyleInspectorPopover [
	styleInspectorPopover ifNil: [ ^ self ].
	styleInspectorPopover visibility: BlVisibility gone
]

{ #category : 'instance creation' }
CgtEditor >> newStyleInspectorPopover [
	^ CgtStyleInspectorPopover new
]

{ #category : 'private - style inspector' }
CgtEditor >> overlayBoundsForSelectedElement [
	| theCorners minX maxX minY maxY |
	self selectedElement ifNil: [ ^ nil ].
	theCorners := self selectedElement bounds inLocal bounds corners
		collect: [ :eachPoint | self localPointToGlobal: (self selectedElement localPointToGlobal: eachPoint) ].
	theCorners ifEmpty: [ ^ nil ].
	minX := maxX := theCorners first x.
	minY := maxY := theCorners first y.
	theCorners allButFirstDo: [ :eachPoint |
		minX := minX min: eachPoint x.
		maxX := maxX max: eachPoint x.
		minY := minY min: eachPoint y.
		maxY := maxY max: eachPoint y ].
	^ (minX @ minY) corner: (maxX @ maxY)
]

{ #category : 'private - style inspector' }
CgtEditor >> showStyleInspectorPopover [
	| aPopover aRule |
	self selectedElement ifNil: [ ^ self hideStyleInspectorPopover ].
	aPopover := self ensureStyleInspectorPopover.
	aRule := self styleRuleForStyleInspector.
	aPopover
		childWithId: #styleInspectorElementLabel
		ifFound: [ :aLabel | aLabel text: self selectedElement class name ]
		ifNone: [ ].
	aPopover styleRule: aRule.
	aPopover pathRootElement: self styleInspectorPathRootElement.
	aPopover elementPath: self styleInspectorElementPath.
	aPopover visibility: BlVisibility visible.
	self updateStyleInspectorPopoverPosition
]

{ #category : 'private - style inspector' }
CgtEditor >> styleRuleForStyleInspector [
	^ CgtThemeStyleRule fromElementPath: self styleInspectorElementPath
]

{ #category : 'private - style inspector' }
CgtEditor >> styleInspectorElementPath [
	^ self selectedElementPath ifNil: [ self selectedElement ifNil: [ nil ] ifNotNil: [ CgtElementPath anchorElement: self selectedElement ] ]
]


{ #category : 'private - style inspector' }
CgtEditor >> styleInspectorPathRootElement [
	| current stopParent |
	self selectedElement ifNil: [ ^ nil ].
	stopParent := targetContainer.
	current := self selectedElement.
	[ current parent notNil and: [ current parent ~= stopParent ] ] whileTrue: [
		current := current parent ].
	^ current
]
{ #category : 'private - style inspector' }
CgtEditor >> updateStyleInspectorPopoverPosition [
	| aBounds aPopover popoverWidth margin left top availableWidth availableHeight |
	(styleInspectorPopover isNil or: [ self selectedElement isNil ]) ifTrue: [ ^ self ].
	aBounds := self overlayBoundsForSelectedElement.
	aBounds ifNil: [ ^ self ].
	aPopover := styleInspectorPopover.
	popoverWidth := 560.
	margin := 12.
	availableWidth := self bounds inLocal width.
	availableHeight := self bounds inLocal height.
	left := aBounds right + margin.
	(left + popoverWidth > availableWidth and: [ aBounds left - margin - popoverWidth >= 0 ])
		ifTrue: [ left := aBounds left - margin - popoverWidth ].
	left := (left max: 0) min: ((availableWidth - popoverWidth) max: 0).
	top := (aBounds top max: 0) min: ((availableHeight - 120) max: 0).
	aPopover constraintsDo: [ :c |
		c ignoreByLayout.
		c ignored horizontal alignLeft.
		c ignored vertical alignTop.
		c margin: (BlInsets top: top left: left bottom: 0 right: 0) ].
	aPopover width: popoverWidth.
	aPopover requestLayout
]





{ #category : 'private - style inspector' }
CgtEditor >> wireStyleInspectorPopover: aStyleInspectorPopover [
	| aSelectorWidget |
	aSelectorWidget := aStyleInspectorPopover selectorWidget.
	aSelectorWidget when: CgtElementPathNodeSelectedEvent do: [ :anEvent |
		self elementPathNodeSelectedEvent: anEvent ].
	aSelectorWidget when: CgtElementPathNodeHoveredEvent do: [ :anEvent |
		self elementPathNodeHoveredEvent: anEvent ].
	aSelectorWidget when: CgtElementPathNodeUnhoveredEvent do: [ :anEvent |
		self elementPathNodeUnhoveredEvent: anEvent ]
]

{ #category : 'event handling - style inspector' }
CgtEditor >> elementPathNodeHoveredEvent: anEvent [
	self beginHoverTracking.
	(interactionState pathWidgetHoveredElement: anEvent element)
		ifTrue: [ self refreshOverlayState ]
]
{ #category : 'event handling - style inspector' }
CgtEditor >> elementPathNodeUnhoveredEvent: anEvent [
	| didClear |
	didClear := interactionState clearPathWidgetHover.
	didClear ifTrue: [ self refreshOverlayState ].
	(didClear and: [ interactionState hasPreviewHover not ]) ifTrue: [ self endHoverTracking ]
]
{ #category : 'event handling - style inspector' }
CgtEditor >> elementPathNodeSelectedEvent: anEvent [
	self applySelectionInteractionWith: anEvent element
]

{ #category : 'private - overlay' }
CgtEditor >> withOverlayDo: aBlock [
	self overlayContainer
		childWithId: CgtEditorEventHandler themeEditorOverlayId
		ifFound: aBlock
		ifNone: [ ]
]

{ #category : 'private - overlay' }
CgtEditor >> refreshOverlayState [
	self withOverlayDo: [ :anOverlay |
		anOverlay hoverElement: interactionState effectiveHoverElement.
		anOverlay stateChanged ]
]

{ #category : 'private - interface refresh' }
CgtEditor >> refreshInterfaceFromCurrentPreviewHover: anElement [
	self refreshInterfaceFromInteractionState.
	self refreshPreviewHoverWith: anElement
]

{ #category : 'private - overlay' }
CgtEditor >> refreshInterfaceFromInteractionState [
	self refreshSelectionInterface.
	self refreshOverlayState
]
{ #category : 'event handling - preview' }
CgtEditor >> beginHoverTracking [
	self withOverlayDo: [ :anOverlay | anOverlay beginHoverTracking ]
]

{ #category : 'event handling - preview' }
CgtEditor >> endHoverTracking [
	interactionState hasPathWidgetHover ifTrue: [ ^ self ].
	self withOverlayDo: [ :anOverlay | anOverlay endHoverTracking ]
]
{ #category : 'private - hover' }
CgtEditor >> setPreviewHoverElement: anElement [
	(interactionState setPreviewHoverElement: anElement)
		ifTrue: [ self refreshOverlayState ]
]
{ #category : 'event handling - preview' }
CgtEditor >> previewHoveredElement: anElement [
	self beginHoverTracking.
	self setPreviewHoverElement: anElement
]

{ #category : 'event handling - preview' }
CgtEditor >> clearPreviewHover [
	(interactionState clearPreviewHover)
		ifTrue: [ self refreshOverlayState ]
]

{ #category : 'private - preview' }
CgtEditor >> refreshPreviewHoverWith: anElement [
	anElement
		ifNil: [ self clearPreviewHover ]
		ifNotNil: [ self previewHoveredElement: anElement ]
]

{ #category : 'event handling - external' }
CgtEditor >> highlightedElement: anElement [
	(interactionState highlightedElement: anElement)
		ifTrue: [ self refreshOverlayState ]
]
{ #category : 'event handling - external' }
CgtEditor >> clearHighlightedElement [
	(interactionState clearHighlightedElement)
		ifTrue: [ self refreshOverlayState ]
]
{ #category : 'event handling - external' }
CgtEditor >> requestSelectionOf: anElement [
	(interactionState requestSelectionOf: anElement)
		ifTrue: [ self synchronizeSelectionInterfaceFromInteractionState ]
]
{ #category : 'event handling - preview' }
CgtEditor >> previewClickedElement: anElement [
	self applySelectionInteractionWith: anElement
]

{ #category : 'private - selection' }
CgtEditor >> synchronizeSelectionInterfaceFromInteractionState [
	interactionState refreshSelectionState.
	self refreshSelectionInterface.
	self refreshOverlayState
]
{ #category : 'private - selection' }
CgtEditor >> applySelectionInteractionWith: anElement [
	(interactionState applySelectionInteractionWith: anElement)
		ifTrue: [ self synchronizeSelectionInterfaceFromInteractionState ]
]
{ #category : 'accessing' }
CgtEditor >> styleInspectorPopover [
	^ styleInspectorPopover
]


{ #category : 'accessing' }
CgtEditor >> selectedElement [
	^ interactionState selectedElement
]
{ #category : 'accessing' }
CgtEditor >> interactionState [
	^ interactionState
]
{ #category : 'accessing' }
CgtEditor >> selectedElementPath [
	^ interactionState selectedElementPath
]
{ #category : 'accessing' }
CgtEditor >> sceneContainer [
	^ sceneContainer
]

{ #category : 'accessing' }
CgtEditor >> overlayContainer [
	^ scenePage
]

{ #category : 'accessing' }
CgtEditor >> overlayModel [
	^ interactionState overlayModel
]
{ #category : 'accessing' }
CgtEditor >> targetContainer [
	^ targetContainer
]



