"
#Theme Editor Event Handler
Is used to add support of the `Theme Editor` to arbitrary elements. For the best result the element to which the `Theme Editor` is added should have a {{gtClass:BlBasicLayout}} and have `matchParent` or `exact` layout resizing strategy.
##Usage
Press `control-option-tab` to toggle the `Theme Editor` open and closed.
##More
See {{gtClass:CgtEditor}} for the main UI of the `Theme Editor` and {{gtClass:CgtEditorOverlay}} for an overlay over the scene that shows highlighted and selected elements.

A script to create an element with a theme editor opened and a selected child element:
```
world := GtWorldElement new
	addEventHandler: CgtEditorEventHandler new.

world fireEvent: (CgtEditorShowWish new
	elementToSelect: world children first children first;
	sceneExtent: 800@600).
world
```

"
Class {
	#name : 'CgtEditorEventHandler',
	#superclass : 'BlCustomEventHandler',
	#instVars : [
		'mousePosition',
		'hasThemeEditor',
		'elementToHighlight',
		'elementToSelect',
		'shouldLockOverlay',
		'hasOverlay',
		'originalTitle',
		'overlayModel',
		'transitionToken',
		'desiredThemeEditorOpen',
		'isTransitioningThemeEditor',
		'hoverIdleToken'
	],
	#classVars : [
		'KeyCombination',
		'ThemeEditorId',
		'ThemeEditorOverlayId'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'class initialization' }
CgtEditorEventHandler class >> initialize [
	ThemeEditorId := #'bvc-themeEditor'.
	ThemeEditorOverlayId := BlElementId named: #'bvc-themeEditor--preview'.
	KeyCombination := BlKeyCombination builder control alt tab build
]



