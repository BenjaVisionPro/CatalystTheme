"
#Theme Selector Widget Tests
I verify that the selector host widget coordinates a selector model and concrete renderer while projecting selector state from live hierarchy context.
"
Class {
	#name : 'CgtThemeSelectorWidgetTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'private' }
CgtThemeSelectorWidgetTests >> newTestElementWithId: anId [.
	^ CgtThemeSelectorTestElement new
		id: anId;
		yourself
]

{ #category : 'private' }
CgtThemeSelectorWidgetTests >> selectorForId: aSymbol [.
	^ CgtThemeSimpleSelector new
		addPredicate: (CgtThemeIdPredicate elementId: aSymbol);
		yourself
]

{ #category : 'private' }
CgtThemeSelectorWidgetTests >> styleRuleForSelector: aSelector [.
	^ CgtThemeStyleRule new
		selector: aSelector;
		yourself
]

{ #category : 'tests' }
CgtThemeSelectorWidgetTests >> testBuildsProjectionFromRuleAndHierarchyContext [
	<gtExample>
	| root selected rule widget |
	root := self newTestElementWithId: #root.
	selected := self newTestElementWithId: #selected.
	root addChild: selected.
	rule := CgtThemeStyleRule new
		selector: (CgtThemeSimpleSelector new
			addPredicate: (CgtThemeIdPredicate elementId: #selected);
			yourself);
		yourself.
	widget := CgtThemeSelectorWidget new
		hierarchyRoot: root;
		selectedElement: selected;
		styleRule: rule;
		yourself.
	self assert: widget projection notNil.
	self assert: widget currentSelector displayString equals: '#selected'.
	^ widget

]

{ #category : 'tests' }
CgtThemeSelectorWidgetTests >> testClearsProjectionWhenSelectedElementBecomesNil [
	<gtExample>
	| root selected rule widget |
	root := self newTestElementWithId: #root.
	selected := self newTestElementWithId: #selected.
	root addChild: selected.
	rule := CgtThemeStyleRule new
		selector: (CgtThemeSimpleSelector new
			addPredicate: (CgtThemeIdPredicate elementId: #selected);
			yourself);
		yourself.
	widget := CgtThemeSelectorWidget new
		hierarchyRoot: root;
		selectedElement: selected;
		styleRule: rule;
		yourself.
	widget selectedElement: nil.
	self assert: widget projection isNil.
	^ widget
]


{ #category : 'tests' }
CgtThemeSelectorWidgetTests >> testConfigureForStyleRuleSelectedElementPathRootElementRelatedStyleRulesRefreshesProjection [
	<gtExample>
	| root parent child rule widget relatedRule |
	root := CgtThemeSelectorTestElement named: #Root id: #root.
	parent := CgtThemeSelectorTestElement named: #Parent id: #parent.
	child := CgtThemeSelectorTestElement named: #Child id: #child.
	root addChild: parent.
	parent addChild: child.
	rule := CgtThemeStyleRule bootstrapForSelectedElement: child withinHierarchyRoot: root.
	relatedRule := CgtThemeStyleRule bootstrapForSelectedElement: parent withinHierarchyRoot: root.
	widget := CgtThemeSelectorWidget new.

	widget
		configureForStyleRule: rule
		selectedElement: child
		hierarchyRoot: root
		relatedStyleRules: { relatedRule }.

	self assert: widget projection notNil.
	self assert: widget projection selectedElement == child.
	self assert: widget projection relatedStyleRules size equals: 1.
	^ widget
]


{ #category : 'tests' }
CgtThemeSelectorWidgetTests >> testMatcherSelectorChangedEventUpdatesCurrentStyleRuleViaModelSelectorProtocol [
	<gtExample>
	| root selected originalRule widget newSelector event |
	root := self newTestElementWithId: #root.
	selected := self newTestElementWithId: #selected.
	root addChild: selected.
	originalRule := CgtThemeStyleRule new
		selector: (CgtThemeSimpleSelector new
			addPredicate: (CgtThemeIdPredicate elementId: #selected);
			yourself);
		yourself.
	widget := CgtThemeSelectorWidget new
		configureForStyleRule: originalRule
		selectedElement: selected
		hierarchyRoot: root
		relatedStyleRules: #().
	newSelector := CgtThemeSimpleSelector new
		addPredicate: (CgtThemeClassPredicate elementClass: CgtThemeSelectorTestElement);
		yourself.
	event := CgtThemeSelectorChangedEvent new
		selector: newSelector;
		yourself.

	widget selectorChangedEvent: event.

	self assert: widget currentStyleRule identicalTo: originalRule.
	self assert: widget currentStyleRule selector identicalTo: newSelector.
	^ CgtThemeSelectorWidget
]




{ #category : 'tests' }
CgtThemeSelectorWidgetTests >> testDefaultRendererSuperclassIsSelectorRendererWidget [
	<gtExample>
	| widget |
	self assert: CgtStyleRuleSelectorPathWidget superclass equals: CgtThemeSelectorRendererWidget.
	self assert: CgtThemeSelectorBreadcrumbWidget superclass equals: CgtThemeSelectorRendererWidget.
	self assert: CgtThemeSelectorCompactWidget superclass equals: CgtThemeSelectorRendererWidget.
	widget := CgtThemeSelectorWidget new.
	^ widget

]

{ #category : 'tests' }
CgtThemeSelectorWidgetTests >> testHostsConcreteSelectorRendererWidget [
	<gtExample>
	| widget |
	widget := CgtThemeSelectorWidget new.

	self assert: widget selectorRendererWidget class equals: CgtStyleRuleSelectorPathWidget.
	^ widget
]


{ #category : 'tests' }
CgtThemeSelectorWidgetTests >> testCanSwapToBreadcrumbRendererWidget [
	<gtExample>
	| widget |
	widget := CgtThemeSelectorWidget new.
	widget selectorRendererWidgetClass: CgtThemeSelectorBreadcrumbWidget.

	self assert: widget selectorRendererWidget class equals: CgtThemeSelectorBreadcrumbWidget.
	^ widget

]

{ #category : 'tests' }
CgtThemeSelectorWidgetTests >> testBreadcrumbRendererReceivesProjectionFromModel [
	<gtExample>
	| root selected rule widget |
	root := self newTestElementWithId: #root.
	selected := self newTestElementWithId: #selected.
	root addChild: selected.
	rule := CgtThemeStyleRule new
		selector: (CgtThemeSimpleSelector new
			addPredicate: (CgtThemeIdPredicate elementId: #selected);
			yourself);
		yourself.
	widget := CgtThemeSelectorWidget new.
	widget selectorRendererWidgetClass: CgtThemeSelectorBreadcrumbWidget.
	widget
		configureForStyleRule: rule
		selectedElement: selected
		hierarchyRoot: root
		relatedStyleRules: #().

	self assert: widget selectorRendererWidget projection identicalTo: widget projection.
	self assert: widget selectorRendererWidget children isNotEmpty.
	^ widget
]


{ #category : 'tests' }
CgtThemeSelectorWidgetTests >> testCanSwapToCompactRendererWidget [
	<gtExample>
	| widget |
	widget := CgtThemeSelectorWidget new.
	widget selectorRendererWidgetClass: CgtThemeSelectorCompactWidget.

	self assert: widget selectorRendererWidget class equals: CgtThemeSelectorCompactWidget.
	^ widget

]

{ #category : 'tests' }
CgtThemeSelectorWidgetTests >> testCompactRendererReceivesProjectionFromModel [
	<gtExample>
	| root selected rule widget |
	root := self newTestElementWithId: #root.
	selected := self newTestElementWithId: #selected.
	root addChild: selected.
	rule := CgtThemeStyleRule new
		selector: (CgtThemeSimpleSelector new
			addPredicate: (CgtThemeIdPredicate elementId: #selected);
			yourself);
		yourself.
	widget := CgtThemeSelectorWidget new.
	widget selectorRendererWidgetClass: CgtThemeSelectorCompactWidget.
	widget
		configureForStyleRule: rule
		selectedElement: selected
		hierarchyRoot: root
		relatedStyleRules: #().

	self assert: widget selectorRendererWidget projection identicalTo: widget projection.
	self assert: (widget selectorRendererWidget childWithId: #compactSelectorLabel) notNil.
	^ widget
]


{ #category : 'tests' }
CgtThemeSelectorWidgetTests >> testShowOtherRuleContextDelegatesToModelAndRefreshesProjection [
	<gtExample>
	| root selected currentRule relatedRule widget |
	root := self newTestElementWithId: #root.
	selected := root addChild: (self newTestElementWithId: #selected).
	currentRule := self styleRuleForSelector: (self selectorForId: #'selected').
	relatedRule := self styleRuleForSelector: (CgtThemeCombinatorSelector
		left: (self selectorForId: #'root')
		combinator: #child
		right: (self selectorForId: #'selected')).
	widget := CgtThemeSelectorWidget new.
	widget
		configureForStyleRule: currentRule
		selectedElement: selected
		hierarchyRoot: root
		relatedStyleRules: { relatedRule }.
	self assert: widget projection otherRuleNodes isEmpty.
	widget showOtherRuleContext.
	self assert: widget visibilityState showsOtherRuleContext.
	self deny: widget projection otherRuleNodes isEmpty.
	^ widget
]


{ #category : 'tests' }
CgtThemeSelectorWidgetTests >> testOtherRuleContextToggleEventDelegatesToModelAndRefreshesProjection [
	<gtExample>
	| root selected currentRule relatedRule widget event |
	root := self newTestElementWithId: #root.
	selected := root addChild: (self newTestElementWithId: #selected).
	currentRule := self styleRuleForSelector: (self selectorForId: #'selected').
	relatedRule := self styleRuleForSelector: (CgtThemeCombinatorSelector
		left: (self selectorForId: #'root')
		combinator: #child
		right: (self selectorForId: #'selected')).
	widget := CgtThemeSelectorWidget new.
	widget
		configureForStyleRule: currentRule
		selectedElement: selected
		hierarchyRoot: root
		relatedStyleRules: { relatedRule }.
	self deny: widget visibilityState showsOtherRuleContext.
	event := CgtThemeSelectorOtherRuleContextToggledEvent new.
	widget selectorOtherRuleContextToggledEvent: event.
	self assert: widget visibilityState showsOtherRuleContext.
	self deny: widget projection otherRuleNodes isEmpty.
	^ widget
]


{ #category : 'tests' }
CgtThemeSelectorWidgetTests >> testMatcherHoverEventIsRepublishedAsSelectorHoverEvent [
	<gtExample>
	| widget selected received |
	widget := CgtThemeSelectorWidget new.
	selected := CgtMatcherProjectionNode kind: #selectedElement.
	received := false.
	widget when: CgtThemeSelectorNodeHoveredEvent do: [ :anEvent |
		received := anEvent projectionNode == selected ].
	widget selectorNodeHoveredEvent: (CgtThemeSelectorNodeHoveredEvent new projectionNode: selected; yourself).
	self assert: received.
	^ widget

]


{ #category : 'tests' }
CgtThemeSelectorWidgetTests >> testConfigureForStyleInspectorModelUsesActiveRuleEditingModel [
	<gtExample>
	| root selected currentRule relatedRule inspectorModel widget |
	root := self newTestElementWithId: #root.
	selected := self newTestElementWithId: #selected.
	root addChild: selected.
	currentRule := CgtThemeStyleRule new
		selector: (CgtThemeSimpleSelector new
			addPredicate: (CgtThemeIdPredicate elementId: #selected);
			yourself);
		yourself.
	relatedRule := CgtThemeStyleRule new
		selector: (CgtThemeCombinatorSelector
			left: (CgtThemeSimpleSelector new
				addPredicate: (CgtThemeIdPredicate elementId: #root);
				yourself)
			combinator: #child
			right: (CgtThemeSimpleSelector new
				addPredicate: (CgtThemeIdPredicate elementId: #selected);
				yourself));
		yourself.
	inspectorModel := CgtThemeStyleInspectorModel new
		configureForStyleRule: currentRule
		selectedElement: selected
		hierarchyRoot: root
		relatedStyleRules: { relatedRule };
		yourself.
	widget := CgtThemeSelectorWidget new.
	widget configureForStyleInspectorModel: inspectorModel.
	self assert: widget selectorModel currentStyleRule identicalTo: currentRule.
	self assert: widget selectedElement identicalTo: selected.
	self assert: widget hierarchyRoot identicalTo: root.
	self assert: widget relatedStyleRules asArray equals: { relatedRule }.
	self assert: widget selectorRendererWidget projection identicalTo: widget selectorModel projection.
	^ widget
]
