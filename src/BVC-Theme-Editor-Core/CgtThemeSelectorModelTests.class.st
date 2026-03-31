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
CgtThemeSelectorModelTests >> newTestElementWithId: anId [.
	^ CgtThemeSelectorTestElement new
		id: anId;
		yourself
]

{ #category : 'tests' }
CgtThemeSelectorModelTests >> testBuildsProjectionFromRuleAndHierarchyContext [
	<gtExample>
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
	self assert: model selector displayString equals: '#selected'.
	^ model

]

{ #category : 'tests' }
CgtThemeSelectorModelTests >> testClearsProjectionWhenSelectedElementBecomesNil [
	<gtExample>
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
	self assert: model projection isNil.
	^ model

]

{ #category : 'tests' }
CgtThemeSelectorModelTests >> testSelectorUpdatesCurrentStyleRule [
	<gtExample>
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
	self assert: model currentStyleRule selector identicalTo: newSelector.
	^ CgtThemeSelectorModel
]


{ #category : 'tests' }
CgtThemeSelectorModelTests >> testApplyClassMatchUpdatesStyleRuleAndProjection [
	<gtExample>
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
	self assert: model projection selectedProjectionNode matchByClass.
	^ model

]

{ #category : 'tests' }
CgtThemeSelectorModelTests >> testRevealCompactedProjectionNodeUpdatesVisibilityStateAndProjection [
	<gtExample>
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
	self assert: (model projection nodes anySatisfy: [ :each | each representedElement == middle ]).
	self deny: (model projection leadingCompactedGapIdentity = compactedNode gapIdentity).
	^ CgtThemeSelectorModel
]


{ #category : 'tests' }
CgtThemeSelectorModelTests >> testShowOtherRuleContextRebuildsProjectionWithOtherRuleNodes [
	<gtExample>
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
	self deny: model projection otherRuleNodes isEmpty.
	^ model

]

{ #category : 'tests' }
CgtThemeSelectorModelTests >> testHideOtherRuleContextRemovesOtherRuleNodesAgain [
	<gtExample>
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
	self assert: model projection otherRuleNodes isEmpty.
	^ CgtThemeSelectorModel
]


{ #category : 'tests' }
CgtThemeSelectorModelTests >> testSelectorMutationClearsTemporaryReveals [
	<gtExample>
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
	self assert: (model projection nodes anySatisfy: [ :each | each isCompactedSection ]).
	^ CgtThemeSelectorModel
]


{ #category : 'tests' }
CgtThemeSelectorModelTests >> testShowingOtherRuleContextClearsTemporaryReveals [
	<gtExample>
	| root middle selected currentRule relatedRule model compactedNode |
	root := self newTestElementWithId: #root.
	middle := self newTestElementWithId: #middle.
	selected := self newTestElementWithId: #selected.
	root addChild: middle.
	middle addChild: selected.
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
			combinator: #descendant
			right: (CgtThemeSimpleSelector new
				addPredicate: (CgtThemeIdPredicate elementId: #selected);
				yourself));
		yourself.
	model := CgtThemeSelectorModel new
		configureForStyleRule: currentRule
		selectedElement: selected
		hierarchyRoot: root
		relatedStyleRules: { relatedRule }.
	compactedNode := model projection nodes detect: [ :each | each isCompactedSection ].
	model revealCompactedProjectionNode: compactedNode.
	self assert: model visibilityState hasExpandedGaps.
	model showOtherRuleContext.
	self deny: model visibilityState hasExpandedGaps.
	^ model

]

{ #category : 'tests' }
CgtThemeSelectorModelTests >> testHidingOtherRuleContextClearsTemporaryReveals [
	<gtExample>
	| root middle selected currentRule relatedRule model compactedNode |
	root := self newTestElementWithId: #root.
	middle := self newTestElementWithId: #middle.
	selected := self newTestElementWithId: #selected.
	root addChild: middle.
	middle addChild: selected.
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
			combinator: #descendant
			right: (CgtThemeSimpleSelector new
				addPredicate: (CgtThemeIdPredicate elementId: #selected);
				yourself));
		yourself.
	model := CgtThemeSelectorModel new
		configureForStyleRule: currentRule
		selectedElement: selected
		hierarchyRoot: root
		relatedStyleRules: { relatedRule }.
	compactedNode := model projection nodes detect: [ :each | each isCompactedSection ].
	model revealCompactedProjectionNode: compactedNode.
	model showOtherRuleContext.
	compactedNode := model projection nodes detect: [ :each | each isCompactedSection ] ifNone: [ nil ].
	compactedNode ifNotNil: [ model revealCompactedProjectionNode: compactedNode ].
	self assert: model visibilityState hasExpandedGaps.
	model hideOtherRuleContext.
	self deny: model visibilityState hasExpandedGaps.
	^ model

]

{ #category : 'tests' }
CgtThemeSelectorModelTests >> testSelectedElementChangeClearsTemporaryReveals [
	<gtExample>
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
	self deny: model visibilityState hasExpandedGaps.
	^ model

]


{ #category : 'tests' }
CgtThemeSelectorModelTests >> testConfigureForStyleInspectorModelUsesInspectorSessionContext [
	<gtExample>
	| root selected currentRule relatedRule inspectorModel selectorModel |
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
	selectorModel := CgtThemeSelectorModel new.
	selectorModel configureForStyleInspectorModel: inspectorModel.
	self assert: selectorModel currentStyleRule identicalTo: currentRule.
	self assert: selectorModel selectedElement identicalTo: selected.
	self assert: selectorModel hierarchyRoot identicalTo: root.
	self assert: selectorModel relatedStyleRules asArray equals: { relatedRule }.
	self assert: selectorModel projection notNil.
	^ selectorModel
]
