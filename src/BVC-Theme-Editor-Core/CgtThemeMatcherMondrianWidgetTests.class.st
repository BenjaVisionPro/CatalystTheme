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
