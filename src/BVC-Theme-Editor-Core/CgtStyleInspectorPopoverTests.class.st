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
		pathRootElement: root
		relatedStyleRules: #().
	projection := popover selectorWidget projection.
	self assert: projection notNil.
	self assert: projection selectedElement identicalTo: selected.
	self assert: projection nodes size equals: 2.
	self assert: (popover childWithId: #styleInspectorScopeLabel) text asString equals: '#root > #selected'
]

{ #category : 'tests' }
CgtStyleInspectorPopoverTests >> testConfigureForStyleRuleSelectedElementPathRootElementRelatedStyleRulesDelegatesToSelectorWidgetAndUpdatesLabels [
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
		pathRootElement: root
		relatedStyleRules: { relatedRule }.
	projection := popover selectorWidget projection.
	self assert: projection notNil.
	self assert: popover styleRule identicalTo: currentRule.
	self assert: popover selectedElement identicalTo: selected.
	self assert: projection relatedStyleRules size equals: 1.
	self assert: (popover childWithId: #styleInspectorElementLabel) text asString equals: selected class name.
	self assert: (popover childWithId: #styleInspectorScopeLabel) text asString equals: '#selected'
]

{ #category : 'tests' }
CgtStyleInspectorPopoverTests >> testKeepsMatcherProjectionDrivenBySelectedElementAndRule [
	| root selected rule popover projection |
	root := self newTestElementWithId: #'root'.
	selected := root addChild: (self newTestElementWithId: #'selected').
	rule := self styleRuleForSelector: (self selectorForId: #'selected').
	popover := CgtStyleInspectorPopover new.
	popover pathRootElement: root.
	popover selectedElement: selected.
	popover styleRule: rule.
	projection := popover selectorWidget projection.
	self assert: projection notNil.
	self assert: projection selectedElement identicalTo: selected.
	self assert: projection nodes first representedElement identicalTo: selected
]

{ #category : 'tests' }
CgtStyleInspectorPopoverTests >> testBuildsMatcherProjectionWithRelatedRuleContext [
	| root selected currentRule relatedRule popover projection |
	root := self newTestElementWithId: #'root'.
	selected := root addChild: (self newTestElementWithId: #'selected').
	currentRule := self styleRuleForSelector: (self selectorForId: #'selected').
	relatedRule := self styleRuleForSelector: (CgtThemeCombinatorSelector
		left: (self selectorForId: #'root')
		combinator: #child
		right: (self selectorForId: #'selected')).
	popover := CgtStyleInspectorPopover new.
	popover pathRootElement: root.
	popover selectedElement: selected.
	popover relatedStyleRules: { relatedRule }.
	popover styleRule: currentRule.
	projection := popover selectorWidget projection.
	self assert: projection notNil.
	self assert: projection relatedStyleRules size equals: 1.
	self assert: projection otherRuleNodes isEmpty
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
	| popover |
	popover := CgtStyleInspectorPopover new.

	self assert: popover selectorWidget class equals: CgtThemeSelectorWidget
]

{ #category : 'tests' }
CgtStyleInspectorPopoverTests >> testMatcherSelectorChangedEventUpdatesDisplayedScopeLabel [
	| root selected rule popover newSelector event |
	root := self newTestElementWithId: #'root'.
	selected := root addChild: (self newTestElementWithId: #'selected').
	rule := self styleRuleForSelector: (self selectorForId: #'selected').
	popover := CgtStyleInspectorPopover new.
	popover pathRootElement: root.
	popover selectedElement: selected.
	popover styleRule: rule.
	newSelector := (CgtThemeCombinatorSelector
		left: (self selectorForId: #'root')
		combinator: #child
		right: (self selectorForId: #'selected')).
	event := CgtMatcherSelectorChangedEvent new
		selector: newSelector;
		yourself.

	popover selectorWidget matcherSelectorChangedEvent: event.
	popover matcherSelectorChangedEvent: event.

	self assert: popover styleRule selector identicalTo: newSelector.
	self assert: (popover childWithId: #styleInspectorScopeLabel) text asString equals: '#root > #selected'
]


{ #category : 'tests' }
CgtStyleInspectorPopoverTests >> testSelectorWidgetUsesConcreteMatcherRenderer [
	| popover |
	popover := CgtStyleInspectorPopover new.

	self assert: popover selectorWidget rendererWidget class equals: CgtThemeSelectorMondrianWidget
]


{ #category : 'tests' }
CgtStyleInspectorPopoverTests >> testSelectorWidgetCanUseAlternateRendererWithoutChangingPopoverContract [
	| popover |
	popover := CgtStyleInspectorPopover new.
	popover selectorWidget rendererWidgetClass: CgtThemeSelectorBreadcrumbWidget.

	self assert: popover selectorWidget rendererWidget class equals: CgtThemeSelectorBreadcrumbWidget
]



{ #category : 'tests' }
CgtStyleInspectorPopoverTests >> testSelectorRendererWidgetClassDelegatesToSelectorWidget [
	| popover |
	popover := CgtStyleInspectorPopover new.
	popover selectorRendererWidgetClass: CgtThemeSelectorBreadcrumbWidget.

	self assert: popover selectorRendererWidgetClass equals: CgtThemeSelectorBreadcrumbWidget.
	self assert: popover selectorWidget rendererWidget class equals: CgtThemeSelectorBreadcrumbWidget
]


{ #category : 'tests' }
CgtStyleInspectorPopoverTests >> testSelectorWidgetCanUseCompactRendererWithoutChangingPopoverContract [
	| popover |
	popover := CgtStyleInspectorPopover new.
	popover selectorRendererWidgetClass: CgtThemeSelectorCompactWidget.

	self assert: popover selectorRendererWidgetClass equals: CgtThemeSelectorCompactWidget.
	self assert: popover selectorWidget rendererWidget class equals: CgtThemeSelectorCompactWidget
]
