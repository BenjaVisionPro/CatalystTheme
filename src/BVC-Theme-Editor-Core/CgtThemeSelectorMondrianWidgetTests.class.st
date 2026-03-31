"
#Theme Selector Mondrian Widget Tests
I verify the Mondrian selector renderer skeleton and its explicit event forwarding. I am responsible for checking that passive selector projections render as Mondrian nodes and that node events are forwarded by the widget without mutating selector state.
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
	widget when: CgtThemeSelectorClassMatchChangedEvent do: [ :anEvent | forwardedEvent := anEvent ].
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
	widget when: CgtThemeSelectorCombinatorChangedEvent do: [ :anEvent | forwardedEvent := anEvent ].
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
	widget when: CgtThemeSelectorOtherRuleContextToggledEvent do: [ :anEvent | forwardedEvent := anEvent ].
	graphNodeElement := widget graphElement graph nodeChildren first.
	graphNodeElement requestOtherRuleContextToggle.
	self assert: forwardedEvent notNil
]


{ #category : 'tests' }
CgtThemeSelectorMondrianWidgetTests >> testConfigureEdgeConnectionsUsesLayoutPolicyOrientation [
	| widget policy |
	widget := CgtThemeSelectorMondrianWidget new.
	policy := CgtMatcherLayoutPolicy new.
	self assert: policy corridorOrientation equals: #vertical.
	self assert: (policy edgeConnectionSelectorsForOrientation: policy corridorOrientation) equals: #(fromCenterBottom toCenterTop)
]


{ #category : 'tests' }
CgtThemeSelectorMondrianWidgetTests >> testStructuralRefreshRevealOffsetUsesLeadingCompactedGapOnly [
	| projection leadingGap selected relation widget |
	leadingGap := (CgtMatcherProjectionNode kind: #compactedSection)
		hiddenNodeCount: 2;
		yourself.
	selected := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: (self newTestElementWithId: #selected);
		isInCurrentRule: true;
		yourself.
	relation := CgtMatcherProjectionRelation from: leadingGap to: selected kind: #compaction.
	projection := CgtMatcherProjection new.
	projection
		selectedElement: selected representedElement;
		addNode: leadingGap;
		addNode: selected;
		addRelation: relation.
	widget := CgtThemeSelectorMondrianWidget new
		projection: projection;
		yourself.
	self assert: widget structuralRefreshRevealOffset equals: (0 @ -24).
	self assert: widget structuralRefreshAnchorProjectionNode identicalTo: selected
]

{ #category : 'tests' }
CgtThemeSelectorMondrianWidgetTests >> testStructuralRefreshRevealOffsetStaysFixedForTrailingOnlyGap [
	| projection selected trailingGap relation widget |
	selected := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: (self newTestElementWithId: #selected);
		isInCurrentRule: true;
		yourself.
	trailingGap := (CgtMatcherProjectionNode kind: #compactedSection)
		hiddenNodeCount: 2;
		yourself.
	relation := CgtMatcherProjectionRelation from: selected to: trailingGap kind: #compaction.
	projection := CgtMatcherProjection new.
	projection
		selectedElement: selected representedElement;
		addNode: selected;
		addNode: trailingGap;
		addRelation: relation.
	widget := CgtThemeSelectorMondrianWidget new
		projection: projection;
		yourself.
	self assert: widget structuralRefreshRevealOffset equals: (0 @ 0).
	self assert: widget structuralRefreshAnchorProjectionNode identicalTo: selected
]


{ #category : 'tests' }
CgtThemeSelectorMondrianWidgetTests >> testStructuralRefreshQueriesTransitionPolicyForAnchorAndOffset [
	| projection leadingGap selected relation widget policy |
	leadingGap := (CgtMatcherProjectionNode kind: #compactedSection)
		hiddenNodeCount: 2;
		yourself.
	selected := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: (self newTestElementWithId: #selected);
		isInCurrentRule: true;
		yourself.
	relation := CgtMatcherProjectionRelation from: leadingGap to: selected kind: #compaction.
	projection := CgtMatcherProjection new.
	projection
		selectedElement: selected representedElement;
		addNode: leadingGap;
		addNode: selected;
		addRelation: relation.
	widget := CgtThemeSelectorMondrianWidget new.
	policy := CgtMatcherTransitionPolicy new.
	widget
		projection: projection;
		instVarNamed: 'transitionPolicy' put: policy.
	self assert: widget structuralRefreshRevealOffset equals: (policy structuralRefreshRevealOffsetForProjection: projection orientation: #vertical).
	self assert: widget structuralRefreshAnchorProjectionNode identicalTo: (policy structuralRefreshAnchorProjectionNodeFor: projection)
]


{ #category : 'tests' }
CgtThemeSelectorMondrianWidgetTests >> test_projectionChangeBuildsStructuralRefreshPlanFromPreviousProjection [
	| widget oldProjection newProjection oldSelected newSelected leadingGap selectedNode |
	widget := CgtThemeSelectorMondrianWidget new.
	oldSelected := CgtThemeSelectorTestElement new className: 'Selected'; yourself.
	newSelected := CgtThemeSelectorTestElement new className: 'Selected'; yourself.
	oldProjection := CgtMatcherProjection new.
	oldProjection
		selectedElement: oldSelected;
		addNode: ((CgtMatcherProjectionNode kind: #selectedElement)
			representedElement: oldSelected;
			yourself).
	widget projection: oldProjection.
	newProjection := CgtMatcherProjection new.
	leadingGap := (CgtMatcherProjectionNode kind: #compactedSection)
		representedElements: { CgtThemeSelectorTestElement new className: 'Hidden'; yourself };
		gapIdentity: #(hiddenGap);
		yourself.
	selectedNode := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: newSelected;
		yourself.
	newProjection
		selectedElement: newSelected;
		addNode: leadingGap;
		addNode: selectedNode;
		addRelation: (CgtMatcherProjectionRelation
			from: leadingGap
			to: selectedNode
			kind: #compaction).
	widget projection: newProjection.
	self assert: widget lastStructuralRefreshPlan notNil.
	self assert: widget lastStructuralRefreshPlan isReveal
]


{ #category : 'tests' }
CgtThemeSelectorMondrianWidgetTests >> testStructuralRefreshAnimationUsesPlanSpecificDurationsAndOpacity [
	| widget revealPlan stablePlan |
	widget := CgtThemeSelectorMondrianWidget new.
	revealPlan := CgtMatcherStructuralRefreshPlan new transitionKind: #reveal; yourself.
	stablePlan := CgtMatcherStructuralRefreshPlan new transitionKind: #stable; yourself.
	widget instVarNamed: 'lastStructuralRefreshPlan' put: revealPlan.
	self assert: widget structuralRefreshAnimationDuration equals: widget transitionPolicy revealDuration.
	self assert: widget structuralRefreshStartOpacity equals: widget transitionPolicy graphRevealStartOpacity.
	widget instVarNamed: 'lastStructuralRefreshPlan' put: stablePlan.
	self assert: widget structuralRefreshAnimationDuration equals: widget transitionPolicy structuralRefreshDuration.
	self assert: widget structuralRefreshStartOpacity equals: widget transitionPolicy graphRevealEndOpacity.
	self assert: widget structuralRefreshEndOpacity equals: widget transitionPolicy graphRevealEndOpacity
]


{ #category : 'tests' }
CgtThemeSelectorMondrianWidgetTests >> testStableProjectionRefreshDoesNotStartStructuralRefreshAnimation [
	| widget oldProjection newProjection oldSelected newSelected |
	widget := CgtThemeSelectorMondrianWidget new.
	oldSelected := CgtThemeSelectorTestElement new className: 'Selected'; yourself.
	newSelected := CgtThemeSelectorTestElement new className: 'Selected'; yourself.
	oldProjection := CgtMatcherProjection new.
	oldProjection
		selectedElement: oldSelected;
		addNode: ((CgtMatcherProjectionNode kind: #selectedElement)
			representedElement: oldSelected;
			yourself).
	widget projection: oldProjection.
	newProjection := CgtMatcherProjection new.
	newProjection
		selectedElement: newSelected;
		addNode: ((CgtMatcherProjectionNode kind: #selectedElement)
			representedElement: newSelected;
			yourself).
	widget projection: newProjection.
	self assert: widget lastStructuralRefreshPlan notNil.
	self assert: widget lastStructuralRefreshPlan isStable.
	self assert: widget structuralRefreshAnimationToken equals: 0
]


{ #category : 'tests' }
CgtThemeSelectorMondrianWidgetTests >> testReplacePlanUsesFullOpacityAndReplaceDuration [
	| widget |
	widget := CgtThemeSelectorMondrianWidget new.
	widget instVarNamed: 'lastStructuralRefreshPlan' put: (CgtMatcherStructuralRefreshPlan new transitionKind: #replace; yourself).
	self assert: widget structuralRefreshAnimationDuration equals: widget transitionPolicy replaceDuration.
	self assert: widget structuralRefreshStartOpacity equals: widget transitionPolicy graphRevealEndOpacity.
	self assert: widget structuralRefreshEndOpacity equals: widget transitionPolicy graphRevealEndOpacity
]
