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
		'overlayState',
		'transitionToken',
		'desiredThemeEditorOpen',
		'isTransitioningThemeEditor'
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

{ #category : 'private - accessing' }
CgtEditorEventHandler >> childToThemeAt: aPoint in: aTargetElement ifFound: aFoundBlock ifNone: aNoneBlock [
	| theChildrenAt |
	theChildrenAt := aTargetElement withAllLeafChildrenAt: aPoint.
	
	hasOverlay
		ifTrue: [
			self
				themeEditorOverlayIn: aTargetElement
				do: [ :aThemeEditorOverlay | theChildrenAt := theChildrenAt copyWithout: self ] ].

	theChildrenAt := theChildrenAt sorted: [ :a :b | a compositionDepth > b compositionDepth ].
	theChildrenAt ifEmpty: [ ^ aNoneBlock value ].

	^ aFoundBlock value: theChildrenAt first
]

{ #category : 'event handling' }
CgtEditorEventHandler >> clickEvent: aClickEvent [
	| aThemeEditorTarget aHoveredElement |

	hasOverlay
		ifFalse: [ ^ self ].

	aThemeEditorTarget := self themeEditorTargetIn: aClickEvent currentTarget.
	(aThemeEditorTarget containsGlobalPoint: aClickEvent position)
		ifFalse: [ ^ self ].

	aHoveredElement := self
		childToThemeAt: aClickEvent localPosition
		in: aClickEvent currentTarget
		ifFound: #yourself
		ifNone: [ nil ].

	self highlightElement: aHoveredElement in: aClickEvent currentTarget.
	self
		themeEditorOverlayIn: aClickEvent currentTarget
		do: [ :anOverlay |
			anOverlay clickHoverElement.
			self selectElement: anOverlay selectedElement in: aClickEvent currentTarget ]
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
			anOverlay animateFadeOutOnFinishedDo: [
				aRootElement
					childWithId: ThemeEditorOverlayId
					ifFound: [ :currentOverlay | currentOverlay == anOverlay ifTrue: [ aRootElement removeChild: currentOverlay ] ]
					ifNone: [ ] ] ]
]

{ #category : 'api - themeEditor' }
CgtEditorEventHandler >> hideThemeEditor: aRootElement [
	| aToken |
	hasThemeEditor ifFalse: [ ^ self ].
	self isTransitioningThemeEditorValue ifTrue: [ ^ self ].
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
	overlayState hoverElement: anElement.
	self themeEditorOverlayIn: aRootElement do: [ :anOverlay | anOverlay hoverElement: anElement ]
]

{ #category : 'api - overlay' }
CgtEditorEventHandler >> highlightElementAt: aPoint in: aRootElement [
	| aThemeEditorTarget |

	mousePosition := aPoint.
	"moving mouse inside of the theme editor target resets the explicit element to highlight"
	elementToHighlight := nil.

	hasOverlay
		ifFalse: [ ^ self ].

	(self highlightCombinationMatchesIn: aRootElement)
		ifFalse: [ ^ self ].

	aThemeEditorTarget := self themeEditorTargetIn: aRootElement.
	
	self themeEditorOverlayIn: aRootElement do: [ :anOverlay |
		anOverlay highlightElement: (self
			childToThemeAt: (aThemeEditorTarget globalPointToLocal: (aRootElement localPointToGlobal: aPoint))
			in: aThemeEditorTarget
			ifFound: #yourself
			ifNone: [ nil ]) ]
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
	overlayState := CgtEditorOverlayState new.
	transitionToken := 0.
	desiredThemeEditorOpen := false.
	isTransitioningThemeEditor := false
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
	transitionToken := transitionToken + 1.
	^ transitionToken
]

{ #category : 'private - themeEditor' }
CgtEditorEventHandler >> processRequestedThemeEditorStateIn: aRootElement [
	self isTransitioningThemeEditorValue ifTrue: [ ^ self ].
	(self desiredThemeEditorOpenValue and: [ hasThemeEditor not ])
		ifTrue: [ ^ self showThemeEditor: aRootElement ].
	(self desiredThemeEditorOpenValue not and: [ hasThemeEditor ])
		ifTrue: [ ^ self hideThemeEditor: aRootElement ]
]

{ #category : 'event handling' }
CgtEditorEventHandler >> mouseMoveEvent: aMouseMoveEvent [
	| aThemeEditorTarget |
	
	hasOverlay
		ifFalse: [ 
			mousePosition := aMouseMoveEvent localPosition.
			elementToHighlight := nil.
			^ self ].
	
	aThemeEditorTarget := self themeEditorTargetIn: aMouseMoveEvent currentTarget.
	(aThemeEditorTarget containsGlobalPoint: aMouseMoveEvent position)
		ifTrue: [
			self
				highlightElementAt: aMouseMoveEvent localPosition
				in: aMouseMoveEvent currentTarget ]
		ifFalse: [ mousePosition := nil ] 
]

{ #category : 'api - overlay' }
CgtEditorEventHandler >> selectElement: anElement in: aRootElement [
	elementToSelect := anElement.
	overlayState selectElement: anElement.
	self themeEditorOverlayIn: aRootElement do: [ :anOverlay | anOverlay selectElement: anElement ].
	self
		themeEditorIn: aRootElement
		do: [ :aThemeEditor | aThemeEditor selectElement: anElement ]
]

{ #category : 'event handling' }
CgtEditorEventHandler >> selectElementEvent: aSelectElementEvent [
	self
		selectElement: aSelectElementEvent element
		in: aSelectElementEvent currentTarget
]

{ #category : 'api - overlay' }
CgtEditorEventHandler >> showOverlayIn: aRootElement [
	hasOverlay
		ifTrue: [
			(elementToHighlight isNil and: [ mousePosition notNil ])
				ifTrue: [ self highlightElementAt: mousePosition in: aRootElement ].
				
			self themeEditorOverlayIn: aRootElement do: [ :anOverlay |
				anOverlay allowMeAndChildrenMouseEvents.
				anOverlay animateFadeIn ].
			^ self ].

	hasOverlay := true.

	(self themeEditorTargetIn: aRootElement)
		addChild: (CgtEditorOverlay new
			id: ThemeEditorOverlayId;
			state: overlayState;
			highlightElement: elementToHighlight;
			selectElement: elementToSelect;
			overlayOpacity: 0.0;
			allowMeAndChildrenMouseEvents;
			animateFadeIn;
			yourself).

	(elementToHighlight isNil and: [ mousePosition notNil ])
		ifTrue: [ self highlightElementAt: mousePosition in: aRootElement ]
]

{ #category : 'api - themeEditor' }
CgtEditorEventHandler >> showThemeEditor: aRootElement [
	| aTargetElementChildren aTargetContainer aToken |

	hasThemeEditor ifTrue: [ ^ self ].
	self isTransitioningThemeEditorValue ifTrue: [ ^ self ].
	isTransitioningThemeEditor := true.
	desiredThemeEditorOpen := true.
	aToken := self nextTransitionToken.
	self lockOverlay.
	
	aRootElement isAttachedToSceneGraph
		ifTrue: [
			originalTitle := aRootElement space title.
			aRootElement space title: 'Catalyst Theme Editor' ].

	hasThemeEditor := true.
	overlayState hoverElement: nil.
	self showOverlayIn: aRootElement.

	aTargetElementChildren := aRootElement children asArray.
	aRootElement removeChildren.

	aTargetContainer := BlElement new.
	aTargetContainer size: aRootElement extent.
	aTargetContainer addChildren: aTargetElementChildren.

	aRootElement addChild: (CgtEditor new initializeWith: aTargetContainer) as: ThemeEditorId.
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
				ifNotNil: [ aThemeEditor selectElement: aShowThemeEditorEvent elementToSelect ].
			aShowThemeEditorEvent sceneExtent
				ifNotNil: [ aThemeEditor targetContainer size: aShowThemeEditorEvent sceneExtent ] ]
]

{ #category : 'private - accessing' }
CgtEditorEventHandler >> themeEditorIn: aTargetElement do: aBlock [
	aTargetElement
		childWithId: ThemeEditorId
		ifFound: aBlock
		ifNone: [  ]
]

{ #category : 'private - accessing' }
CgtEditorEventHandler >> themeEditorOverlayIn: aRootElement do: aBlock [
	aRootElement
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
