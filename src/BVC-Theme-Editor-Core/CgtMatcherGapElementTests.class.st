"
#Matcher Gap Element Tests
I verify matcher gap interaction behavior. I am responsible for checking that the between-nodes path controls and reveal action emit explicit matcher events from the compacted gap element.
"
Class {
	#name : 'CgtMatcherGapElementTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtMatcherGapElementTests >> testRequestCombinatorChangePublishesEvent [
	<gtExample>
	| gap relation element event |
	gap := (CgtMatcherProjectionNode kind: #compactedSection)
		hiddenNodeCount: 2;
		yourself.
	relation := (CgtMatcherProjectionRelation from: gap to: (CgtMatcherProjectionNode kind: #selectedElement) kind: #matcher)
		combinator: #child;
		yourself.
	element := CgtMatcherGapElement new
		projectionNode: gap;
		outgoingRelation: relation;
		yourself.
	element when: CgtMatcherCombinatorChangedEvent do: [ :anEvent | event := anEvent ].
	element requestCombinatorChange: #descendant.
	self assert: event notNil.
	self assert: event relation identicalTo: relation.
	self assert: event combinator equals: #descendant.
	^ gap

]

{ #category : 'tests' }
CgtMatcherGapElementTests >> testRequestRevealPublishesExpansionEvent [
	<gtExample>
	| gap element event |
	gap := (CgtMatcherProjectionNode kind: #compactedSection)
		hiddenNodeCount: 2;
		yourself.
	element := CgtMatcherGapElement new
		projectionNode: gap;
		yourself.
	element when: CgtMatcherCompactedSectionExpandedEvent do: [ :anEvent | event := anEvent ].
	element requestCompactedSectionExpansionFor: gap.
	self assert: event notNil.
	self assert: event projectionNode identicalTo: gap.
	^ gap

]


{ #category : 'tests' }
CgtMatcherGapElementTests >> testRefreshContentsBuildsSingleCompactRevealHandle [
	<gtExample>
	| gap element |
	gap := (CgtMatcherProjectionNode kind: #compactedSection)
		hiddenNodeCount: 2;
		yourself.
	element := CgtMatcherGapElement new
		projectionNode: gap;
		yourself.
	self assert: element children size equals: 1.
	^ element
]
