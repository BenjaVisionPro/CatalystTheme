"
#Editor Interaction State Tests
I verify the effective-hover precedence rules for the Theme Editor. I am responsible for checking that matcher hover, path hover, preview hover, and explicit highlight resolve in the intended order.
"
Class {
	#name : 'CgtEditorInteractionStateTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtEditorInteractionStateTests >> testMatcherHoverOverridesPreviewHover [
	| state preview matcher |
	state := CgtEditorInteractionState new.
	preview := BlElement new.
	matcher := BlElement new.
	state setPreviewHoverElement: preview.
	state matcherWidgetHoveredElement: matcher.
	self assert: state effectiveHoverElement identicalTo: matcher
]

{ #category : 'tests' }
CgtEditorInteractionStateTests >> testPathHoverOverridesPreviewWhenMatcherHoverIsAbsent [
	| state preview path |
	state := CgtEditorInteractionState new.
	preview := BlElement new.
	path := BlElement new.
	state setPreviewHoverElement: preview.
	state pathWidgetHoveredElement: path.
	self assert: state effectiveHoverElement identicalTo: path
]

{ #category : 'tests' }
CgtEditorInteractionStateTests >> testClearingMatcherHoverFallsBackToPathThenPreview [
	| state preview path matcher |
	state := CgtEditorInteractionState new.
	preview := BlElement new.
	path := BlElement new.
	matcher := BlElement new.
	state setPreviewHoverElement: preview.
	state pathWidgetHoveredElement: path.
	state matcherWidgetHoveredElement: matcher.
	self assert: state effectiveHoverElement identicalTo: matcher.
	state clearMatcherWidgetHover.
	self assert: state effectiveHoverElement identicalTo: path.
	state clearPathWidgetHover.
	self assert: state effectiveHoverElement identicalTo: preview
]

{ #category : 'tests' }
CgtEditorInteractionStateTests >> testExplicitHighlightOverridesMatcherHover [
	| state highlight matcher |
	state := CgtEditorInteractionState new.
	highlight := BlElement new.
	matcher := BlElement new.
	state matcherWidgetHoveredElement: matcher.
	state highlightedElement: highlight.
	self assert: state effectiveHoverElement identicalTo: highlight
]
