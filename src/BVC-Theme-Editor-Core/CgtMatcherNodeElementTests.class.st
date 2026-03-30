"
#Matcher Node Element Tests
I verify matcher-node interaction behavior. I am responsible for checking that nested hover forwarding does not spam hover state changes while the pointer moves across controls inside the same node.
"
Class {
	#name : 'CgtMatcherNodeElementTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtMatcherNodeElementTests >> testNestedHoverForwardingPublishesSingleHoverAndSingleUnhover [
	| node element hoverCount unhoverCount |
	node := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: (self newTestElementWithId: #selected);
		yourself.
	element := CgtMatcherNodeElement new
		projectionNode: node;
		yourself.
	hoverCount := 0.
	unhoverCount := 0.
	element when: CgtMatcherNodeHoveredEvent do: [ :anEvent | hoverCount := hoverCount + 1 ].
	element when: CgtMatcherNodeUnhoveredEvent do: [ :anEvent | unhoverCount := unhoverCount + 1 ].
	element onNodeHovered: nil.
	element onNodeHovered: nil.
	element onNodeUnhovered: nil.
	self assert: hoverCount equals: 1.
	self assert: unhoverCount equals: 0.
	element onNodeUnhovered: nil.
	self assert: hoverCount equals: 1.
	self assert: unhoverCount equals: 1
]

{ #category : 'private' }
CgtMatcherNodeElementTests >> newTestElementWithId: aSymbol [
	^ CgtThemeSelectorTestElement new
		id: (BlElementId named: aSymbol);
		yourself
]
