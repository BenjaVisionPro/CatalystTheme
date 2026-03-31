"
#Theme Selector Model Tests
I verify that the theme selector model owns non-visual selector state and matcher projection rebuilding without rendering concerns.
"
Class {
	#name : 'CgtThemeSelectorModelTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'private' }
CgtThemeSelectorModelTests >> newTestElementWithId: anId [
	^ CgtThemeSelectorTestElement new
		id: anId;
		yourself
]

{ #category : 'tests' }
CgtThemeSelectorModelTests >> testBuildsProjectionFromRuleAndHierarchyContext [
	| root selected rule model |
	root := self newTestElementWithId: #root.
	selected := self newTestElementWithId: #selected.
	root addChild: selected.
	rule := CgtThemeStyleRule new
		selector: (CgtThemeSimpleSelector new
			addPredicate: (CgtThemeIdPredicate elementId: #selected);
			yourself);
		yourself.
	model := CgtThemeSelectorModel new
		pathRootElement: root;
		selectedElement: selected;
		styleRule: rule;
		yourself.
	self assert: model projection notNil.
	self assert: model selector displayString equals: '#selected'
]

{ #category : 'tests' }
CgtThemeSelectorModelTests >> testClearsProjectionWhenSelectedElementBecomesNil [
	| root selected rule model |
	root := self newTestElementWithId: #root.
	selected := self newTestElementWithId: #selected.
	root addChild: selected.
	rule := CgtThemeStyleRule new
		selector: (CgtThemeSimpleSelector new
			addPredicate: (CgtThemeIdPredicate elementId: #selected);
			yourself);
		yourself.
	model := CgtThemeSelectorModel new
		pathRootElement: root;
		selectedElement: selected;
		styleRule: rule;
		yourself.
	model selectedElement: nil.
	self assert: model projection isNil
]

{ #category : 'tests' }
CgtThemeSelectorModelTests >> testMatcherSelectorChangedEventUpdatesCurrentStyleRule [
	| root selected originalRule model newSelector event |
	root := self newTestElementWithId: #root.
	selected := self newTestElementWithId: #selected.
	root addChild: selected.
	originalRule := CgtThemeStyleRule new
		selector: (CgtThemeSimpleSelector new
			addPredicate: (CgtThemeIdPredicate elementId: #selected);
			yourself);
		yourself.
	model := CgtThemeSelectorModel new
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

	model matcherSelectorChangedEvent: event.

	self assert: model currentStyleRule identicalTo: originalRule.
	self assert: model currentStyleRule selector identicalTo: newSelector
]


{ #category : 'tests' }
CgtThemeSelectorModelTests >> testClassMatchToggleUpdatesStyleRuleAndProjection [
	| root selected rule model event |
	root := self newTestElementWithId: #root.
	selected := self newTestElementWithId: #selected.
	root addChild: selected.
	rule := CgtThemeStyleRule new
		selector: (CgtThemeSimpleSelector new
			addPredicate: (CgtThemeIdPredicate elementId: #selected);
			yourself);
		yourself.
	model := CgtThemeSelectorModel new
		configureForStyleRule: rule
		selectedElement: selected
		pathRootElement: root
		relatedStyleRules: #().
	event := CgtMatcherClassMatchToggledEvent new
		projectionNode: model projection selectedProjectionNode;
		shouldMatch: true;
		yourself.
	model matcherClassMatchToggledEvent: event.
	self assert: model currentStyleRule selector displayString equals: 'CgtThemeSelectorTestElement#selected'.
	self assert: model projection selectedProjectionNode matchByClass
]

{ #category : 'tests' }
CgtThemeSelectorModelTests >> testCompactedSectionExpansionUpdatesVisibilityStateAndProjection [
	| root middle selected rule model compactedNode event |
	root := self newTestElementWithId: #root.
	middle := self newTestElementWithId: #middle.
	selected := self newTestElementWithId: #selected.
	root addChild: middle.
	middle addChild: selected.
	rule := CgtThemeStyleRule new
		selector: (CgtThemeSimpleSelector new
			addPredicate: (CgtThemeIdPredicate elementId: #selected);
			yourself);
		yourself.
	model := CgtThemeSelectorModel new
		configureForStyleRule: rule
		selectedElement: selected
		pathRootElement: root
		relatedStyleRules: #().
	compactedNode := model projection nodes detect: [ :each | each isCompactedSection ].
	event := CgtMatcherCompactedSectionExpandedEvent new projectionNode: compactedNode; yourself.
	model matcherCompactedSectionExpandedEvent: event.
	self assert: model visibilityState hasExpandedGaps.
	self deny: (model projection nodes anySatisfy: [ :each | each isCompactedSection ])
]
