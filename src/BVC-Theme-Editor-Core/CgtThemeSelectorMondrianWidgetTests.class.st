"
#Theme Selector Mondrian Widget Tests
I verify the Mondrian matcher widget skeleton and its explicit event forwarding. I am responsible for checking that passive matcher projections render as Mondrian nodes and that matcher-node events are forwarded by the widget without mutating selector state.
"
Class {
	#name : 'CgtThemeSelectorMondrianWidgetTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'private' }
CgtThemeSelectorMondrianWidgetTests >> newTestElementWithId: anId [
	^ CgtThemeSelectorTestElement new
		id: (BlElementId named: anId);
		yourself
]

{ #category : 'tests' }
CgtThemeSelectorMondrianWidgetTests >> testBuildsMondrianGraphFromProjection [
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
	widget := CgtThemeSelectorMondrianWidget new
		projection: projection;
		yourself.
	self assert: widget mondrian notNil.
	self assert: widget graphElement notNil.
	self assert: widget graphElement graph nodeChildren size equals: 2.
	self assert: widget graphElement graph edgeChildren size equals: 1
]

{ #category : 'tests' }
CgtThemeSelectorMondrianWidgetTests >> testUsesCustomNodeStencilElement [
	| node projection widget graphNodeElement |
	projection := CgtMatcherProjection new.
	node := (CgtMatcherProjectionNode kind: #selectedElement)
		className: 'SelectedElement';
		elementId: (BlElementId named: #selected);
		isInCurrentRule: true;
		matchByClass: true;
		yourself.
	projection addNode: node.
	widget := CgtThemeSelectorMondrianWidget new
		projection: projection;
		yourself.
	graphNodeElement := widget graphElement graph nodeChildren first.
	self assert: (graphNodeElement isKindOf: CgtMatcherNodeElement).
	self assert: graphNodeElement projectionNode identicalTo: node
]

{ #category : 'tests' }
CgtThemeSelectorMondrianWidgetTests >> testForwardsMatcherNodeEditEvents [
	| node projection widget forwardedEvent graphNodeElement |
	projection := CgtMatcherProjection new.
	node := (CgtMatcherProjectionNode kind: #selectedElement)
		className: 'SelectedElement';
		elementId: (BlElementId named: #selected);
		isInCurrentRule: true;
		matchByClass: false;
		yourself.
	projection addNode: node.
	widget := CgtThemeSelectorMondrianWidget new
		projection: projection;
		yourself.
	widget when: CgtMatcherClassMatchToggledEvent do: [ :anEvent | forwardedEvent := anEvent ].
	graphNodeElement := widget graphElement graph nodeChildren first.
	graphNodeElement requestClassMatchToggleFor: node.
	self assert: forwardedEvent notNil.
	self assert: forwardedEvent projectionNode identicalTo: node.
	self assert: forwardedEvent shouldMatch.
	self deny: node matchByClass
]

{ #category : 'tests' }
CgtThemeSelectorMondrianWidgetTests >> testForwardsMatcherCombinatorChangedEvents [
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
	widget := CgtThemeSelectorMondrianWidget new
		projection: projection;
		yourself.
	widget when: CgtMatcherCombinatorChangedEvent do: [ :anEvent | forwardedEvent := anEvent ].
	graphNodeElement := widget graphElement graph nodeChildren second.
	graphNodeElement requestCombinatorChange: #descendant.
	self assert: forwardedEvent notNil.
	self assert: forwardedEvent relation identicalTo: relation.
	self assert: forwardedEvent combinator equals: #descendant.
	self assert: relation combinator equals: #child
]

{ #category : 'tests' }
CgtThemeSelectorMondrianWidgetTests >> testOrdersCurrentRuleNodesBeforeContextNodesForRendering [
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
	widget := CgtThemeSelectorMondrianWidget new
		projection: projection;
		yourself.
	orderedNodes := widget orderedNodesForRendering.
	self assert: orderedNodes first identicalTo: upstream.
	self assert: orderedNodes second identicalTo: selected.
	self assert: orderedNodes last identicalTo: context
]


{ #category : 'tests' }
CgtThemeSelectorMondrianWidgetTests >> testUsesOtherRuleIndicatorElementForIndicatorNode [
	| projection node widget graphNodeElement |
	projection := CgtMatcherProjection new.
	node := (CgtMatcherProjectionNode kind: #otherRuleIndicator)
		hiddenNodeCount: 2;
		isEditable: false;
		yourself.
	projection addNode: node.
	widget := CgtThemeSelectorMondrianWidget new
		projection: projection;
		yourself.
	graphNodeElement := widget graphElement graph nodeChildren first.
	self assert: (graphNodeElement isKindOf: CgtMatcherOtherRuleIndicatorElement).
	self assert: graphNodeElement projectionNode identicalTo: node
]

{ #category : 'tests' }
CgtThemeSelectorMondrianWidgetTests >> testForwardsOtherRuleContextToggledEvents [
	| projection node widget forwardedEvent graphNodeElement |
	projection := CgtMatcherProjection new.
	node := (CgtMatcherProjectionNode kind: #otherRuleIndicator)
		hiddenNodeCount: 1;
		isEditable: false;
		yourself.
	projection addNode: node.
	widget := CgtThemeSelectorMondrianWidget new
		projection: projection;
		yourself.
	widget when: CgtMatcherOtherRuleContextToggledEvent do: [ :anEvent | forwardedEvent := anEvent ].
	graphNodeElement := widget graphElement graph nodeChildren first.
	graphNodeElement requestOtherRuleContextToggle.
	self assert: forwardedEvent notNil
]
