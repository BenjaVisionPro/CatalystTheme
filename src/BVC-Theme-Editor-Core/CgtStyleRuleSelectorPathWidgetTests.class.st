"
#Style Rule Selector Path Widget Tests
I verify the static skeleton of the custom style-rule selector path widget. I check that a supplied projection is assembled into row, gap, and other-rule indicator elements and that those elements forward selector-facing events without owning selector semantics.
"
Class {
	#name : 'CgtStyleRuleSelectorPathWidgetTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'private' }
CgtStyleRuleSelectorPathWidgetTests >> newProjectionWithUpstreamSelectedAndIndicator [
	| projection upstream selected relation indicator |
	projection := CgtMatcherProjection new.
	upstream := (CgtMatcherProjectionNode kind: #upstreamScope)
		className: 'RootElement';
		elementId: (BlElementId named: #root);
		isInCurrentRule: true;
		matchById: true;
		yourself.
	selected := (CgtMatcherProjectionNode kind: #selectedElement)
		className: 'SelectedElement';
		elementId: (BlElementId named: #selected);
		isInCurrentRule: true;
		matchByClass: true;
		yourself.
	indicator := (CgtMatcherProjectionNode kind: #otherRuleIndicator)
		hiddenNodeCount: 2;
		isEditable: false;
		yourself.
	relation := (CgtMatcherProjectionRelation from: upstream to: selected kind: #matcher)
		combinator: #child;
		yourself.
	projection
		addNode: upstream;
		addNode: selected;
		addNode: indicator;
		addRelation: relation.
	^ projection
]

{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testRefreshContentsBuildsRowsAndIndicatorFromProjection [
	<gtExample>
	| projection widget rowElements indicatorElements |
	projection := self newProjectionWithUpstreamSelectedAndIndicator.
	widget := CgtStyleRuleSelectorPathWidget new
		projection: projection;
		yourself.
	self assert: widget renderItems size equals: 3.
	rowElements := widget rowsContainer children select: [ :each | each isKindOf: CgtMatcherRowElement ].
	indicatorElements := widget rowsContainer children select: [ :each | each isKindOf: CgtMatcherOtherRuleIndicatorElement ].
	self assert: rowElements size equals: 2.
	self assert: indicatorElements size equals: 1.
	self assert: rowElements first projectionNode kind equals: #upstreamScope.
	self assert: rowElements second projectionNode kind equals: #selectedElement.
	^ widget
]

{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testRefreshContentsBuildsGapElementForCompactedNode [
	<gtExample>
	| projection leadingGap selected relation widget gapElements |
	projection := CgtMatcherProjection new.
	leadingGap := (CgtMatcherProjectionNode kind: #compactedSection)
		gapIdentity: #leadingGap;
		hiddenNodeCount: 2;
		yourself.
	selected := (CgtMatcherProjectionNode kind: #selectedElement)
		className: 'SelectedElement';
		elementId: (BlElementId named: #selected);
		isInCurrentRule: true;
		yourself.
	relation := (CgtMatcherProjectionRelation from: leadingGap to: selected kind: #compaction)
		combinator: #child;
		yourself.
	projection
		addNode: leadingGap;
		addNode: selected;
		addRelation: relation.
	widget := CgtStyleRuleSelectorPathWidget new
		projection: projection;
		yourself.
	gapElements := widget rowsContainer children select: [ :each | each isKindOf: CgtMatcherGapElement ].
	self assert: gapElements size equals: 1.
	self assert: gapElements first projectionNode identicalTo: leadingGap.
	^ widget
]

{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testForwardsRowSelectionEventAsSelectorNodeSelectedEvent [
	<gtExample>
	| projection widget forwardedEvent rowElement |
	projection := self newProjectionWithUpstreamSelectedAndIndicator.
	widget := CgtStyleRuleSelectorPathWidget new
		projection: projection;
		yourself.
	widget when: CgtThemeSelectorNodeSelectedEvent do: [ :anEvent | forwardedEvent := anEvent ].
	rowElement := (widget rowsContainer children detect: [ :each |
		(each isKindOf: CgtMatcherRowElement) and: [ each projectionNode kind = #selectedElement ] ]).
	rowElement onMouseSelect: nil.
	self assert: forwardedEvent notNil.
	self assert: forwardedEvent projectionNode identicalTo: rowElement projectionNode.
	^ widget
]

{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testForwardsGapExpansionEventAsSelectorCompactedSectionExpandedEvent [
	<gtExample>
	| projection leadingGap selected relation widget forwardedEvent gapElement |
	projection := CgtMatcherProjection new.
	leadingGap := (CgtMatcherProjectionNode kind: #compactedSection)
		gapIdentity: #leadingGap;
		hiddenNodeCount: 2;
		yourself.
	selected := (CgtMatcherProjectionNode kind: #selectedElement)
		className: 'SelectedElement';
		elementId: (BlElementId named: #selected);
		isInCurrentRule: true;
		yourself.
	relation := (CgtMatcherProjectionRelation from: leadingGap to: selected kind: #compaction)
		combinator: #child;
		yourself.
	projection
		addNode: leadingGap;
		addNode: selected;
		addRelation: relation.
	widget := CgtStyleRuleSelectorPathWidget new
		projection: projection;
		yourself.
	widget when: CgtThemeSelectorCompactedSectionExpandedEvent do: [ :anEvent | forwardedEvent := anEvent ].
	gapElement := widget rowsContainer children detect: [ :each | each isKindOf: CgtMatcherGapElement ].
	gapElement requestCompactedSectionExpansionFor: leadingGap.
	self assert: forwardedEvent notNil.
	self assert: forwardedEvent projectionNode identicalTo: leadingGap.
	^ widget
]


{ #category : 'private' }
CgtStyleRuleSelectorPathWidgetTests >> newProjectionWithLeadingGapSelectedTrailingGapChildAndIndicator [
	| projection leadingGap selected trailingGap child indicator |
	projection := CgtMatcherProjection new.
	leadingGap := (CgtMatcherProjectionNode kind: #compactedSection)
		gapIdentity: #leadingGap;
		hiddenNodeCount: 2;
		yourself.
	selected := (CgtMatcherProjectionNode kind: #selectedElement)
		className: 'SelectedElement';
		elementId: (BlElementId named: #selected);
		isInCurrentRule: true;
		matchByClass: true;
		yourself.
	trailingGap := (CgtMatcherProjectionNode kind: #compactedSection)
		gapIdentity: #trailingGap;
		hiddenNodeCount: 1;
		yourself.
	child := (CgtMatcherProjectionNode kind: #selectedChildScope)
		className: 'ChildElement';
		elementId: (BlElementId named: #child);
		isInCurrentRule: true;
		matchById: true;
		yourself.
	indicator := (CgtMatcherProjectionNode kind: #otherRuleIndicator)
		hiddenNodeCount: 3;
		isEditable: false;
		yourself.
	projection
		addNode: leadingGap;
		addNode: selected;
		addNode: trailingGap;
		addNode: child;
		addNode: indicator;
		addRelation: ((CgtMatcherProjectionRelation from: leadingGap to: selected kind: #compaction)
			combinator: #child;
			yourself);
		addRelation: ((CgtMatcherProjectionRelation from: selected to: trailingGap kind: #compaction)
			combinator: #child;
			yourself);
		addRelation: ((CgtMatcherProjectionRelation from: trailingGap to: child kind: #matcher)
			combinator: #descendant;
			yourself);
		addRelation: (CgtMatcherProjectionRelation from: selected to: indicator kind: #otherRule).
	^ projection
]

{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testBuildRenderItemsCentersSequenceOnSelectedNodeAndPlacesIndicatorAfterIt [
	<gtExample>
	| projection widget items |
	projection := self newProjectionWithLeadingGapSelectedTrailingGapChildAndIndicator.
	widget := CgtStyleRuleSelectorPathWidget new
		projection: projection;
		yourself.
	items := widget renderItems asArray.
	self assert: items size equals: 5.
	self assert: items first isGapItem.
	self assert: items second isRowItem.
	self assert: items second projectionNode kind equals: #selectedElement.
	self assert: items third isOtherRuleIndicatorItem.
	self assert: items fourth isGapItem.
	self assert: items fifth isRowItem.
	self assert: items fifth projectionNode kind equals: #selectedChildScope.
	^ widget
]

{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testGapRenderItemsUseLeadingAndTrailingDirections [
	<gtExample>
	| projection widget gapItems |
	projection := self newProjectionWithLeadingGapSelectedTrailingGapChildAndIndicator.
	widget := CgtStyleRuleSelectorPathWidget new
		projection: projection;
		yourself.
	gapItems := widget renderItems select: [ :each | each isGapItem ].
	self assert: gapItems size equals: 2.
	self assert: gapItems first direction equals: #upstream.
	self assert: gapItems second direction equals: #downstream.
	^ widget
]


{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testSelectedRenderItemIsAlwaysMarkedInScope [
	<gtExample>
	| projection widget selectedItem |
	projection := CgtMatcherProjection new.
	projection addNode: ((CgtMatcherProjectionNode kind: #selectedElement)
		className: 'SelectedElement';
		elementId: (BlElementId named: #selected);
		isInCurrentRule: false;
		yourself).
	widget := CgtStyleRuleSelectorPathWidget new
		projection: projection;
		yourself.
	selectedItem := widget renderItems detect: [ :each | each isRowItem and: [ each isSelected ] ].
	self assert: selectedItem isInScope.
	self deny: selectedItem isRevealedContext.
	^ widget
]

{ #category : 'private' }
CgtStyleRuleSelectorPathWidgetTests >> newProjectionWithExpandedLeadingContextBetweenUpstreamAndSelected [
	| projection upstream revealed selected upstreamElement revealedElement selectedElement |
	projection := CgtMatcherProjection new.
	upstreamElement := CgtThemeSelectorTestElement named: #upstream id: #upstream.
	revealedElement := CgtThemeSelectorTestElement named: #revealedUpstream id: #revealedUpstream.
	selectedElement := CgtThemeSelectorTestElement named: #selected id: #selected.
	upstream := (CgtMatcherProjectionNode kind: #upstreamScope)
		representedElement: upstreamElement;
		isInCurrentRule: true;
		matchByClass: true;
		yourself.
	revealed := (CgtMatcherProjectionNode kind: #upstreamScope)
		representedElement: revealedElement;
		isInCurrentRule: false;
		matchByClass: false;
		matchById: false;
		yourself.
	selected := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: selectedElement;
		isInCurrentRule: true;
		matchById: true;
		yourself.
	projection
		addNode: upstream;
		addNode: revealed;
		addNode: selected;
		addRelation: (CgtMatcherProjectionRelation from: upstream to: revealed kind: #context);
		addRelation: ((CgtMatcherProjectionRelation from: revealed to: selected kind: #matcher)
			combinator: #descendant;
			yourself).
	^ projection
]

{ #category : 'private' }
CgtStyleRuleSelectorPathWidgetTests >> newProjectionWithExpandedTrailingContextBetweenSelectedAndChild [
	| projection selected revealed child selectedElement revealedElement childElement |
	projection := CgtMatcherProjection new.
	selectedElement := CgtThemeSelectorTestElement named: #selected id: #selected.
	revealedElement := CgtThemeSelectorTestElement named: #revealedChild id: #revealedChild.
	childElement := CgtThemeSelectorTestElement named: #child id: #child.
	selected := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: selectedElement;
		isInCurrentRule: true;
		matchByClass: true;
		yourself.
	revealed := (CgtMatcherProjectionNode kind: #selectedChildScope)
		representedElement: revealedElement;
		isInCurrentRule: false;
		matchByClass: false;
		matchById: false;
		yourself.
	child := (CgtMatcherProjectionNode kind: #selectedChildScope)
		representedElement: childElement;
		isInCurrentRule: true;
		matchById: true;
		yourself.
	projection
		addNode: selected;
		addNode: revealed;
		addNode: child;
		addRelation: (CgtMatcherProjectionRelation from: selected to: revealed kind: #context);
		addRelation: ((CgtMatcherProjectionRelation from: revealed to: child kind: #matcher)
			combinator: #descendant;
			yourself).
	^ projection
]

{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testExpandedLeadingContextNodesAreInsertedAsRevealedRows [
	<gtExample>
	| projection widget items revealedItem |
	projection := self newProjectionWithExpandedLeadingContextBetweenUpstreamAndSelected.
	widget := CgtStyleRuleSelectorPathWidget new
		projection: projection;
		yourself.
	items := widget renderItems asArray.
	self assert: items size equals: 3.
	self assert: items first isRowItem.
	self assert: items first isInScope.
	self assert: items second isRowItem.
	revealedItem := items second.
	self assert: revealedItem isRevealedContext.
	self deny: revealedItem isInScope.
	self assert: items third isRowItem.
	self assert: items third isSelected.
	^ widget
]

{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testExpandedTrailingContextNodesAreInsertedAsRevealedRows [
	<gtExample>
	| projection widget items revealedItem |
	projection := self newProjectionWithExpandedTrailingContextBetweenSelectedAndChild.
	widget := CgtStyleRuleSelectorPathWidget new
		projection: projection;
		yourself.
	items := widget renderItems asArray.
	self assert: items size equals: 3.
	self assert: items first isRowItem.
	self assert: items first isSelected.
	self assert: items second isRowItem.
	revealedItem := items second.
	self assert: revealedItem isRevealedContext.
	self deny: revealedItem isInScope.
	self assert: items third isRowItem.
	self assert: items third isInScope.
	self deny: items third isRevealedContext.
	^ widget
]
