"
#Theme Matcher Mondrian Widget Tests
I verify the Mondrian matcher widget skeleton and its explicit edit-event forwarding. I am responsible for checking that passive matcher projections render as Mondrian nodes and that matcher-node events are forwarded by the widget.
"
Class {
	#name : 'CgtThemeMatcherMondrianWidgetTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtThemeMatcherMondrianWidgetTests >> testBuildsMondrianGraphFromProjection [
	| upstreamNode selectedNode relation projection widget |
	projection := CgtMatcherProjection new.
	upstreamNode := (CgtMatcherProjectionNode kind: #upstreamScope)
		className: 'RootElement';
		elementId: (BlElementId named: #root);
		isInCurrentRule: true;
		matchById: true;
		yourself.
	selectedNode := (CgtMatcherProjectionNode kind: #selectedElement)
		className: 'SelectedElement';
		elementId: (BlElementId named: #selected);
		isInCurrentRule: true;
		matchByClass: true;
		yourself.
	relation := (CgtMatcherProjectionRelation from: upstreamNode to: selectedNode kind: #matcher)
		combinator: #child;
		yourself.
	projection addNode: upstreamNode.
	projection addNode: selectedNode.
	projection addRelation: relation.
	widget := CgtThemeMatcherMondrianWidget new
		projection: projection;
		yourself.
	self assert: widget mondrian notNil.
	self assert: widget graphElement notNil.
	self assert: widget graphElement graph nodeChildren size equals: 2.
	self assert: widget graphElement graph edgeChildren size equals: 1
]

{ #category : 'tests' }
CgtThemeMatcherMondrianWidgetTests >> testPublishesSelectorChangedEventWhenClassToggleChanges [
	| element node projection widget selectorChangedEvent graphNodeElement |
	element := CgtThemeSelectorTestElement new
		id: (BlElementId named: #selected);
		yourself.
	projection := CgtMatcherProjection new.
	node := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: element;
		isInCurrentRule: true;
		matchByClass: false;
		yourself.
	projection addNode: node.
	widget := CgtThemeMatcherMondrianWidget new
		projection: projection;
		yourself.
	widget when: CgtMatcherSelectorChangedEvent do: [ :anEvent | selectorChangedEvent := anEvent ].
	graphNodeElement := widget graphElement graph nodeChildren first.
	graphNodeElement requestClassMatchToggleFor: node.
	self assert: selectorChangedEvent notNil.
	self assert: selectorChangedEvent projection identicalTo: projection.
	self assert: selectorChangedEvent selector displayString equals: 'CgtThemeSelectorTestElement'.
	self assert: node matchByClass
]

{ #category : 'tests' }
CgtThemeMatcherMondrianWidgetTests >> testUsesCustomNodeStencilElement [
	| node projection widget graphNodeElement |
	projection := CgtMatcherProjection new.
	node := (CgtMatcherProjectionNode kind: #selectedElement)
		className: 'SelectedElement';
		elementId: (BlElementId named: #selected);
		isInCurrentRule: true;
		matchByClass: true;
		yourself.
	projection addNode: node.
	widget := CgtThemeMatcherMondrianWidget new
		projection: projection;
		yourself.
	graphNodeElement := widget graphElement graph nodeChildren first.
	self assert: (graphNodeElement isKindOf: CgtMatcherNodeElement).
	self assert: graphNodeElement projectionNode identicalTo: node
]

{ #category : 'tests' }
CgtThemeMatcherMondrianWidgetTests >> testForwardsMatcherNodeEditEvents [
	| node projection widget forwardedEvent graphNodeElement |
	projection := CgtMatcherProjection new.
	node := (CgtMatcherProjectionNode kind: #selectedElement)
		className: 'SelectedElement';
		elementId: (BlElementId named: #selected);
		isInCurrentRule: true;
		matchByClass: false;
		yourself.
	projection addNode: node.
	widget := CgtThemeMatcherMondrianWidget new
		projection: projection;
		yourself.
	widget when: CgtMatcherClassMatchToggledEvent do: [ :anEvent | forwardedEvent := anEvent ].
	graphNodeElement := widget graphElement graph nodeChildren first.
	graphNodeElement requestClassMatchToggleFor: node.
	self assert: forwardedEvent notNil.
	self assert: forwardedEvent projectionNode identicalTo: node.
	self assert: forwardedEvent shouldMatch
]


{ #category : 'tests' }
CgtThemeMatcherMondrianWidgetTests >> testPublishesSelectorChangedEventWhenCombinatorChanges [
	| root selected projection relation widget selectorChangedEvent graphNodeElement |
	root := (CgtMatcherProjectionNode kind: #upstreamScope)
		representedElement: (self newTestElementWithId: #root);
		isInCurrentRule: true;
		matchById: true;
		yourself.
	selected := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: (self newTestElementWithId: #selected);
		isInCurrentRule: true;
		matchById: true;
		yourself.
	relation := (CgtMatcherProjectionRelation from: root to: selected kind: #matcher)
		combinator: #child;
		yourself.
	projection := CgtMatcherProjection new.
	projection
		addNode: root;
		addNode: selected;
		addRelation: relation.
	widget := CgtThemeMatcherMondrianWidget new
		projection: projection;
		yourself.
	widget when: CgtMatcherSelectorChangedEvent do: [ :anEvent | selectorChangedEvent := anEvent ].
	graphNodeElement := widget graphElement graph nodeChildren second.
	graphNodeElement requestCombinatorChange: #descendant.
	self assert: selectorChangedEvent notNil.
	self assert: relation combinator equals: #descendant.
	self assert: selectorChangedEvent selector displayString equals: '#root descendant #selected'
]

{ #category : 'tests' }
CgtThemeMatcherMondrianWidgetTests >> testForwardsMatcherCombinatorChangedEvents [
	| root selected projection relation widget forwardedEvent graphNodeElement |
	root := (CgtMatcherProjectionNode kind: #upstreamScope)
		representedElement: (self newTestElementWithId: #root);
		isInCurrentRule: true;
		matchById: true;
		yourself.
	selected := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: (self newTestElementWithId: #selected);
		isInCurrentRule: true;
		matchById: true;
		yourself.
	relation := (CgtMatcherProjectionRelation from: root to: selected kind: #matcher)
		combinator: #child;
		yourself.
	projection := CgtMatcherProjection new.
	projection
		addNode: root;
		addNode: selected;
		addRelation: relation.
	widget := CgtThemeMatcherMondrianWidget new
		projection: projection;
		yourself.
	widget when: CgtMatcherCombinatorChangedEvent do: [ :anEvent | forwardedEvent := anEvent ].
	graphNodeElement := widget graphElement graph nodeChildren second.
	graphNodeElement requestCombinatorChange: #descendant.
	self assert: forwardedEvent notNil.
	self assert: forwardedEvent relation identicalTo: relation.
	self assert: forwardedEvent combinator equals: #descendant
]



{ #category : 'tests' }
CgtThemeMatcherMondrianWidgetTests >> testOrdersCurrentRuleNodesBeforeContextNodesForRendering [
	| upstream selected context projection widget orderedNodes |
	upstream := (CgtMatcherProjectionNode kind: #upstreamScope)
		className: 'Root';
		isInCurrentRule: true;
		yourself.
	selected := (CgtMatcherProjectionNode kind: #selectedElement)
		className: 'Selected';
		isInCurrentRule: true;
		yourself.
	context := (CgtMatcherProjectionNode kind: #otherRuleRelated)
		className: 'Context';
		isInOtherRule: true;
		isEditable: false;
		yourself.
	projection := CgtMatcherProjection new.
	projection
		addNode: context;
		addNode: selected;
		addNode: upstream.
	widget := CgtThemeMatcherMondrianWidget new
		projection: projection;
		yourself.
	orderedNodes := widget orderedNodesForRendering.
	self assert: orderedNodes first identicalTo: upstream.
	self assert: orderedNodes second identicalTo: selected.
	self assert: orderedNodes last identicalTo: context
]



{ #category : 'tests' }
CgtThemeMatcherMondrianWidgetTests >> testIncludingContextNodePublishesSelectorChangedEvent [
	| root middle selected projection widget selectorChangedEvent |
	root := (CgtMatcherProjectionNode kind: #upstreamScope)
		representedElement: (self newTestElementWithId: #root);
		isInCurrentRule: true;
		matchById: true;
		yourself.
	middle := (CgtMatcherProjectionNode kind: #upstreamScope)
		representedElement: (self newTestElementWithId: #middle);
		isEditable: true;
		yourself.
	selected := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: (self newTestElementWithId: #selected);
		isInCurrentRule: true;
		matchById: true;
		yourself.
	projection := CgtMatcherProjection new.
	projection
		addNode: root;
		addNode: middle;
		addNode: selected;
		addRelation: (CgtMatcherProjectionRelation from: root to: middle kind: #context);
		addRelation: ((CgtMatcherProjectionRelation from: middle to: selected kind: #matcher)
			combinator: #descendant;
			yourself).
	widget := CgtThemeMatcherMondrianWidget new
		projection: projection;
		yourself.
	widget when: CgtMatcherSelectorChangedEvent do: [ :anEvent | selectorChangedEvent := anEvent ].
	widget includeProjectionNodeInCurrentRule: middle.
	self assert: selectorChangedEvent isNil.
	widget publishSelectorChanged.
	self assert: middle isInCurrentRule.
	self assert: selectorChangedEvent notNil.
	self assert: selectorChangedEvent selector displayString equals: '#root > CgtThemeSelectorTestElement descendant #selected'
]

{ #category : 'tests' }
CgtThemeMatcherMondrianWidgetTests >> testExcludingCurrentRuleNodeLeavesRemainingSelectorStable [
	| root middle selected projection widget selector |
	root := (CgtMatcherProjectionNode kind: #upstreamScope)
		representedElement: (self newTestElementWithId: #root);
		isInCurrentRule: true;
		matchById: true;
		yourself.
	middle := (CgtMatcherProjectionNode kind: #upstreamScope)
		representedElement: (self newTestElementWithId: #middle);
		isInCurrentRule: true;
		matchByClass: true;
		yourself.
	selected := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: (self newTestElementWithId: #selected);
		isInCurrentRule: true;
		matchById: true;
		yourself.
	projection := CgtMatcherProjection new.
	projection
		addNode: root;
		addNode: middle;
		addNode: selected;
		addRelation: ((CgtMatcherProjectionRelation from: root to: middle kind: #matcher)
			combinator: #child;
			yourself);
		addRelation: ((CgtMatcherProjectionRelation from: middle to: selected kind: #matcher)
			combinator: #descendant;
			yourself).
	widget := CgtThemeMatcherMondrianWidget new
		projection: projection;
		yourself.
	widget excludeProjectionNodeFromCurrentRule: middle.
	selector := widget currentSelector.
	self assert: selector displayString equals: '#root descendant #selected'
]

{ #category : 'private' }
CgtThemeMatcherMondrianWidgetTests >> newTestElementWithId: aSymbol [
	^ CgtThemeSelectorTestElement new
		id: (BlElementId named: aSymbol);
		yourself
]


{ #category : 'tests' }
CgtThemeMatcherMondrianWidgetTests >> testExpandingCompactedSectionRevealsContextNodesAndPreservesSelector [
	| root compacted selected projection relation widget selectorChangedEvent graphNodeElement |
	root := (CgtMatcherProjectionNode kind: #upstreamScope)
		representedElement: (self newTestElementWithId: #root);
		isInCurrentRule: true;
		matchById: true;
		yourself.
	compacted := (CgtMatcherProjectionNode kind: #compactedSection)
		representedElements: { (self newTestElementWithId: #middleOne). (self newTestElementWithId: #middleTwo) };
		hiddenNodeCount: 2;
		isEditable: false;
		yourself.
	selected := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: (self newTestElementWithId: #selected);
		isInCurrentRule: true;
		matchById: true;
		yourself.
	relation := (CgtMatcherProjectionRelation from: compacted to: selected kind: #matcher)
		combinator: #descendant;
		yourself.
	projection := CgtMatcherProjection new.
	projection selectedElement: selected representedElement.
	projection
		addNode: root;
		addNode: compacted;
		addNode: selected;
		addRelation: (CgtMatcherProjectionRelation from: root to: compacted kind: #compaction);
		addRelation: relation.
	widget := CgtThemeMatcherMondrianWidget new
		projection: projection;
		yourself.
	widget when: CgtMatcherSelectorChangedEvent do: [ :anEvent | selectorChangedEvent := anEvent ].
	graphNodeElement := widget graphElement graph nodeChildren second.
	graphNodeElement requestCompactedSectionExpansionFor: compacted.
	self assert: selectorChangedEvent notNil.
	self assert: (projection nodes anySatisfy: [ :each | each representedElement notNil and: [ each representedElement id = (BlElementId named: #middleOne) ] ]).
	self deny: (projection nodes includes: compacted).
	self assert: selectorChangedEvent selector displayString equals: '#root descendant #selected'
]

{ #category : 'tests' }
CgtThemeMatcherMondrianWidgetTests >> testForwardsCompactedSectionExpandedEvents [
	| compacted projection widget forwardedEvent graphNodeElement |
	projection := CgtMatcherProjection new.
	compacted := (CgtMatcherProjectionNode kind: #compactedSection)
		representedElements: { (self newTestElementWithId: #middle) };
		hiddenNodeCount: 1;
		isEditable: false;
		yourself.
	projection addNode: compacted.
	widget := CgtThemeMatcherMondrianWidget new
		projection: projection;
		yourself.
	widget when: CgtMatcherCompactedSectionExpandedEvent do: [ :anEvent | forwardedEvent := anEvent ].
	graphNodeElement := widget graphElement graph nodeChildren first.
	graphNodeElement requestCompactedSectionExpansionFor: compacted.
	self assert: forwardedEvent notNil.
	self assert: forwardedEvent projectionNode identicalTo: compacted
]


{ #category : 'tests' }
CgtThemeMatcherMondrianWidgetTests >> testForwardsMatcherNodeHoveredEvents [
	| node projection widget forwardedEvent graphNodeElement |
	projection := CgtMatcherProjection new.
	node := (CgtMatcherProjectionNode kind: #selectedElement)
		className: 'SelectedElement';
		yourself.
	projection addNode: node.
	widget := CgtThemeMatcherMondrianWidget new
		projection: projection;
		yourself.
	widget when: CgtMatcherNodeHoveredEvent do: [ :anEvent | forwardedEvent := anEvent ].
	graphNodeElement := widget graphElement graph nodeChildren first.
	graphNodeElement onNodeHovered: nil.
	self assert: forwardedEvent notNil.
	self assert: forwardedEvent projectionNode identicalTo: node
]

{ #category : 'tests' }
CgtThemeMatcherMondrianWidgetTests >> testForwardsMatcherNodeUnhoveredEvents [
	| node projection widget forwardedEvent graphNodeElement |
	projection := CgtMatcherProjection new.
	node := (CgtMatcherProjectionNode kind: #selectedElement)
		className: 'SelectedElement';
		yourself.
	projection addNode: node.
	widget := CgtThemeMatcherMondrianWidget new
		projection: projection;
		yourself.
	widget when: CgtMatcherNodeUnhoveredEvent do: [ :anEvent | forwardedEvent := anEvent ].
	graphNodeElement := widget graphElement graph nodeChildren first.
	graphNodeElement onNodeUnhovered: nil.
	self assert: forwardedEvent notNil.
	self assert: forwardedEvent projectionNode identicalTo: node
]


{ #category : 'tests' }
CgtThemeMatcherMondrianWidgetTests >> testUsesGapElementForCompactedSections [
	| root gap selected relation projection widget gapElement |
	root := (CgtMatcherProjectionNode kind: #upstreamScope)
		representedElement: (self newTestElementWithId: #root);
		isInCurrentRule: true;
		matchById: true;
		yourself.
	gap := (CgtMatcherProjectionNode kind: #compactedSection)
		hiddenNodeCount: 2;
		representedElements: { self newTestElementWithId: #middle1. self newTestElementWithId: #middle2 };
		isEditable: false;
		yourself.
	selected := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: (self newTestElementWithId: #selected);
		isInCurrentRule: true;
		matchById: true;
		yourself.
	relation := (CgtMatcherProjectionRelation from: gap to: selected kind: #matcher)
		combinator: #descendant;
		yourself.
	projection := CgtMatcherProjection new.
	projection
		addNode: root;
		addNode: gap;
		addNode: selected;
		addRelation: (CgtMatcherProjectionRelation from: root to: gap kind: #compaction);
		addRelation: relation.
	widget := CgtThemeMatcherMondrianWidget new
		projection: projection;
		yourself.
	gapElement := widget graphElement graph nodeChildren
		detect: [ :each | each isKindOf: CgtMatcherGapElement ]
		ifNone: [ nil ].
	self assert: gapElement notNil.
	self assert: gapElement projectionNode identicalTo: gap
]

{ #category : 'tests' }
CgtThemeMatcherMondrianWidgetTests >> testGapElementForwardsCombinatorChangedEvents [
	| gap selected projection relation widget forwardedEvent gapElement |
	gap := (CgtMatcherProjectionNode kind: #compactedSection)
		hiddenNodeCount: 2;
		representedElements: { self newTestElementWithId: #middle1. self newTestElementWithId: #middle2 };
		isEditable: false;
		yourself.
	selected := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: (self newTestElementWithId: #selected);
		isInCurrentRule: true;
		matchById: true;
		yourself.
	relation := (CgtMatcherProjectionRelation from: gap to: selected kind: #matcher)
		combinator: #child;
		yourself.
	projection := CgtMatcherProjection new.
	projection
		addNode: gap;
		addNode: selected;
		addRelation: relation.
	widget := CgtThemeMatcherMondrianWidget new
		projection: projection;
		yourself.
	widget when: CgtMatcherCombinatorChangedEvent do: [ :anEvent | forwardedEvent := anEvent ].
	gapElement := widget graphElement graph nodeChildren
		detect: [ :each | each isKindOf: CgtMatcherGapElement ]
		ifNone: [ nil ].
	gapElement requestCombinatorChange: #descendant.
	self assert: forwardedEvent notNil.
	self assert: forwardedEvent relation identicalTo: relation.
	self assert: relation combinator equals: #descendant
]
