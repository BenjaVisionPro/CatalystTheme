"
#Style Inspector Popover Tests
I verify that the style inspector popover now delegates matcher context ownership to the selector widget and keeps displayed labels synchronized from that widget state.
"
Class {
	#name : 'CgtStyleInspectorPopoverTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtStyleInspectorPopoverTests >> testBuildsMatcherProjectionFromStyleRuleAndSelectedElement [
	<gtExample>
	| root selected rule popover projection |
	root := self newTestElementWithId: #'root'.
	selected := root addChild: (self newTestElementWithId: #'selected').
	rule := self styleRuleForSelector: (CgtThemeCombinatorSelector
		left: (self selectorForId: #'root')
		combinator: #child
		right: (self selectorForId: #'selected')).
	popover := CgtStyleInspectorPopover new.
	popover
		configureForStyleRule: rule
		selectedElement: selected
		hierarchyRoot: root
		relatedStyleRules: #().
	projection := popover selectorWidget projection.
	self assert: projection notNil.
	self assert: projection selectedElement identicalTo: selected.
	self assert: projection nodes size equals: 2.
	self assert: (popover childWithId: #styleInspectorScopeLabel) text asString equals: '#root > #selected'
	^ projection

]

{ #category : 'tests' }
CgtStyleInspectorPopoverTests >> testConfigureForStyleRuleSelectedElementPathRootElementRelatedStyleRulesDelegatesToSelectorWidgetAndUpdatesLabels [
	<gtExample>
	| root selected currentRule relatedRule popover projection |
	root := self newTestElementWithId: #'root'.
	selected := root addChild: (self newTestElementWithId: #'selected').
	currentRule := self styleRuleForSelector: (self selectorForId: #'selected').
	relatedRule := self styleRuleForSelector: (CgtThemeCombinatorSelector
		left: (self selectorForId: #'root')
		combinator: #child
		right: (self selectorForId: #'selected')).
	popover := CgtStyleInspectorPopover new.
	popover
		configureForStyleRule: currentRule
		selectedElement: selected
		hierarchyRoot: root
		relatedStyleRules: { relatedRule }.
	projection := popover selectorWidget projection.
	self assert: projection notNil.
	self assert: popover styleRule identicalTo: currentRule.
	self assert: popover selectedElement identicalTo: selected.
	self assert: projection relatedStyleRules size equals: 1.
	self assert: (popover childWithId: #styleInspectorElementLabel) text asString equals: selected class name.
	self assert: (popover childWithId: #styleInspectorScopeLabel) text asString equals: '#selected'
	^ projection

]

{ #category : 'tests' }
CgtStyleInspectorPopoverTests >> testKeepsMatcherProjectionDrivenBySelectedElementAndRule [
	<gtExample>
	| root selected rule popover projection |
	root := self newTestElementWithId: #'root'.
	selected := root addChild: (self newTestElementWithId: #'selected').
	rule := self styleRuleForSelector: (self selectorForId: #'selected').
	popover := CgtStyleInspectorPopover new.
	popover hierarchyRoot: root.
	popover selectedElement: selected.
	popover styleRule: rule.
	projection := popover selectorWidget projection.
	self assert: projection notNil.
	self assert: projection selectedElement identicalTo: selected.
	self assert: projection nodes first representedElement identicalTo: selected
	^ projection

]

{ #category : 'tests' }
CgtStyleInspectorPopoverTests >> testBuildsMatcherProjectionWithRelatedRuleContext [
	<gtExample>
	| root selected currentRule relatedRule popover projection |
	root := self newTestElementWithId: #'root'.
	selected := root addChild: (self newTestElementWithId: #'selected').
	currentRule := self styleRuleForSelector: (self selectorForId: #'selected').
	relatedRule := self styleRuleForSelector: (CgtThemeCombinatorSelector
		left: (self selectorForId: #'root')
		combinator: #child
		right: (self selectorForId: #'selected')).
	popover := CgtStyleInspectorPopover new.
	popover hierarchyRoot: root.
	popover selectedElement: selected.
	popover relatedStyleRules: { relatedRule }.
	popover styleRule: currentRule.
	projection := popover selectorWidget projection.
	self assert: projection notNil.
	self assert: projection relatedStyleRules size equals: 1.
	self assert: projection otherRuleNodes isEmpty
	^ projection

]

{ #category : 'private' }
CgtStyleInspectorPopoverTests >> newTestElementWithId: aSymbol [
	^ CgtThemeSelectorTestElement new
		id: (BlElementId named: aSymbol);
		yourself
]

{ #category : 'private' }
CgtStyleInspectorPopoverTests >> selectorForId: aSymbol [
	^ CgtThemeSimpleSelector new
		addPredicate: (CgtThemeIdPredicate elementId: (BlElementId named: aSymbol));
		yourself
]

{ #category : 'private' }
CgtStyleInspectorPopoverTests >> styleRuleForSelector: aSelector [
	^ CgtThemeStyleRule new
		selector: aSelector;
		yourself
]

{ #category : 'tests' }
CgtStyleInspectorPopoverTests >> testUsesThemeSelectorWidgetAsSelectorWidget [
	<gtExample>
	| popover |
	popover := CgtStyleInspectorPopover new.

	self assert: popover selectorWidget class equals: CgtThemeSelectorWidget
	^ popover

]

{ #category : 'tests' }
CgtStyleInspectorPopoverTests >> testMatcherSelectorChangedEventUpdatesDisplayedScopeLabel [
	<gtExample>
	| root selected rule popover newSelector event |
	root := self newTestElementWithId: #'root'.
	selected := root addChild: (self newTestElementWithId: #'selected').
	rule := self styleRuleForSelector: (self selectorForId: #'selected').
	popover := CgtStyleInspectorPopover new.
	popover hierarchyRoot: root.
	popover selectedElement: selected.
	popover styleRule: rule.
	newSelector := (CgtThemeCombinatorSelector
		left: (self selectorForId: #'root')
		combinator: #child
		right: (self selectorForId: #'selected')).
	event := CgtThemeSelectorChangedEvent new
		selector: newSelector;
		yourself.

	popover selectorWidget selectorChangedEvent: event.
	popover selectorChangedEvent: event.

	self assert: popover styleRule selector identicalTo: newSelector.
	self assert: (popover childWithId: #styleInspectorScopeLabel) text asString equals: '#root > #selected'
	^ CgtStyleInspectorPopover
]


{ #category : 'tests' }
CgtStyleInspectorPopoverTests >> testSelectorWidgetUsesConcreteMatcherRenderer [
	<gtExample>
	| popover |
	popover := CgtStyleInspectorPopover new.

	self assert: popover selectorWidget selectorRendererWidget class equals: CgtThemeSelectorMondrianWidget
	^ CgtStyleInspectorPopover new
]


{ #category : 'tests' }
CgtStyleInspectorPopoverTests >> testSelectorWidgetCanUseAlternateRendererWithoutChangingPopoverContract [
	<gtExample>
	| popover |
	popover := CgtStyleInspectorPopover new.
	popover selectorWidget selectorRendererWidgetClass: CgtThemeSelectorBreadcrumbWidget.

	self assert: popover selectorWidget selectorRendererWidget class equals: CgtThemeSelectorBreadcrumbWidget
	^ CgtStyleInspectorPopover new
]



{ #category : 'tests' }
CgtStyleInspectorPopoverTests >> testSelectorRendererWidgetClassDelegatesToSelectorWidget [
	<gtExample>
	| popover |
	popover := CgtStyleInspectorPopover new.
	popover selectorRendererWidgetClass: CgtThemeSelectorBreadcrumbWidget.

	self assert: popover selectorRendererWidgetClass equals: CgtThemeSelectorBreadcrumbWidget.
	self assert: popover selectorWidget selectorRendererWidget class equals: CgtThemeSelectorBreadcrumbWidget
	^ CgtStyleInspectorPopover new
]


{ #category : 'tests' }
CgtStyleInspectorPopoverTests >> testSelectorWidgetCanUseCompactRendererWithoutChangingPopoverContract [
	<gtExample>
	| popover |
	popover := CgtStyleInspectorPopover new.
	popover selectorRendererWidgetClass: CgtThemeSelectorCompactWidget.

	self assert: popover selectorRendererWidgetClass equals: CgtThemeSelectorCompactWidget.
	self assert: popover selectorWidget selectorRendererWidget class equals: CgtThemeSelectorCompactWidget
	^ CgtStyleInspectorPopover new
]


{ #category : 'tests' }
CgtStyleInspectorPopoverTests >> testShowOtherRuleContextDelegatesToSelectorWidget [
	<gtExample>
	| root selected currentRule relatedRule popover |
	root := self newTestElementWithId: #'root'.
	selected := root addChild: (self newTestElementWithId: #'selected').
	currentRule := self styleRuleForSelector: (self selectorForId: #'selected').
	relatedRule := self styleRuleForSelector: (CgtThemeCombinatorSelector
		left: (self selectorForId: #'root')
		combinator: #child
		right: (self selectorForId: #'selected')).
	popover := CgtStyleInspectorPopover new.
	popover
		configureForStyleRule: currentRule
		selectedElement: selected
		hierarchyRoot: root
		relatedStyleRules: { relatedRule }.
	self assert: popover selectorWidget projection otherRuleNodes isEmpty.
	popover showOtherRuleContext.
	self assert: popover selectorModel visibilityState showsOtherRuleContext.
	self deny: popover selectorWidget projection otherRuleNodes isEmpty
	^ CgtStyleInspectorPopover new
]


{ #category : 'tests' }
CgtStyleInspectorPopoverTests >> testSelectorChangedEventUpdatesLabels [
	<gtExample>
	| popover event rule |
	popover := CgtStyleInspectorPopover new.
	rule := CgtThemeStyleRule new.
	rule selector: (CgtThemeSimpleSelector new addPredicate: (CgtThemeIdPredicate elementId: #selected); yourself).
	popover styleRule: rule.
	event := CgtThemeSelectorChangedEvent new selector: rule selector; yourself.
	popover selectorChangedEvent: event.
	self assert: (popover childWithId: #styleInspectorScopeLabel ifFound: [ :aLabel | aLabel text asString ] ifNone: [ '' ]) = rule selector displayString
	^ popover

]
