"
#Editor Matcher Hover Sync Tests
I verify that matcher node hover is translated into editor interaction-state hover so the live overlay can stay synchronized with the matcher widget.
"
Class {
	#name : 'CgtEditorMatcherHoverSyncTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtEditorMatcherHoverSyncTests >> testMatcherNodeHoverUpdatesInteractionState [
	| editor element node |
	editor := CgtEditor new.
	element := BlElement new.
	node := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: element;
		yourself.
	editor matcherNodeHoveredEvent: (CgtMatcherNodeHoveredEvent new projectionNode: node; yourself).
	self assert: editor interactionState effectiveHoverElement identicalTo: element
]

{ #category : 'tests' }
CgtEditorMatcherHoverSyncTests >> testMatcherNodeUnhoverClearsMatcherHover [
	| editor element node |
	editor := CgtEditor new.
	element := BlElement new.
	node := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: element;
		yourself.
	editor matcherNodeHoveredEvent: (CgtMatcherNodeHoveredEvent new projectionNode: node; yourself).
	editor matcherNodeUnhoveredEvent: (CgtMatcherNodeUnhoveredEvent new projectionNode: node; yourself).
	self assert: editor interactionState hasMatcherWidgetHover not
]