{ #category : 'accessing' }
CgtEditorEventHandler class >> themeEditorId [
	^ ThemeEditorId
]

{ #category : 'accessing' }
CgtEditorEventHandler class >> themeEditorOverlayId [
	^ ThemeEditorOverlayId
]

{ #category : 'private - accessing' }
CgtEditorEventHandler >> childToThemeAt: aPoint in: aTargetElement ifFound: aFoundBlock ifNone: aNoneBlock [
	| theChildrenAt |
	theChildrenAt := aTargetElement withAllLeafChildrenAt: aPoint.
	
	hasOverlay
		ifTrue: [
			self
				themeEditorOverlayIn: aTargetElement
				do: [ :aThemeEditorOverlay | theChildrenAt := theChildrenAt reject: [ :each | each == aThemeEditorOverlay or: [ each hasParent: aThemeEditorOverlay ] ] ] ].

	theChildrenAt := theChildrenAt sorted: [ :a :b | a compositionDepth > b compositionDepth ].
	theChildrenAt ifEmpty: [ ^ aNoneBlock value ].

	^ aFoundBlock value: theChildrenAt first
]


{ #category : 'private - preview' }
CgtEditorEventHandler >> previewElementAt: aPoint in: aRootElement [
	| aThemeEditorTarget |
	aThemeEditorTarget := self themeEditorTargetIn: aRootElement.
	^ self
		childToThemeAt: (aThemeEditorTarget globalPointToLocal: (aRootElement localPointToGlobal: aPoint))
		in: aThemeEditorTarget
		ifFound: #yourself
		ifNone: [ nil ]
]

{ #category : 'event handling' }
CgtEditorEventHandler >> clickEvent: aClickEvent [
	| aThemeEditorTarget aHoveredElement |

	hasOverlay ifFalse: [ ^ self ].
	(self isPointInsideVisibleStyleInspector: aClickEvent position in: aClickEvent currentTarget)
		ifTrue: [ ^ self ].

	aThemeEditorTarget := self themeEditorTargetIn: aClickEvent currentTarget.
	(aThemeEditorTarget containsGlobalPoint: aClickEvent position)
		ifFalse: [ ^ self ].

	aHoveredElement := self previewElementAt: aClickEvent localPosition in: aClickEvent currentTarget.

	self
		themeEditorIn: aClickEvent currentTarget
		do: [ :aThemeEditor | aThemeEditor previewClickedElement: aHoveredElement ].
	aClickEvent consumed: true
]

{ #category : 'api - accessing' }
CgtEditorEventHandler >> eventsToHandle [
	^ {
		CgtEditorShowWish.
		CgtEditorHideWish.
		CgtEditorHighlightElementWish.
		CgtEditorHideHighlightWish.
		CgtEditorSelectElementWish.
		BlKeyDownEvent.
		BlKeyUpEvent.
		BlMouseMoveEvent.
		BlClickEvent
	}
]

{ #category : 'event handling' }
CgtEditorEventHandler >> hideHighlightEvent: aHideHighlightEvent [
	self
		highlightElement: nil
		in: aHideHighlightEvent currentTarget
]

{ #category : 'api - overlay' }
CgtEditorEventHandler >> hideOverlayIn: aRootElement [
	hasOverlay
		ifFalse: [ ^ self ].

	hasOverlay := false.
	self
		themeEditorOverlayIn: aRootElement
		do: [ :anOverlay |
			anOverlay preventMeAndChildrenMouseEvents.
			anOverlay animateFadeOutOnFinishedDo: [ | anOverlayParent |
				anOverlayParent := anOverlay parent.
				anOverlayParent ifNotNil: [
					anOverlayParent
						childWithId: ThemeEditorOverlayId
						ifFound: [ :currentOverlay | currentOverlay == anOverlay ifTrue: [ anOverlayParent removeChild: currentOverlay ] ]
						ifNone: [ ] ] ] ]
]

{ #category : 'api - themeEditor' }
CgtEditorEventHandler >> hideThemeEditor: aRootElement [
	| aToken |
	hasThemeEditor ifFalse: [ ^ self ].
	isTransitioningThemeEditor := true.
	desiredThemeEditorOpen := false.
	aToken := self nextTransitionToken.
	self hideOverlayIn: aRootElement.
	(aRootElement isAttachedToSceneGraph and: [ originalTitle notNil ])
		ifTrue: [ aRootElement space title: originalTitle ].

	originalTitle := nil.
	
	aRootElement
		childWithId: ThemeEditorId
		ifFound: [ :aThemeEditor | 
			aThemeEditor
				animateCloseOnFinishedDo: [ | aTargetElementChildren |
					transitionToken = aToken ifTrue: [
						self unlockOverlay.
						self selectElement: nil in: aRootElement.
						self highlightElement: nil in: aRootElement.
						hasThemeEditor := false.
						aTargetElementChildren := aThemeEditor targetContainer children asArray.
						aThemeEditor targetContainer removeChildren.
						aRootElement removeChildren.
						aRootElement addChildren: aTargetElementChildren.
						aRootElement
							withAllChildrenBreadthFirstDo: [ :eachChild | eachChild boundsCache invalidateBoundsInSpace ].
						isTransitioningThemeEditor := false.
						self processRequestedThemeEditorStateIn: aRootElement ] ] ]
		ifNone: [
			isTransitioningThemeEditor := false.
			^ self ]
]

{ #category : 'event handling' }
CgtEditorEventHandler >> hideThemeEditorEvent: aHideThemeEditorEvent [
	self hideThemeEditor: aHideThemeEditorEvent currentTarget
]

{ #category : 'private - testing' }
CgtEditorEventHandler >> highlightCombinationMatchesIn: aRootElement [
	<return: #Boolean>

	aRootElement isAttachedToSceneGraph
		ifFalse: [ ^ false ].

	^ KeyCombination matchesKeyBuffer: aRootElement space keyboardProcessor buffer
]

{ #category : 'api - overlay' }
CgtEditorEventHandler >> highlightElement: anElement in: aRootElement [
	elementToHighlight := anElement.
	self
		themeEditorIn: aRootElement
		do: [ :aThemeEditor | aThemeEditor highlightedElement: anElement ]
]

{ #category : 'api - overlay' }
CgtEditorEventHandler >> highlightElementAt: aPoint in: aRootElement [
	| aHoveredElement |

	mousePosition := aPoint.
	elementToHighlight := nil.

	hasOverlay
		ifFalse: [ ^ self ].

	aHoveredElement := self previewElementAt: aPoint in: aRootElement.

	self
		themeEditorIn: aRootElement
		do: [ :aThemeEditor | aThemeEditor previewHoverMovedOver: aHoveredElement ]
]

{ #category : 'event handling' }
CgtEditorEventHandler >> highlightElementEvent: aHighlightElementEvent [
	self
		highlightElement: aHighlightElementEvent element
		in: aHighlightElementEvent currentTarget
]

{ #category : 'initialization' }
CgtEditorEventHandler >> initialize [
	super initialize.
	
	mousePosition := 0@0.
	hasOverlay := false.
	hasThemeEditor := false.
	shouldLockOverlay := false.
	elementToHighlight := nil.
	elementToSelect := nil.
	overlayModel := CgtViewTreeOverlayModel new.
	transitionToken := 0.
	desiredThemeEditorOpen := false.
	isTransitioningThemeEditor := false.
	hoverIdleToken := 0
]


{ #category : 'private - themeEditor' }
CgtEditorEventHandler >> desiredThemeEditorOpenValue [
	^ desiredThemeEditorOpen ifNil: [ false ]
]

{ #category : 'private - themeEditor' }
CgtEditorEventHandler >> isTransitioningThemeEditorValue [
	^ isTransitioningThemeEditor ifNil: [ false ]
]

{ #category : 'event handling' }
CgtEditorEventHandler >> keyDownEvent: aKeyDownEvent [
	(self highlightCombinationMatchesIn: aKeyDownEvent currentTarget)
		ifFalse: [ ^ self ].

	desiredThemeEditorOpen := self desiredThemeEditorOpenValue not.
	self processRequestedThemeEditorStateIn: aKeyDownEvent currentTarget.
	aKeyDownEvent consumed: true
]

{ #category : 'event handling' }
CgtEditorEventHandler >> keyEvent: aKeyEvent [
	^ self
]

{ #category : 'event handling' }
CgtEditorEventHandler >> keyUpEvent: aKeyDownEvent [
	^ self
]

{ #category : 'api - overlay' }
CgtEditorEventHandler >> lockOverlay [
	shouldLockOverlay := true
]

{ #category : 'api - overlay' }
CgtEditorEventHandler >> maybeHideOverlayIn: aRootElement [
	hasOverlay
		ifFalse: [ ^ self ].
	
	self themeEditorOverlayIn: aRootElement do: [ :anOverlay | anOverlay preventMeAndChildrenMouseEvents ].
		
	shouldLockOverlay
		ifTrue: [
			self highlightElement: elementToHighlight in: aRootElement.
			^ self ].

	aRootElement isAttachedToSceneGraph
		ifFalse: [ ^ self hideOverlayIn: aRootElement ].

	"only hide if the wrong combination is pressed"
	(KeyCombination matchesKeyBuffer: aRootElement space keyboardProcessor buffer)
		ifFalse: [ self hideOverlayIn: aRootElement ]
]


{ #category : 'private - themeEditor' }
CgtEditorEventHandler >> nextTransitionToken [
	transitionToken := (transitionToken ifNil: [ 0 ]) + 1.
	^ transitionToken
]

{ #category : 'private - themeEditor' }
CgtEditorEventHandler >> shouldStartClosingThemeEditorIn: aRootElement [
	self
		themeEditorIn: aRootElement
		do: [ :aThemeEditor | ^ aThemeEditor isClosingPreview not ].

	^ true
]

{ #category : 'private - themeEditor' }
CgtEditorEventHandler >> shouldStartOpeningThemeEditorIn: aRootElement [
	self
		themeEditorIn: aRootElement
		do: [ :aThemeEditor | ^ aThemeEditor isClosingPreview ].

	^ true
]

{ #category : 'private - themeEditor' }
CgtEditorEventHandler >> processRequestedThemeEditorStateIn: aRootElement [
	self desiredThemeEditorOpenValue
		ifTrue: [
			hasThemeEditor
				ifFalse: [ ^ self showThemeEditor: aRootElement ].
				(self shouldStartOpeningThemeEditorIn: aRootElement)
					ifTrue: [ ^ self showThemeEditor: aRootElement ].
				^ self ].
	hasThemeEditor
		ifTrue: [
			(self shouldStartClosingThemeEditorIn: aRootElement)
				ifTrue: [ ^ self hideThemeEditor: aRootElement ] ]
]

{ #category : 'private - themeEditor' }
CgtEditorEventHandler >> refreshEditorStateIn: aRootElement [
	| aPreviewHoveredElement |
	aPreviewHoveredElement := nil.
	(elementToHighlight isNil and: [ mousePosition notNil ])
		ifTrue: [ aPreviewHoveredElement := self previewElementAt: mousePosition in: aRootElement ].
	self
		themeEditorIn: aRootElement
		do: [ :aThemeEditor |
			aThemeEditor
				restoreInteractionStateSelection: elementToSelect
				highlighted: elementToHighlight
				previewHovered: aPreviewHoveredElement ]
]

{ #category : 'event handling' }
CgtEditorEventHandler >> mouseMoveEvent: aMouseMoveEvent [
	| aThemeEditorTarget aHoveredElement isInsidePreview isInsideInspector |
	
	hasOverlay
		ifFalse: [
			mousePosition := aMouseMoveEvent localPosition.
			elementToHighlight := nil.
			^ self ].
	
	aThemeEditorTarget := self themeEditorTargetIn: aMouseMoveEvent currentTarget.
	isInsideInspector := self isPointInsideVisibleStyleInspector: aMouseMoveEvent position in: aMouseMoveEvent currentTarget.
	isInsidePreview := aThemeEditorTarget containsGlobalPoint: aMouseMoveEvent position.
	(isInsidePreview and: [ isInsideInspector not ])
		ifTrue: [
			aHoveredElement := self previewElementAt: aMouseMoveEvent localPosition in: aMouseMoveEvent currentTarget.
			self noteTrackableHoverActivityIn: aMouseMoveEvent currentTarget.
			self
				themeEditorIn: aMouseMoveEvent currentTarget
				do: [ :aThemeEditor | aThemeEditor previewHoveredElement: aHoveredElement ] ]
		ifFalse: [
			mousePosition := nil.
			(elementToHighlight notNil and: [ isInsideInspector ])
				ifFalse: [
					self
						themeEditorIn: aMouseMoveEvent currentTarget
						do: [ :aThemeEditor | aThemeEditor clearPreviewHover ] ] ]
]



{ #category : 'event handling' }
CgtEditorEventHandler >> isPointInsideVisibleStyleInspector: aGlobalPoint in: aRootElement [
	| isInside |
	isInside := false.
	self
		themeEditorIn: aRootElement
		do: [ :anEditor |
			| aPopover |
			(anEditor respondsTo: #styleInspectorPopover)
				ifTrue: [
					aPopover := anEditor styleInspectorPopover.
					(aPopover notNil and: [ aPopover visibility = BlVisibility visible ])
						ifTrue: [ isInside := aPopover containsGlobalPoint: aGlobalPoint ] ] ].
	^ isInside
]

{ #category : 'api - overlay' }
CgtEditorEventHandler >> selectElement: anElement in: aRootElement [
	elementToSelect := anElement.
	self
		themeEditorIn: aRootElement
		do: [ :aThemeEditor | aThemeEditor requestSelectionOf: anElement ]
]

{ #category : 'event handling' }
CgtEditorEventHandler >> selectElementEvent: aSelectElementEvent [
	self
		selectElement: aSelectElementEvent element
		in: aSelectElementEvent currentTarget
]

{ #category : 'api - overlay' }
CgtEditorEventHandler >> showOverlayIn: aRootElement [
	self themeEditorOverlayIn: aRootElement do: [ :anOverlay |
		hasOverlay := true.
		anOverlay allowMeAndChildrenMouseEvents.
		anOverlay animateFadeIn.
		self refreshEditorStateIn: aRootElement.
		^ self ].

	hasOverlay := true.

	self
		themeEditorIn: aRootElement
		do: [ :aThemeEditor |
			(self themeEditorOverlayHostIn: aRootElement)
				addChild: (CgtEditorOverlay new
					id: ThemeEditorOverlayId;
					state: aThemeEditor overlayModel;
					overlayOpacity: 0.0;
					allowMeAndChildrenMouseEvents;
					animateFadeIn;
					yourself) ].

	self refreshEditorStateIn: aRootElement
]

{ #category : 'api - themeEditor' }
CgtEditorEventHandler >> showThemeEditor: aRootElement [
	| aTargetElementChildren aTargetContainer aToken |

	desiredThemeEditorOpen := true.
	aToken := self nextTransitionToken.
	isTransitioningThemeEditor := true.
	self lockOverlay.

	hasThemeEditor
		ifTrue: [
			self showOverlayIn: aRootElement.
			self
				themeEditorIn: aRootElement
				do: [ :aThemeEditor |
					aThemeEditor animateOpenOnFinishedDo: [
						transitionToken = aToken ifTrue: [
							isTransitioningThemeEditor := false.
							self processRequestedThemeEditorStateIn: aRootElement ] ] ].
			^ self ].

	aRootElement isAttachedToSceneGraph
		ifTrue: [
			originalTitle := aRootElement space title.
			aRootElement space title: 'Catalyst Theme Editor' ].

	hasThemeEditor := true.

	aTargetElementChildren := aRootElement children asArray.
	aRootElement removeChildren.

	aTargetContainer := BlElement new.
	aTargetContainer size: aRootElement extent.
	aTargetContainer addChildren: aTargetElementChildren.

	aRootElement addChild: (CgtEditor new initializeWith: aTargetContainer overlayModel: overlayModel) as: ThemeEditorId.
	self showOverlayIn: aRootElement.
	self
		themeEditorIn: aRootElement
		do: [ :aThemeEditor |
			aThemeEditor animateOpenOnFinishedDo: [
				transitionToken = aToken ifTrue: [
					isTransitioningThemeEditor := false.
					self processRequestedThemeEditorStateIn: aRootElement ] ] ]
]

{ #category : 'event handling' }
CgtEditorEventHandler >> showThemeEditorEvent: aShowThemeEditorEvent [
	aShowThemeEditorEvent consumed: true.

	self showThemeEditor: aShowThemeEditorEvent currentTarget.
	self
		themeEditorIn: aShowThemeEditorEvent currentTarget
		do: [ :aThemeEditor |
			aShowThemeEditorEvent elementToSelect
				ifNotNil: [ aThemeEditor requestSelectionOf: aShowThemeEditorEvent elementToSelect ].
			aShowThemeEditorEvent sceneExtent
				ifNotNil: [ aThemeEditor targetContainer size: aShowThemeEditorEvent sceneExtent ] ]
]

{ #category : 'private - accessing' }
CgtEditorEventHandler >> themeEditorIn: aTargetElement do: aBlock [
	| current |
	current := aTargetElement.
	[ current notNil ] whileTrue: [
		(current id = ThemeEditorId)
			ifTrue: [ ^ aBlock value: current ].
		current
			childWithId: ThemeEditorId
			ifFound: [ :anEditor | ^ aBlock value: anEditor ]
			ifNone: [  ].
		current := current parent ].
]

{ #category : 'private - accessing' }
CgtEditorEventHandler >> themeEditorOverlayHostIn: aRootElement [
	self
		themeEditorIn: aRootElement
		do: [ :aThemeEditor | ^ aThemeEditor overlayContainer ].

	^ aRootElement
]

{ #category : 'private - accessing' }
CgtEditorEventHandler >> themeEditorOverlayIn: aRootElement do: aBlock [
	(self themeEditorOverlayHostIn: aRootElement)
		childWithId: ThemeEditorOverlayId
		ifFound: aBlock
		ifNone: [  ]
]

{ #category : 'private - accessing' }
CgtEditorEventHandler >> themeEditorTargetIn: aRootElement [
	self
		themeEditorIn: aRootElement
		do: [ :aThemeEditor | ^ aThemeEditor targetContainer ].
		
	^ aRootElement
]

{ #category : 'api - overlay' }
CgtEditorEventHandler >> unlockOverlay [
	shouldLockOverlay := false
]

{ #category : 'private - hover tracking' }
CgtEditorEventHandler >> noteTrackableHoverActivityIn: aRootElement [
	| aToken aIdleDuration |
	hoverIdleToken := (hoverIdleToken ifNil: [ 0 ]) + 1.
	aToken := hoverIdleToken.
	aIdleDuration := overlayModel hoverIdleDurationMs.
	self themeEditorIn: aRootElement do: [ :aThemeEditor |
		aIdleDuration := aThemeEditor overlayModel hoverIdleDurationMs ].
	[
		(Delay forMilliseconds: aIdleDuration) wait.
		hoverIdleToken = aToken ifTrue: [
			self themeEditorIn: aRootElement do: [ :aThemeEditor | aThemeEditor endHoverTracking ] ]
	] forkAt: Processor userBackgroundPriority
]







