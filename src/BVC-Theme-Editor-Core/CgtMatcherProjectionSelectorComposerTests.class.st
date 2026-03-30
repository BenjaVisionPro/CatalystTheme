"
#Matcher Projection Selector Composer Tests
I verify selector recomposition from matcher projection state. I am responsible for checking that current-rule projection nodes and matcher relations round-trip back into pure selector objects.
"
Class {
	#name : 'CgtMatcherProjectionSelectorComposerTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtMatcherProjectionSelectorComposerTests >> testComposesChildSelectorFromProjectionNodes [
	| root child projection selector |
	projection := CgtMatcherProjection new.
	root := (CgtMatcherProjectionNode kind: #upstreamScope)
		representedElement: (self newTestElementWithId: #root);
		isInCurrentRule: true;
		matchById: true;
		yourself.
	child := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: (self newTestElementWithId: #selected);
		isInCurrentRule: true;
		matchByClass: true;
		yourself.
	projection
		addNode: root;
		addNode: child;
		addRelation: ((CgtMatcherProjectionRelation from: root to: child kind: #matcher)
			combinator: #child;
			yourself).
	selector := CgtMatcherProjectionSelectorComposer selectorForProjection: projection.
	self assert: selector displayString equals: '#root > CgtThemeSelectorTestElement'
]

{ #category : 'tests' }
CgtMatcherProjectionSelectorComposerTests >> testIgnoresCompactedNodesWhenRecomposingSelector [
	| root compacted selected projection selector |
	projection := CgtMatcherProjection new.
	root := (CgtMatcherProjectionNode kind: #upstreamScope)
		representedElement: (self newTestElementWithId: #root);
		isInCurrentRule: true;
		matchById: true;
		yourself.
	compacted := (CgtMatcherProjectionNode kind: #compactedSection)
		hiddenNodeCount: 2;
		isEditable: false;
		yourself.
	selected := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: (self newTestElementWithId: #selected);
		isInCurrentRule: true;
		matchById: true;
		yourself.
	projection
		addNode: root;
		addNode: compacted;
		addNode: selected;
		addRelation: (CgtMatcherProjectionRelation from: root to: compacted kind: #compaction);
		addRelation: ((CgtMatcherProjectionRelation from: compacted to: selected kind: #matcher)
			combinator: #descendant;
			yourself).
	selector := CgtMatcherProjectionSelectorComposer selectorForProjection: projection.
	self assert: selector displayString equals: '#root descendant #selected'
]

{ #category : 'private' }
CgtMatcherProjectionSelectorComposerTests >> newTestElementWithId: aSymbol [
	^ CgtThemeSelectorTestElement new
		id: (BlElementId named: aSymbol);
		yourself
]


{ #category : 'tests' }
CgtMatcherProjectionSelectorComposerTests >> testUsesMatcherCombinatorAcrossExpandedContextNodes [
	| root middle selected projection selector |
	projection := CgtMatcherProjection new.
	root := (CgtMatcherProjectionNode kind: #upstreamScope)
		representedElement: (self newTestElementWithId: #root);
		isInCurrentRule: true;
		matchById: true;
		yourself.
	middle := (CgtMatcherProjectionNode kind: #upstreamScope)
		representedElement: (self newTestElementWithId: #middle);
		isEditable: false;
		yourself.
	selected := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: (self newTestElementWithId: #selected);
		isInCurrentRule: true;
		matchById: true;
		yourself.
	projection
		addNode: root;
		addNode: middle;
		addNode: selected;
		addRelation: (CgtMatcherProjectionRelation from: root to: middle kind: #context);
		addRelation: ((CgtMatcherProjectionRelation from: middle to: selected kind: #matcher)
			combinator: #descendant;
			yourself).
	selector := CgtMatcherProjectionSelectorComposer selectorForProjection: projection.
	self assert: selector displayString equals: '#root descendant #selected'
]
