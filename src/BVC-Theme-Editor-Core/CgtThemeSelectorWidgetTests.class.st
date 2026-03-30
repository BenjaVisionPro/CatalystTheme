"
#Theme Selector Widget Tests
I verify that the compatibility selector widget projects matcher state from a style rule and live hierarchy context.
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
		selector: (CgtThemeSelector new
			predicate: (CgtThemeIdPredicate elementId: #selected);
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
		selector: (CgtThemeSelector new
			predicate: (CgtThemeIdPredicate elementId: #selected);
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
		selector: (CgtThemeSelector new
			predicate: (CgtThemeIdPredicate elementId: #selected);
			yourself);
		yourself.
	widget := CgtThemeSelectorWidget new
		configureForStyleRule: originalRule
		selectedElement: selected
		pathRootElement: root
		relatedStyleRules: #().
	newSelector := CgtThemeSelector new
		predicate: (CgtThemeClassPredicate elementClass: CgtThemeSelectorTestElement);
		yourself.
	event := CgtMatcherSelectorChangedEvent new
		selector: newSelector;
		yourself.

	widget matcherSelectorChangedEvent: event.

	self assert: widget currentStyleRule identicalTo: originalRule.
	self assert: widget currentStyleRule selector identicalTo: newSelector
]


{ #category : 'tests' }
CgtThemeSelectorWidgetTests >> testOtherRuleContextToggleUpdatesVisibilityState [
	| root selected rule relatedRule widget event |
	root := self newTestElementWithId: #root.
	selected := self newTestElementWithId: #selected.
	root addChild: selected.
	rule := CgtThemeStyleRule bootstrapForSelectedElement: selected withinHierarchyRoot: root.
	relatedRule := CgtThemeStyleRule new
		selector: (CgtThemeSelector new
			predicate: (CgtThemeIdPredicate elementId: #other);
			yourself);
		yourself.
	widget := CgtThemeSelectorWidget new
		configureForStyleRule: rule
		selectedElement: selected
		pathRootElement: root
		relatedStyleRules: { relatedRule }.
	event := CgtMatcherOtherRuleContextToggledEvent new
		shouldShow: true;
		yourself.
	widget matcherOtherRuleContextToggledEvent: event.
	self assert: widget visibilityState showsOtherRuleContext
]
