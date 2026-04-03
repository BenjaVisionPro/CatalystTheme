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
	| projection selected widget rowItem |
	projection := CgtMatcherProjection new.
	selected := (CgtMatcherProjectionNode kind: #selectedElement)
		className: 'SelectedElement';
		elementId: (BlElementId named: #selected);
		isInCurrentRule: false;
		yourself.
	projection addNode: selected.
	widget := CgtStyleRuleSelectorPathWidget new
		projection: projection;
		yourself.
	rowItem := widget renderItems first.
	self assert: rowItem isRowItem.
	self assert: rowItem isSelected.
	self assert: rowItem isInScope.
	self deny: rowItem isRevealedContext.
	^ widget
]


{ #category : 'private' }
CgtStyleRuleSelectorPathWidgetTests >> newProjectionWithManyRevealedLeadingContextNodes [
	| projection previous selected selectedElement |
	projection := CgtMatcherProjection new.
	1 to: 8 do: [ :index |
		| element node |
		element := CgtThemeSelectorTestElement new
			className: 'ContextElement', index asString;
			id: (BlElementId named: ('context', index asString) asSymbol);
			yourself.
		node := (CgtMatcherProjectionNode kind: #upstreamScope)
			representedElement: element;
			isInCurrentRule: false;
			yourself.
		projection addNode: node.
		previous ifNotNil: [ projection addRelation: (CgtMatcherProjectionRelation from: previous to: node kind: #context) ].
		previous := node ].
	selectedElement := CgtThemeSelectorTestElement new
		className: 'SelectedElement';
		id: (BlElementId named: #selected);
		yourself.
	selected := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: selectedElement;
		isInCurrentRule: true;
		yourself.
	projection
		addNode: selected;
		addRelation: (CgtMatcherProjectionRelation from: previous to: selected kind: #context);
		selectedElement: selectedElement.
	^ projection
]

{ #category : 'private' }
CgtStyleRuleSelectorPathWidgetTests >> newProjectionWithRevealedLeadingContext [
	| projection root middle selected rootElement middleElement selectedElement |
	projection := CgtMatcherProjection new.
	rootElement := CgtThemeSelectorTestElement new
		className: 'RootElement';
		id: (BlElementId named: #root);
		yourself.
	middleElement := CgtThemeSelectorTestElement new
		className: 'MiddleElement';
		id: (BlElementId named: #middle);
		yourself.
	selectedElement := CgtThemeSelectorTestElement new
		className: 'SelectedElement';
		id: (BlElementId named: #selected);
		yourself.
	root := (CgtMatcherProjectionNode kind: #upstreamScope)
		representedElement: rootElement;
		isInCurrentRule: false;
		yourself.
	middle := (CgtMatcherProjectionNode kind: #upstreamScope)
		representedElement: middleElement;
		isInCurrentRule: false;
		yourself.
	selected := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: selectedElement;
		isInCurrentRule: true;
		yourself.
	projection
		addNode: root;
		addNode: middle;
		addNode: selected;
		addRelation: (CgtMatcherProjectionRelation from: root to: middle kind: #context);
		addRelation: (CgtMatcherProjectionRelation from: middle to: selected kind: #context);
		selectedElement: selectedElement.
	^ projection
]

{ #category : 'private' }
CgtStyleRuleSelectorPathWidgetTests >> newProjectionWithRevealedTrailingContext [
	| projection selected child grandchild selectedElement childElement grandchildElement |
	projection := CgtMatcherProjection new.
	selectedElement := CgtThemeSelectorTestElement new
		className: 'SelectedElement';
		id: (BlElementId named: #selected);
		yourself.
	childElement := CgtThemeSelectorTestElement new
		className: 'ChildElement';
		id: (BlElementId named: #child);
		yourself.
	grandchildElement := CgtThemeSelectorTestElement new
		className: 'GrandchildElement';
		id: (BlElementId named: #grandchild);
		yourself.
	selected := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: selectedElement;
		isInCurrentRule: true;
		yourself.
	child := (CgtMatcherProjectionNode kind: #selectedChildScope)
		representedElement: childElement;
		isInCurrentRule: false;
		yourself.
	grandchild := (CgtMatcherProjectionNode kind: #selectedChildScope)
		representedElement: grandchildElement;
		isInCurrentRule: false;
		yourself.
	projection
		addNode: selected;
		addNode: child;
		addNode: grandchild;
		addRelation: (CgtMatcherProjectionRelation from: selected to: child kind: #context);
		addRelation: (CgtMatcherProjectionRelation from: child to: grandchild kind: #context);
		selectedElement: selectedElement.
	^ projection
]

{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testBuildRenderItemsGroupsRevealedLeadingContextIntoRevealItem [
	<gtExample>
	| projection widget items revealItem |
	projection := self newProjectionWithRevealedLeadingContext.
	widget := CgtStyleRuleSelectorPathWidget new
		projection: projection;
		yourself.
	items := widget renderItems asArray.
	self assert: items size equals: 2.
	self assert: items first isRevealItem.
	revealItem := items first.
	self assert: revealItem direction equals: #upstream.
	self assert: revealItem rowItems size equals: 2.
	self assert: (revealItem rowItems allSatisfy: [ :each | each isRevealedContext ]).
	self assert: items second isRowItem.
	self assert: items second isSelected.
	^ widget
]

{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testBuildRenderItemsGroupsRevealedTrailingContextIntoRevealItem [
	<gtExample>
	| projection widget items revealItem |
	projection := self newProjectionWithRevealedTrailingContext.
	widget := CgtStyleRuleSelectorPathWidget new
		projection: projection;
		yourself.
	items := widget renderItems asArray.
	self assert: items size equals: 2.
	self assert: items first isRowItem.
	self assert: items first isSelected.
	self assert: items second isRevealItem.
	revealItem := items second.
	self assert: revealItem direction equals: #downstream.
	self assert: revealItem rowItems size equals: 2.
	self assert: (revealItem rowItems allSatisfy: [ :each | each isRevealedContext ]).
	^ widget
]

{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testRefreshContentsBuildsRevealElementForGroupedRevealedContext [
	<gtExample>
	| projection widget revealElements revealRows |
	projection := self newProjectionWithRevealedLeadingContext.
	widget := CgtStyleRuleSelectorPathWidget new
		projection: projection;
		yourself.
	revealElements := widget rowsContainer children select: [ :each | each isKindOf: CgtMatcherRevealElement ].
	self assert: revealElements size equals: 1.
	revealRows := revealElements first rowElements.
	self assert: revealRows size equals: 2.
	self assert: (revealRows allSatisfy: [ :each | each projectionNode isInCurrentRule not ]).
	^ widget
]

{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testRevealElementHostsRowsInDedicatedContentContainer [
	<gtExample>
	| projection widget revealElement |
	projection := self newProjectionWithRevealedLeadingContext.
	widget := CgtStyleRuleSelectorPathWidget new
		projection: projection;
		yourself.
	revealElement := widget rowsContainer children detect: [ :each | each isKindOf: CgtMatcherRevealElement ].
	self assert: revealElement contentContainer children isEmpty.
	self assert: revealElement rowElements size equals: 2.
	^ widget
]


{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testRefreshContentsBuildsRevealElementWithViewportContainer [
	<gtExample>
	| projection widget revealElement |
	projection := self newProjectionWithRevealedLeadingContext.
	widget := CgtStyleRuleSelectorPathWidget new
		projection: projection;
		yourself.
	revealElement := widget rowsContainer children detect: [ :each | each isKindOf: CgtMatcherRevealElement ].
	self assert: revealElement viewportContainer children size equals: 1.
	self assert: revealElement viewportContainer children first identicalTo: revealElement viewportContentContainer.
	self assert: revealElement viewportContentContainer children second identicalTo: revealElement contentContainer.
	^ widget
]

{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testProjectionRefreshComputesRevealStructuralRefreshPlan [
	<gtExample>
	| widget |
	widget := CgtStyleRuleSelectorPathWidget new.
	widget projection: self newProjectionWithUpstreamSelectedAndIndicator.
	widget projection: self newProjectionWithRevealedLeadingContext.
	self assert: widget structuralRefreshPlan isReveal.
	self assert: widget structuralRefreshPlan revealOffset equals: (0 @ -24).
	^ widget
]

{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testRevealElementReceivesStructuralRefreshPlanAndTransitionPolicy [
	<gtExample>
	| widget revealElement |
	widget := CgtStyleRuleSelectorPathWidget new.
	widget projection: self newProjectionWithUpstreamSelectedAndIndicator.
	widget projection: self newProjectionWithRevealedLeadingContext.
	revealElement := widget rowsContainer children detect: [ :each | each isKindOf: CgtMatcherRevealElement ].
	self assert: revealElement structuralRefreshPlan identicalTo: widget structuralRefreshPlan.
	self assert: revealElement transitionPolicy class equals: CgtMatcherTransitionPolicy.
	^ widget
]


{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testRevealElementExposesFixedEdgeAndOpeningDirectionForLeadingContext [
	<gtExample>
	| projection widget revealElement |
	projection := self newProjectionWithRevealedLeadingContext.
	widget := CgtStyleRuleSelectorPathWidget new
		projection: projection;
		yourself.
	revealElement := widget rowsContainer children detect: [ :each | each isKindOf: CgtMatcherRevealElement ].
	self assert: revealElement isUpstreamReveal.
	self assert: revealElement fixedEdge equals: #bottom.
	self assert: revealElement openingDirection equals: #up.
	^ widget
]

{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testRevealElementExposesFixedEdgeAndOpeningDirectionForTrailingContext [
	<gtExample>
	| projection widget revealElement |
	projection := self newProjectionWithRevealedTrailingContext.
	widget := CgtStyleRuleSelectorPathWidget new
		projection: projection;
		yourself.
	revealElement := widget rowsContainer children detect: [ :each | each isKindOf: CgtMatcherRevealElement ].
	self assert: revealElement isDownstreamReveal.
	self assert: revealElement fixedEdge equals: #top.
	self assert: revealElement openingDirection equals: #down.
	^ widget
]

{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testRevealElementExposesViewportSizingPolicyHooks [
	<gtExample>
	| projection widget revealElement |
	projection := self newProjectionWithRevealedLeadingContext.
	widget := CgtStyleRuleSelectorPathWidget new
		projection: projection;
		yourself.
	revealElement := widget rowsContainer children detect: [ :each | each isKindOf: CgtMatcherRevealElement ].
	self assert: revealElement minimumViewportHeight equals: 0.
	self assert: revealElement maximumVisibleRowCount equals: 6.
	^ widget
]

{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testRevealElementUsesDedicatedScrollViewportContainer [
	<gtExample>
	| projection widget revealElement |
	projection := self newProjectionWithRevealedLeadingContext.
	widget := CgtStyleRuleSelectorPathWidget new
		projection: projection;
		yourself.
	revealElement := widget rowsContainer children detect: [ :each | each isKindOf: CgtMatcherRevealElement ].
	self assert: revealElement viewportUsesScrollContainer.
	self assert: revealElement viewportContainer children size equals: 1.
	self assert: revealElement viewportContainer children first identicalTo: revealElement viewportContentContainer.
	self assert: revealElement viewportContentContainer children second identicalTo: revealElement contentContainer.
	^ widget
]


{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testRevealElementUsesScrollForOverflowRowsBeyondVisibleCount [
	<gtExample>
	| projection widget revealElement |
	projection := self newProjectionWithManyRevealedLeadingContextNodes.
	widget := CgtStyleRuleSelectorPathWidget new
		projection: projection;
		yourself.
	revealElement := widget rowsContainer children detect: [ :each | each isKindOf: CgtMatcherRevealElement ].
	self assert: revealElement shouldUseScrollForOverflowRows.
	self assert: revealElement visibleRowElements size equals: revealElement maximumVisibleRowCount.
	self assert: revealElement viewportHeightForVisibleRows equals: (revealElement estimatedHeightForRowElements: revealElement visibleRowElements).
	^ widget
]

{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testRevealElementUsesAllRowsWhenBelowVisibleCountLimit [
	<gtExample>
	| projection widget revealElement |
	projection := self newProjectionWithRevealedLeadingContext.
	widget := CgtStyleRuleSelectorPathWidget new
		projection: projection;
		yourself.
	revealElement := widget rowsContainer children detect: [ :each | each isKindOf: CgtMatcherRevealElement ].
	self deny: revealElement shouldUseScrollForOverflowRows.
	self assert: revealElement visibleRowElements size equals: revealElement rowElements size.
	self assert: revealElement viewportHeightForVisibleRows equals: (revealElement estimatedHeightForRowElements: revealElement rowElements).
	^ widget
]


{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testUpstreamRevealElementUsesLeadingSpacerToPinContentToBottomEdge [
	<gtExample>
	| projection widget revealElement |
	projection := self newProjectionWithRevealedLeadingContext.
	widget := CgtStyleRuleSelectorPathWidget new
		projection: projection;
		yourself.
	revealElement := widget rowsContainer children detect: [ :each | each isKindOf: CgtMatcherRevealElement ].
	self assert: revealElement shouldUseLeadingSpacerForFixedEdge.
	self assert: revealElement viewportContentContainer children first identicalTo: revealElement viewportSpacerElement.
	self assert: revealElement viewportContentContainer children second identicalTo: revealElement contentContainer.
	^ widget
]

{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testDownstreamRevealElementUsesTrailingSpacerToPinContentToTopEdge [
	<gtExample>
	| projection widget revealElement |
	projection := self newProjectionWithRevealedTrailingContext.
	widget := CgtStyleRuleSelectorPathWidget new
		projection: projection;
		yourself.
	revealElement := widget rowsContainer children detect: [ :each | each isKindOf: CgtMatcherRevealElement ].
	self assert: revealElement shouldUseTrailingSpacerForFixedEdge.
	self assert: revealElement viewportContentContainer children first identicalTo: revealElement contentContainer.
	self assert: revealElement viewportContentContainer children second identicalTo: revealElement viewportSpacerElement.
	^ widget
]

{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testUpstreamRevealElementComputesPositiveSpacerWhenViewportExceedsContentHeight [
	<gtExample>
	| projection widget revealElement |
	projection := self newProjectionWithRevealedLeadingContext.
	widget := CgtStyleRuleSelectorPathWidget new
		projection: projection;
		yourself.
	revealElement := widget rowsContainer children detect: [ :each | each isKindOf: CgtMatcherRevealElement ].
	self assert: (revealElement spacerHeightForViewportHeight: (revealElement estimatedContentHeight + 12)) equals: 12.
	^ widget
]


{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testRevealElementComputesCollapsedStartHeightForRevealPlan [
	<gtExample>
	| widget revealElement |
	widget := CgtStyleRuleSelectorPathWidget new.
	widget projection: self newProjectionWithUpstreamSelectedAndIndicator.
	widget projection: self newProjectionWithRevealedLeadingContext.
	revealElement := widget rowsContainer children detect: [ :each | each isKindOf: CgtMatcherRevealElement ].
	self assert: revealElement shouldAnimateViewportHeight.
	self assert: revealElement usesCollapsedStartHeightForRevealPlan.
	self assert: revealElement viewportEndHeightForCurrentPlan equals: revealElement viewportHeightForVisibleRows.
	^ widget
]

{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testRevealElementComputesCollapsedEndHeightForCollapsePlan [
	<gtExample>
	| revealElement |
	revealElement := CgtMatcherRevealElement new
		rowElements: { BlElement new. BlElement new };
		structuralRefreshPlan: (CgtMatcherStructuralRefreshPlan new transitionKind: #collapse; yourself);
		yourself.
	self assert: revealElement usesCollapsedEndHeightForCollapsePlan.
	self assert: revealElement viewportStartHeightForCurrentPlan equals: revealElement viewportHeightForVisibleRows.
	^ revealElement
]

{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testRevealElementComputesVisibleRowsForPartialViewportHeight [
	<gtExample>
	| revealElement firstRow secondRow thirdRow partialHeight visibleRows |
	firstRow := BlElement new constraintsDo: [ :c | c vertical exact: 20. c horizontal exact: 10 ].
	secondRow := BlElement new constraintsDo: [ :c | c vertical exact: 30. c horizontal exact: 10 ].
	thirdRow := BlElement new constraintsDo: [ :c | c vertical exact: 40. c horizontal exact: 10 ].
	revealElement := CgtMatcherRevealElement new
		rowElements: { firstRow. secondRow. thirdRow };
		yourself.
	partialHeight := (revealElement measuredHeightForRowElement: firstRow) + revealElement minimumViewportHeight.
	visibleRows := revealElement visibleRowElementsForViewportHeight: partialHeight.
	self assert: visibleRows size equals: 1.
	self assert: visibleRows first identicalTo: firstRow.
	^ revealElement
]


{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testRevealElementDefaultsCurrentPresentationToStartViewportHeightAfterRevealRefresh [
	<gtExample>
	| widget revealElement |
	widget := CgtStyleRuleSelectorPathWidget new.
	widget projection: self newProjectionWithUpstreamSelectedAndIndicator.
	widget projection: self newProjectionWithRevealedLeadingContext.
	revealElement := widget rowsContainer children detect: [ :each | each isKindOf: CgtMatcherRevealElement ].
	self assert: revealElement currentViewportHeightForCurrentPlan equals: revealElement viewportStartHeightForCurrentPlan.
	self assert: revealElement visibleRowElementsForCurrentViewportPresentation isEmpty.
	^ widget
]

{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testRevealElementCollapsedStartPresentationExposesNoRows [
	<gtExample>
	| revealElement firstRow secondRow |
	firstRow := BlElement new constraintsDo: [ :c | c vertical exact: 20. c horizontal exact: 10 ].
	secondRow := BlElement new constraintsDo: [ :c | c vertical exact: 30. c horizontal exact: 10 ].
	revealElement := CgtMatcherRevealElement new
		rowElements: { firstRow. secondRow };
		structuralRefreshPlan: (CgtMatcherStructuralRefreshPlan new transitionKind: #reveal; yourself);
		yourself.
	self assert: (revealElement visibleRowElementsForViewportHeight: revealElement viewportStartHeightForCurrentPlan) isEmpty.
	^ revealElement
]


{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testRevealElementCurrentPresentationInterpolatesViewportHeightFromProgress [
	<gtExample>
	| revealElement startHeight endHeight midHeight |
	revealElement := CgtMatcherRevealElement new
		rowElements: { BlElement new. BlElement new };
		structuralRefreshPlan: (CgtMatcherStructuralRefreshPlan new transitionKind: #reveal; yourself);
		yourself.
	startHeight := revealElement viewportStartHeightForCurrentPlan.
	endHeight := revealElement viewportEndHeightForCurrentPlan.
	revealElement viewportPresentationProgress: 0.
	self assert: revealElement currentViewportHeightForCurrentPlan equals: startHeight.
	revealElement viewportPresentationProgress: 0.5.
	midHeight := revealElement currentViewportHeightForCurrentPlan.
	self assert: midHeight > startHeight.
	self assert: midHeight < endHeight.
	revealElement viewportPresentationProgress: 1.
	self assert: revealElement currentViewportHeightForCurrentPlan equals: endHeight.
	^ revealElement
]

{ #category : 'tests' }
CgtStyleRuleSelectorPathWidgetTests >> testRevealElementCurrentPresentationUsesVisibleRowsForProgressedHeight [
	<gtExample>
	| revealElement firstRow secondRow presentationHeight visibleRows |
	firstRow := BlElement new constraintsDo: [ :c | c vertical exact: 20. c horizontal exact: 10 ].
	secondRow := BlElement new constraintsDo: [ :c | c vertical exact: 30. c horizontal exact: 10 ].
	revealElement := CgtMatcherRevealElement new
		rowElements: { firstRow. secondRow };
		structuralRefreshPlan: (CgtMatcherStructuralRefreshPlan new transitionKind: #reveal; yourself);
		yourself.
	presentationHeight := revealElement minimumViewportHeight + (revealElement measuredHeightForRowElement: firstRow).
	revealElement viewportPresentationProgress: ((presentationHeight - revealElement viewportStartHeightForCurrentPlan) / (revealElement viewportEndHeightForCurrentPlan - revealElement viewportStartHeightForCurrentPlan)).
	visibleRows := revealElement visibleRowElementsForCurrentViewportPresentation.
	self assert: visibleRows size equals: 1.
	self assert: visibleRows first identicalTo: firstRow.
	^ revealElement
]




{ #category : 'tests - reveal presentation' }
CgtStyleRuleSelectorPathWidgetTests >> testRevealElementExposesStartingAndTargetProgressForRevealPlan [
	<gtExample>
	| revealElement |
	revealElement := CgtMatcherRevealElement new
		rowElements: { BlElement new. BlElement new };
		structuralRefreshPlan: (CgtMatcherStructuralRefreshPlan new transitionKind: #reveal; yourself);
		yourself.
	self assert: revealElement startingViewportPresentationProgressForCurrentPlan equals: 0.0.
	self assert: revealElement targetViewportPresentationProgressForCurrentPlan equals: 1.0.
	^ revealElement
]

{ #category : 'tests - reveal presentation' }
CgtStyleRuleSelectorPathWidgetTests >> testRevealElementExposesStartingAndTargetProgressForCollapsePlan [
	<gtExample>
	| revealElement |
	revealElement := CgtMatcherRevealElement new
		rowElements: { BlElement new. BlElement new };
		structuralRefreshPlan: (CgtMatcherStructuralRefreshPlan new transitionKind: #collapse; yourself);
		yourself.
	self assert: revealElement startingViewportPresentationProgressForCurrentPlan equals: 1.0.
	self assert: revealElement targetViewportPresentationProgressForCurrentPlan equals: 0.0.
	^ revealElement
]

{ #category : 'tests - reveal presentation' }
CgtStyleRuleSelectorPathWidgetTests >> testRevealElementCanResetAndCompletePresentationProgressFromPlan [
	<gtExample>
	| revealElement |
	revealElement := CgtMatcherRevealElement new
		rowElements: { BlElement new. BlElement new };
		structuralRefreshPlan: (CgtMatcherStructuralRefreshPlan new transitionKind: #reveal; yourself);
		viewportPresentationProgress: 0.5;
		yourself.
	revealElement resetViewportPresentationProgressToPlanStart.
	self assert: revealElement viewportPresentationProgress equals: 0.0.
	revealElement completeViewportPresentationProgressForCurrentPlan.
	self assert: revealElement viewportPresentationProgress equals: 1.0.
	^ revealElement
]

{ #category : 'tests - reveal presentation' }
CgtStyleRuleSelectorPathWidgetTests >> testRevealElementRefreshContentsUsesRowsVisibleForCurrentPresentation [
	<gtExample>
	| revealElement firstRow secondRow thirdRow presentationHeight |
	firstRow := BlElement new constraintsDo: [ :c | c vertical exact: 20. c horizontal exact: 10 ].
	secondRow := BlElement new constraintsDo: [ :c | c vertical exact: 30. c horizontal exact: 10 ].
	thirdRow := BlElement new constraintsDo: [ :c | c vertical exact: 40. c horizontal exact: 10 ].
	revealElement := CgtMatcherRevealElement new
		rowElements: { firstRow. secondRow. thirdRow };
		structuralRefreshPlan: (CgtMatcherStructuralRefreshPlan new transitionKind: #reveal; yourself);
		yourself.
	presentationHeight := revealElement measuredHeightForRowElement: firstRow.
	revealElement viewportPresentationProgress: ((presentationHeight - revealElement viewportStartHeightForCurrentPlan) / (revealElement viewportEndHeightForCurrentPlan - revealElement viewportStartHeightForCurrentPlan)).
	self assert: revealElement contentContainer children size equals: 1.
	self assert: revealElement contentContainer children first identicalTo: firstRow.
	^ revealElement
]

{ #category : 'tests - reveal presentation' }
CgtStyleRuleSelectorPathWidgetTests >> testRevealElementRefreshContentsUsesAllVisibleRowsAtFullPresentationProgress [
	<gtExample>
	| revealElement firstRow secondRow |
	firstRow := BlElement new constraintsDo: [ :c | c vertical exact: 20. c horizontal exact: 10 ].
	secondRow := BlElement new constraintsDo: [ :c | c vertical exact: 30. c horizontal exact: 10 ].
	revealElement := CgtMatcherRevealElement new
		rowElements: { firstRow. secondRow };
		structuralRefreshPlan: (CgtMatcherStructuralRefreshPlan new transitionKind: #reveal; yourself);
		viewportPresentationProgress: 1;
		yourself.
	self assert: revealElement contentContainer children size equals: 2.
	self assert: revealElement contentContainer children first identicalTo: firstRow.
	self assert: revealElement contentContainer children second identicalTo: secondRow.
	^ revealElement
]


{ #category : 'tests - reveal presentation' }
CgtStyleRuleSelectorPathWidgetTests >> testRevealElementExposesPresentationDurationForCurrentPlan [
	<gtExample>
	| revealElement |
	revealElement := CgtMatcherRevealElement new
		structuralRefreshPlan: (CgtMatcherStructuralRefreshPlan new transitionKind: #reveal; yourself);
		yourself.
	self assert: revealElement viewportPresentationDurationForCurrentPlan equals: revealElement transitionPolicy revealDuration.
	^ revealElement
]

{ #category : 'tests - reveal presentation' }
CgtStyleRuleSelectorPathWidgetTests >> testRevealElementCanBeginAndFinishPresentationForCurrentPlan [
	<gtExample>
	| revealElement |
	revealElement := CgtMatcherRevealElement new
		rowElements: { BlElement new. BlElement new };
		structuralRefreshPlan: (CgtMatcherStructuralRefreshPlan new transitionKind: #collapse; yourself);
		yourself.
	revealElement beginViewportPresentationForCurrentPlan.
	self assert: revealElement viewportPresentationProgress equals: 1.0.
	revealElement finishViewportPresentationForCurrentPlan.
	self assert: revealElement viewportPresentationProgress equals: 0.0.
	^ revealElement
]

{ #category : 'tests - reveal presentation' }
CgtStyleRuleSelectorPathWidgetTests >> testRevealElementCanAdvancePresentationProgressTowardTarget [
	<gtExample>
	| revealElement |
	revealElement := CgtMatcherRevealElement new
		rowElements: { BlElement new. BlElement new };
		structuralRefreshPlan: (CgtMatcherStructuralRefreshPlan new transitionKind: #reveal; yourself);
		yourself.
	revealElement beginViewportPresentationForCurrentPlan.
	revealElement advanceViewportPresentationProgressBy: 0.25.
	self assert: revealElement viewportPresentationProgress equals: 0.25.
	self deny: revealElement isAtTargetViewportPresentationProgress.
	revealElement advanceViewportPresentationProgressBy: 0.75.
	self assert: revealElement viewportPresentationProgress equals: 1.0.
	self assert: revealElement isAtTargetViewportPresentationProgress.
	^ revealElement
]
