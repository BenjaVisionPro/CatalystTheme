"
#Theme Selector Widget Tests
I verify that the selector host widget coordinates a selector model and concrete renderer while projecting matcher state from live hierarchy context.
"
Class {
	#name : 'CgtThemeSelectorWidgetTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'private' }
CgtThemeSelectorWidgetTests >> newTestElementWithId: anId [
	^ CgtThemeSelectorTestElement new
		id: anId;
		yourself
]

{ #category : 'tests' }
CgtThemeSelectorWidgetTests >> testBuildsProjectionFromRuleAndHierarchyContext [
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
		pathRootElement: root;
		selectedElement: selected;
		styleRule: rule;
		yourself.
	self assert: widget projection notNil.
	self assert: widget currentSelector displayString equals: '#selected'
]

{ #category : 'tests' }
CgtThemeSelectorWidgetTests >> testClearsProjectionWhenSelectedElementBecomesNil [
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
		pathRootElement: root;
		selectedElement: selected;
		styleRule: rule;
		yourself.
	widget selectedElement: nil.
	self assert: widget projection isNil
]


{ #category : 'tests' }
CgtThemeSelectorWidgetTests >> testConfigureForStyleRuleSelectedElementPathRootElementRelatedStyleRulesRefreshesProjection [
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
		pathRootElement: root
		relatedStyleRules: { relatedRule }.

	self assert: widget projection notNil.
	self assert: widget projection selectedElement == child.
	self assert: widget projection relatedStyleRules size equals: 1
]


{ #category : 'tests' }
CgtThemeSelectorWidgetTests >> testMatcherSelectorChangedEventUpdatesCurrentStyleRule [
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
		pathRootElement: root
		relatedStyleRules: #().
	newSelector := CgtThemeSimpleSelector new
		addPredicate: (CgtThemeClassPredicate elementClass: CgtThemeSelectorTestElement);
		yourself.
	event := CgtMatcherSelectorChangedEvent new
		selector: newSelector;
		yourself.

	widget matcherSelectorChangedEvent: event.

	self assert: widget currentStyleRule identicalTo: originalRule.
	self assert: widget currentStyleRule selector identicalTo: newSelector
]


{ #category : 'tests' }
CgtThemeSelectorWidgetTests >> testHostsConcreteMatcherRendererWidget [
	| widget |
	widget := CgtThemeSelectorWidget new.

	self assert: widget rendererWidget class equals: CgtThemeMatcherMondrianWidget
]


{ #category : 'tests' }
CgtThemeSelectorWidgetTests >> testCanSwapToBreadcrumbRendererWidget [
	| widget |
	widget := CgtThemeSelectorWidget new.
	widget rendererWidgetClass: CgtThemeSelectorBreadcrumbWidget.

	self assert: widget rendererWidget class equals: CgtThemeSelectorBreadcrumbWidget
]

{ #category : 'tests' }
CgtThemeSelectorWidgetTests >> testBreadcrumbRendererReceivesProjectionFromModel [
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
	widget rendererWidgetClass: CgtThemeSelectorBreadcrumbWidget.
	widget
		configureForStyleRule: rule
		selectedElement: selected
		pathRootElement: root
		relatedStyleRules: #().

	self assert: widget rendererWidget projection identicalTo: widget projection.
	self assert: widget rendererWidget children isNotEmpty
]
