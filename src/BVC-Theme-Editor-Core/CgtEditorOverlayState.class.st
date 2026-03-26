Class {
	#name : 'CgtEditorOverlayState',
	#superclass : 'Object',
	#instVars : [
		'selectedElement',
		'hoverElement',
		'childScopeElement',
		'activeScopeElements',
		'scopeStartTransparency',
		'scopeStepTransparency',
		'hoverTransparency',
		'hoverInsideSelectedTransparency',
		'maskOutset',
		'dimOpacity',
		'blurRadius',
		'defaultCornerRadius'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtEditorOverlayState >> initialize [
	super initialize.
	activeScopeElements := OrderedCollection new.
	scopeStartTransparency := 0.85.
	scopeStepTransparency := 0.025.
	hoverTransparency := 0.85.
	hoverInsideSelectedTransparency := 0.05.
	maskOutset := 6.
	dimOpacity := 0.35.
	blurRadius := 6.
	defaultCornerRadius := 10
]

{ #category : 'accessing' }
CgtEditorOverlayState >> activeScopeElements [
	^ activeScopeElements copy
]

{ #category : 'accessing' }
CgtEditorOverlayState >> blurRadius [
	^ blurRadius
]

{ #category : 'accessing' }
CgtEditorOverlayState >> childScopeElement [
	^ childScopeElement
]

{ #category : 'actions' }
CgtEditorOverlayState >> clickBehaviorForHover [
	hoverElement ifNil: [ ^ #none ].
	selectedElement ifNil: [ ^ #select ].
	hoverElement == selectedElement ifTrue: [ ^ #deselect ].
	(self includesAncestorScopeElement: hoverElement) ifTrue: [ ^ #toggleScope ].
	(self isDescendantOfSelection: hoverElement) ifTrue: [ ^ #toggleChildScope ].
	^ #select
]

{ #category : 'actions' }
CgtEditorOverlayState >> clickHoverElement [
	| aBehavior |
	aBehavior := self clickBehaviorForHover.
	aBehavior = #none ifTrue: [ ^ self ].
	aBehavior = #select ifTrue: [ ^ self selectElement: hoverElement ].
	aBehavior = #deselect ifTrue: [ ^ self deselect ].
	aBehavior = #toggleScope ifTrue: [ ^ self toggleScopeElement: hoverElement ].
	aBehavior = #toggleChildScope ifTrue: [ ^ self toggleChildScopeElement: hoverElement ].
]

{ #category : 'accessing' }
CgtEditorOverlayState >> defaultCornerRadius [
	^ defaultCornerRadius
]

{ #category : 'actions' }
CgtEditorOverlayState >> deselect [
	selectedElement := nil.
	childScopeElement := nil.
	activeScopeElements removeAll
]

{ #category : 'accessing' }
CgtEditorOverlayState >> dimOpacity [
	^ dimOpacity
]

{ #category : 'accessing' }
CgtEditorOverlayState >> hoverElement [
	^ hoverElement
]

{ #category : 'accessing' }
CgtEditorOverlayState >> hoverElement: anElementOrNil [
	hoverElement := anElementOrNil
]

{ #category : 'accessing' }
CgtEditorOverlayState >> hoverTransparency [
	^ hoverTransparency
]

{ #category : 'accessing' }
CgtEditorOverlayState >> hoverTransparencyForCurrentHover [
	(selectedElement notNil and: [ self isDescendantOfSelection: hoverElement ])
		ifTrue: [ ^ hoverInsideSelectedTransparency ].
	^ hoverTransparency
]

{ #category : 'testing' }
CgtEditorOverlayState >> includesAncestorScopeElement: anElement [
	selectedElement ifNil: [ ^ false ].
	anElement ifNil: [ ^ false ].
	^ (self selectedAncestorPath includes: anElement)
]

{ #category : 'testing' }
CgtEditorOverlayState >> isDescendantOfSelection: anElement [
	selectedElement ifNil: [ ^ false ].
	anElement ifNil: [ ^ false ].
	anElement == selectedElement ifTrue: [ ^ false ].
	^ anElement hasParent: selectedElement
]

{ #category : 'testing' }
CgtEditorOverlayState >> isHoverOnSelected [
	^ hoverElement notNil and: [ hoverElement == selectedElement ]
]

{ #category : 'accessing' }
CgtEditorOverlayState >> maskOutset [
	^ maskOutset
]

{ #category : 'accessing' }
CgtEditorOverlayState >> observedElements [
	| theElements |
	theElements := OrderedCollection new.
	selectedElement ifNotNil: [ theElements add: selectedElement ].
	hoverElement ifNotNil: [ (theElements includes: hoverElement) ifFalse: [ theElements add: hoverElement ] ].
	childScopeElement ifNotNil: [ (theElements includes: childScopeElement) ifFalse: [ theElements add: childScopeElement ] ].
	activeScopeElements do: [ :eachElement | (theElements includes: eachElement) ifFalse: [ theElements add: eachElement ] ].
	^ theElements
]

{ #category : 'accessing' }
CgtEditorOverlayState >> scopeElementsInDisplayOrder [
	| thePath |
	thePath := self selectedAncestorPath.
	^ thePath select: [ :eachElement | activeScopeElements includes: eachElement ]
]

{ #category : 'accessing' }
CgtEditorOverlayState >> scopeStartTransparency [
	^ scopeStartTransparency
]

{ #category : 'accessing' }
CgtEditorOverlayState >> scopeTransparencyAtIndex: anIndex [
	^ (scopeStartTransparency - ((anIndex - 1) * scopeStepTransparency)) max: 0.0
]

{ #category : 'accessing' }
CgtEditorOverlayState >> selectedAncestorPath [
	| thePath eachParent |
	selectedElement ifNil: [ ^ #() ].
	thePath := OrderedCollection new.
	eachParent := selectedElement parent.
	[ eachParent notNil ] whileTrue: [
		thePath add: eachParent.
		eachParent := eachParent parent ].
	^ thePath
]

{ #category : 'accessing' }
CgtEditorOverlayState >> selectedElement [
	^ selectedElement
]

{ #category : 'accessing' }
CgtEditorOverlayState >> selectElement: anElementOrNil [
	selectedElement == anElementOrNil ifTrue: [ ^ self ].
	selectedElement := anElementOrNil.
	childScopeElement := nil.
	activeScopeElements removeAll
]

{ #category : 'actions' }
CgtEditorOverlayState >> toggleChildScopeElement: anElement [
	(self isDescendantOfSelection: anElement) ifFalse: [ ^ self ].
	childScopeElement == anElement
		ifTrue: [ childScopeElement := nil ]
		ifFalse: [ childScopeElement := anElement ]
]

{ #category : 'actions' }
CgtEditorOverlayState >> toggleScopeElement: anElement [
	(self includesAncestorScopeElement: anElement) ifFalse: [ ^ self ].
	(activeScopeElements includes: anElement)
		ifTrue: [ activeScopeElements remove: anElement ifAbsent: [ ] ]
		ifFalse: [ activeScopeElements add: anElement ]
]
