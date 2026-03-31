"
#Editor Selector Hover Sync Tests
I verify that selector node hover is translated into editor interaction-state hover so the live overlay can stay synchronized with the selector renderer.
"
Class {
	#name : 'CgtEditorMatcherHoverSyncTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtEditorMatcherHoverSyncTests >> testSelectorNodeHoverUpdatesInteractionState [
	<gtExample>
	| editor element node |
	editor := CgtEditor new.
	element := BlElement new.
	node := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: element;
		yourself.
	editor selectorNodeHoveredEvent: (CgtThemeSelectorNodeHoveredEvent new projectionNode: node; yourself).
	self assert: editor interactionState effectiveHoverElement identicalTo: element.
	^ node

]

{ #category : 'tests' }
CgtEditorMatcherHoverSyncTests >> testSelectorNodeUnhoverClearsSelectorRendererHover [
	<gtExample>
	| editor element node |
	editor := CgtEditor new.
	element := BlElement new.
	node := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: element;
		yourself.
	editor selectorNodeHoveredEvent: (CgtThemeSelectorNodeHoveredEvent new projectionNode: node; yourself).
	editor selectorNodeUnhoveredEvent: (CgtThemeSelectorNodeUnhoveredEvent new projectionNode: node; yourself).
	self assert: editor interactionState hasSelectorRendererHover not.
	^ node

]
