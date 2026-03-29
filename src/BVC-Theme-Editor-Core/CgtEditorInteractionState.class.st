Class {
	#name : 'CgtEditorInteractionState',
	#superclass : 'Object',
	#instVars : [
		'overlayModel',
		'selectedElement',
		'selectedElementPath',
		'previewHoverElement',
		'pathWidgetHoveredElement',
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

{ #category : 'accessing' }
CgtEditorInteractionState >> effectiveHoverElement [
	^ externallyHighlightedElement
		ifNil: [ pathWidgetHoveredElement ifNil: [ previewHoverElement ] ]
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

{ #category : 'restoring' }
CgtEditorInteractionState >> restoreSelection: aSelectedElement highlighted: aHighlightedElement previewHovered: aPreviewHoveredElement [
	self requestSelectionOf: aSelectedElement.
	externallyHighlightedElement := aHighlightedElement.
	previewHoverElement := aPreviewHoveredElement
]

{ #category : 'event handling - selection' }
CgtEditorInteractionState >> requestSelectionOf: anElement [
	anElement
		ifNil: [ overlayModel deselect ]
		ifNotNil: [ overlayModel setPrimaryAnchorElement: anElement ].
	self synchronizeSelectionState.
	^ true
]

{ #category : 'event handling - selection' }
CgtEditorInteractionState >> applySelectionInteractionWith: anElement [
	self updateSelectionWithInteractedElement: anElement.
	self synchronizeSelectionState.
	^ true
]

{ #category : 'private - selection' }
CgtEditorInteractionState >> synchronizeSelectionState [
	selectedElementPath := overlayModel primaryPath.
	selectedElement := overlayModel anchorElement
]

{ #category : 'private - selection' }
CgtEditorInteractionState >> updateSelectionWithInteractedElement: anElement [
	| aPath anchor |
	anElement ifNil: [ ^ self ].
	aPath := overlayModel primaryPath.
	aPath ifNil: [ ^ overlayModel setPrimaryAnchorElement: anElement ].
	anchor := aPath anchorElement.
	anchor ifNil: [ ^ overlayModel setPrimaryAnchorElement: anElement ].
	anElement == anchor
		ifTrue: [ ^ overlayModel deselect ].
	(anchor hasParent: anElement)
		ifTrue: [ ^ aPath toggleUpstreamElement: anElement ].
	(anElement hasParent: anchor)
		ifTrue: [ ^ aPath setDownstreamElement: anElement ].
	overlayModel setPrimaryAnchorElement: anElement
]
