"
#Theme Editor Interaction State
I am the semantic interaction state of the Theme Editor. I am responsible for selection, scope changes, hover sources, explicit highlights, and the effective hover that should be rendered. I own the interaction rules so that {{gtClass:CgtEditor}} can stay focused on UI composition.
"
Class {
	#name : 'CgtEditorInteractionState',
	#superclass : 'Object',
	#instVars : [
		'overlayModel',
		'selectedElement',
		'selectedElementPath',
		'previewHoverElement',
		'pathWidgetHoveredElement',
		'matcherWidgetHoveredElement',
		'externallyHighlightedElement'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtEditorInteractionState >> initialize [
	super initialize.
	overlayModel := CgtViewTreeOverlayModel new
]

{ #category : 'accessing' }
CgtEditorInteractionState >> overlayModel [
	^ overlayModel
]

{ #category : 'accessing' }
CgtEditorInteractionState >> overlayModel: aCgtViewTreeOverlayModel [
	overlayModel := aCgtViewTreeOverlayModel
]

{ #category : 'accessing' }
CgtEditorInteractionState >> selectedElement [
	^ selectedElement
]

{ #category : 'accessing' }
CgtEditorInteractionState >> selectedElementPath [
	^ selectedElementPath
]

{ #category : 'testing' }
CgtEditorInteractionState >> hasPathWidgetHover [
	^ pathWidgetHoveredElement notNil
]

{ #category : 'testing' }
CgtEditorInteractionState >> hasPreviewHover [
	^ previewHoverElement notNil
]

{ #category : 'testing' }
CgtEditorInteractionState >> hasMatcherWidgetHover [
	^ matcherWidgetHoveredElement notNil
]


{ #category : 'accessing' }
CgtEditorInteractionState >> externallyHighlightedElement [
	^ externallyHighlightedElement
]

{ #category : 'accessing' }
CgtEditorInteractionState >> previewHoverElement [
	^ previewHoverElement
]

{ #category : 'accessing' }
CgtEditorInteractionState >> matcherWidgetHoveredElement [
	^ matcherWidgetHoveredElement
]

{ #category : 'accessing' }
CgtEditorInteractionState >> effectiveHoverElement [
	^ externallyHighlightedElement
		ifNil: [ matcherWidgetHoveredElement ifNil: [ pathWidgetHoveredElement ifNil: [ previewHoverElement ] ] ]
]

{ #category : 'event handling - preview' }
CgtEditorInteractionState >> setPreviewHoverElement: anElement [
	previewHoverElement == anElement ifTrue: [ ^ false ].
	previewHoverElement := anElement.
	^ true
]

{ #category : 'event handling - preview' }
CgtEditorInteractionState >> clearPreviewHover [
	previewHoverElement ifNil: [ ^ false ].
	previewHoverElement := nil.
	^ true
]

{ #category : 'event handling - style inspector' }
CgtEditorInteractionState >> pathWidgetHoveredElement: anElement [
	pathWidgetHoveredElement == anElement ifTrue: [ ^ false ].
	pathWidgetHoveredElement := anElement.
	^ true
]


{ #category : 'event handling - style inspector' }
CgtEditorInteractionState >> matcherWidgetHoveredElement: anElement [
	matcherWidgetHoveredElement == anElement ifTrue: [ ^ false ].
	matcherWidgetHoveredElement := anElement.
	^ true
]

{ #category : 'event handling - style inspector' }
CgtEditorInteractionState >> clearMatcherWidgetHover [
	matcherWidgetHoveredElement ifNil: [ ^ false ].
	matcherWidgetHoveredElement := nil.
	^ true
]

{ #category : 'event handling - style inspector' }
CgtEditorInteractionState >> clearPathWidgetHover [
	pathWidgetHoveredElement ifNil: [ ^ false ].
	pathWidgetHoveredElement := nil.
	^ true
]

{ #category : 'event handling - external' }
CgtEditorInteractionState >> highlightedElement: anElement [
	externallyHighlightedElement == anElement ifTrue: [ ^ false ].
	externallyHighlightedElement := anElement.
	^ true
]

{ #category : 'event handling - external' }
CgtEditorInteractionState >> clearHighlightedElement [
	externallyHighlightedElement ifNil: [ ^ false ].
	externallyHighlightedElement := nil.
	^ true
]

{ #category : 'event handling - selection' }
CgtEditorInteractionState >> requestSelectionOf: anElement [
	anElement
		ifNil: [ self clearSelection ]
		ifNotNil: [ self selectAnchorElement: anElement ].
	self refreshSelectionState.
	^ true
]

{ #category : 'event handling - selection' }
CgtEditorInteractionState >> applySelectionInteractionWith: anElement [
	self updateSelectionWithInteractedElement: anElement.
	self refreshSelectionState.
	^ true
]

{ #category : 'private - selection' }
CgtEditorInteractionState >> refreshSelectionState [
	selectedElementPath := overlayModel primaryPath.
	selectedElement := overlayModel anchorElement
]


{ #category : 'private - selection' }
CgtEditorInteractionState >> clearSelection [
	overlayModel
		pathPresentations: #();
		hoverElement: nil
]

{ #category : 'private - selection' }
CgtEditorInteractionState >> selectAnchorElement: anElement [
	overlayModel pathPresentations:
		(OrderedCollection with:
			(CgtViewTreeOverlayPathPresentation
				path: (CgtElementPath anchorElement: anElement)
				kind: #primary))
]

{ #category : 'private - selection' }
CgtEditorInteractionState >> updateSelectionWithInteractedElement: anElement [
	| aPath anchor |
	anElement ifNil: [ ^ self ].
	aPath := overlayModel primaryPath.
	aPath ifNil: [ ^ self selectAnchorElement: anElement ].
	anchor := aPath anchorElement.
	anchor ifNil: [ ^ self selectAnchorElement: anElement ].
	anElement == anchor
		ifTrue: [ ^ self clearSelection ].
	(anchor hasParent: anElement)
		ifTrue: [ ^ aPath toggleUpstreamElement: anElement ].
	(anElement hasParent: anchor)
		ifTrue: [ ^ aPath setDownstreamElement: anElement ].
	self selectAnchorElement: anElement
]
