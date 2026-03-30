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
