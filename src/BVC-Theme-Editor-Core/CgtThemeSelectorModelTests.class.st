"
#Theme Selector Model Tests
I verify that the theme selector model owns non-visual selector state and selector projection rebuilding without rendering concerns.
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
		hierarchyRoot: root;
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
		hierarchyRoot: root;
		selectedElement: selected;
		styleRule: rule;
		yourself.
	model selectedElement: nil.
	self assert: model projection isNil
]

{ #category : 'tests' }
CgtThemeSelectorModelTests >> testSelectorUpdatesCurrentStyleRule [
	| root selected originalRule model newSelector |
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
		hierarchyRoot: root
		relatedStyleRules: #().
	newSelector := CgtThemeSimpleSelector new
		addPredicate: (CgtThemeClassPredicate elementClass: CgtThemeSelectorTestElement);
		yourself.
	model selector: newSelector.

	self assert: model currentStyleRule identicalTo: originalRule.
	self assert: model currentStyleRule selector identicalTo: newSelector
]


{ #category : 'tests' }
CgtThemeSelectorModelTests >> testApplyClassMatchUpdatesStyleRuleAndProjection [
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
		configureForStyleRule: rule
		selectedElement: selected
		hierarchyRoot: root
		relatedStyleRules: #().
	model applyClassMatch: true toProjectionNode: model projection selectedProjectionNode.
	self assert: model currentStyleRule selector displayString equals: 'CgtThemeSelectorTestElement#selected'.
	self assert: model projection selectedProjectionNode matchByClass
]

{ #category : 'tests' }
CgtThemeSelectorModelTests >> testRevealCompactedProjectionNodeUpdatesVisibilityStateAndProjection [
	| root middle selected rule model compactedNode |
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
		hierarchyRoot: root
		relatedStyleRules: #().
	compactedNode := model projection nodes detect: [ :each | each isCompactedSection ].
	model revealCompactedProjectionNode: compactedNode.
	self assert: model visibilityState hasExpandedGaps.
	self assert: (model visibilityState isExpandedForGapIdentity: compactedNode gapIdentity).
	self deny: (model projection nodes anySatisfy: [ :each | each isCompactedSection ])
]


{ #category : 'tests' }
CgtThemeSelectorModelTests >> testShowOtherRuleContextRebuildsProjectionWithOtherRuleNodes [
	| root selected currentRule relatedRule model |
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
	model := CgtThemeSelectorModel new
		configureForStyleRule: currentRule
		selectedElement: selected
		hierarchyRoot: root
		relatedStyleRules: { relatedRule }.
	self assert: model projection otherRuleNodes isEmpty.
	model showOtherRuleContext.
	self assert: model visibilityState showsOtherRuleContext.
	self deny: model projection otherRuleNodes isEmpty
]

{ #category : 'tests' }
CgtThemeSelectorModelTests >> testHideOtherRuleContextRemovesOtherRuleNodesAgain [
	| root selected currentRule relatedRule model |
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
	model := CgtThemeSelectorModel new
		configureForStyleRule: currentRule
		selectedElement: selected
		hierarchyRoot: root
		relatedStyleRules: { relatedRule }.
	model showOtherRuleContext.
	self deny: model projection otherRuleNodes isEmpty.
	model hideOtherRuleContext.
	self deny: model visibilityState showsOtherRuleContext.
	self assert: model projection otherRuleNodes isEmpty
]


{ #category : 'tests' }
CgtThemeSelectorModelTests >> testSelectorMutationClearsTemporaryReveals [
	| root middle selected rule model compactedNode |
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
		hierarchyRoot: root
		relatedStyleRules: #().
	compactedNode := model projection nodes detect: [ :each | each isCompactedSection ].
	model revealCompactedProjectionNode: compactedNode.
	self assert: model visibilityState hasExpandedGaps.
	model applyClassMatch: true toProjectionNode: model projection selectedProjectionNode.
	self deny: model visibilityState hasExpandedGaps.
	self assert: (model projection nodes anySatisfy: [ :each | each isCompactedSection ])
]

{ #category : 'tests' }
CgtThemeSelectorModelTests >> testSelectedElementChangeClearsTemporaryReveals [
	| root middle selected sibling rule model compactedNode |
	root := self newTestElementWithId: #root.
	middle := self newTestElementWithId: #middle.
	selected := self newTestElementWithId: #selected.
	sibling := self newTestElementWithId: #sibling.
	root addChild: middle.
	middle addChild: selected.
	root addChild: sibling.
	rule := CgtThemeStyleRule new
		selector: (CgtThemeSimpleSelector new
			addPredicate: (CgtThemeIdPredicate elementId: #selected);
			yourself);
		yourself.
	model := CgtThemeSelectorModel new
		configureForStyleRule: rule
		selectedElement: selected
		hierarchyRoot: root
		relatedStyleRules: #().
	compactedNode := model projection nodes detect: [ :each | each isCompactedSection ].
	model revealCompactedProjectionNode: compactedNode.
	self assert: model visibilityState hasExpandedGaps.
	model selectedElement: sibling.
	self deny: model visibilityState hasExpandedGaps
]
