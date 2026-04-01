"
#Theme Style Inspector Model Tests
I verify that the style-inspector model owns session semantics above the selector model and keeps the selector model synchronized with the active rule context.
"
Class {
	#name : 'CgtThemeStyleInspectorModelTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtThemeStyleInspectorModelTests >> testConfigureForStyleRuleSelectedElementHierarchyRootRelatedStyleRulesConfiguresSelectorModel [
	<gtExample>
	| root selected currentRule relatedRule model projection |
	root := self newTestElementWithId: #'root'.
	selected := root addChild: (self newTestElementWithId: #'selected').
	currentRule := self styleRuleForSelector: (self selectorForId: #'selected').
	relatedRule := self styleRuleForSelector: (CgtThemeCombinatorSelector
		left: (self selectorForId: #'root')
		combinator: #child
		right: (self selectorForId: #'selected')).
	model := CgtThemeStyleInspectorModel new.
	model
		configureForStyleRule: currentRule
		selectedElement: selected
		hierarchyRoot: root
		relatedStyleRules: { relatedRule }.
	projection := model selectorModel projection.
	self assert: model activeStyleRule identicalTo: currentRule.
	self assert: model selectedElement identicalTo: selected.
	self assert: model hierarchyRoot identicalTo: root.
	self assert: model relatedStyleRules asArray equals: { relatedRule }.
	self assert: model themeStyleRules asArray equals: { currentRule. relatedRule }.
	self assert: model selectedScopePath notNil.
	self assert: model selectedScopePath anchorElement identicalTo: selected.
	self assert: projection notNil.
	self assert: projection selectedElement identicalTo: selected.
	^ model
]

{ #category : 'tests' }
CgtThemeStyleInspectorModelTests >> testActiveStyleRuleChangeRefreshesSelectorModel [
	<gtExample>
	| root selected originalRule replacementRule model projection |
	root := self newTestElementWithId: #'root'.
	selected := root addChild: (self newTestElementWithId: #'selected').
	originalRule := self styleRuleForSelector: (self selectorForId: #'selected').
	replacementRule := self styleRuleForSelector: (CgtThemeCombinatorSelector
		left: (self selectorForId: #'root')
		combinator: #child
		right: (self selectorForId: #'selected')).
	model := CgtThemeStyleInspectorModel new.
	model
		configureForStyleRule: originalRule
		selectedElement: selected
		hierarchyRoot: root
		relatedStyleRules: #().
	model activeStyleRule: replacementRule.
	projection := model selectorModel projection.
	self assert: model activeStyleRule identicalTo: replacementRule.
	self assert: model selectorModel currentStyleRule identicalTo: replacementRule.
	self assert: projection notNil.
	self assert: projection nodes size equals: 2.
	^ model
]

{ #category : 'tests' }
CgtThemeStyleInspectorModelTests >> testStyleInspectorModelCanBeInstalledIntoPopover [
	<gtExample>
	| root selected currentRule relatedRule model popover |
	root := self newTestElementWithId: #'root'.
	selected := root addChild: (self newTestElementWithId: #'selected').
	currentRule := self styleRuleForSelector: (self selectorForId: #'selected').
	relatedRule := self styleRuleForSelector: (CgtThemeCombinatorSelector
		left: (self selectorForId: #'root')
		combinator: #child
		right: (self selectorForId: #'selected')).
	model := CgtThemeStyleInspectorModel new
		configureForStyleRule: currentRule
		selectedElement: selected
		hierarchyRoot: root
		relatedStyleRules: { relatedRule };
		yourself.
	popover := CgtStyleInspectorPopover new.
	popover configureForStyleInspectorModel: model.
	self assert: popover styleInspectorModel identicalTo: model.
	self assert: popover selectorModel identicalTo: model selectorModel.
	self assert: popover styleRule identicalTo: currentRule.
	self assert: popover selectedElement identicalTo: selected.
	^ popover
]


{ #category : 'tests' }
CgtThemeStyleInspectorModelTests >> testSelectedScopePathChangeResolvesDifferentActiveRule [
	<gtExample>
	| root middle selected simpleRule scopedRule model path |
	root := self newTestElementWithId: #'root'.
	middle := root addChild: (self newTestElementWithId: #'middle').
	selected := middle addChild: (self newTestElementWithId: #'selected').
	simpleRule := self styleRuleForSelector: (self selectorForId: #'selected').
	scopedRule := self styleRuleForSelector: (CgtThemeCombinatorSelector
		left: (self selectorForId: #'middle')
		combinator: #child
		right: (self selectorForId: #'selected')).
	model := CgtThemeStyleInspectorModel new.
	model
		configureForSelectedElement: selected
		hierarchyRoot: root
		selectedScopePath: (CgtElementPath anchorElement: selected)
		themeStyleRules: { simpleRule. scopedRule }.
	self assert: model activeStyleRule identicalTo: simpleRule.
	path := CgtElementPath anchorElement: selected.
	path toggleUpstreamElement: middle.
	model selectedScopePath: path.
	self assert: model activeStyleRule identicalTo: scopedRule.
	self assert: model relatedStyleRules asArray equals: { simpleRule }.
	self assert: model selectorModel currentStyleRule identicalTo: scopedRule.
	^ model
]


{ #category : 'tests' }
CgtThemeStyleInspectorModelTests >> testScopeChangeClearsTemporaryRevealStateWhenActiveRuleSwitches [
	<gtExample>
	| root middle selected simpleRule scopedRule model compactedNode path |
	root := self newTestElementWithId: #'root'.
	middle := root addChild: (self newTestElementWithId: #'middle').
	selected := middle addChild: (self newTestElementWithId: #'selected').
	simpleRule := self styleRuleForSelector: (self selectorForId: #'selected').
	scopedRule := self styleRuleForSelector: (CgtThemeCombinatorSelector
		left: (self selectorForId: #'middle')
		combinator: #child
		right: (self selectorForId: #'selected')).
	model := CgtThemeStyleInspectorModel new.
	model
		configureForSelectedElement: selected
		hierarchyRoot: root
		selectedScopePath: (CgtElementPath anchorElement: selected)
		themeStyleRules: { simpleRule. scopedRule }.
	compactedNode := model selectorModel compactedProjectionNodes first.
	model selectorModel revealCompactedProjectionNode: compactedNode.
	self assert: model selectorModel hasExpandedCompactedContext.
	path := CgtElementPath anchorElement: selected.
	path toggleUpstreamElement: middle.
	model selectedScopePath: path.
	self assert: model activeStyleRule identicalTo: scopedRule.
	self deny: model selectorModel hasExpandedCompactedContext.
	^ model
]

{ #category : 'tests' }
CgtThemeStyleInspectorModelTests >> testScopeChangeUpdatesRelatedRuleContextWhileOtherRuleContextIsVisible [
	<gtExample>
	| root middle selected simpleRule scopedRule model path |
	root := self newTestElementWithId: #'root'.
	middle := root addChild: (self newTestElementWithId: #'middle').
	selected := middle addChild: (self newTestElementWithId: #'selected').
	simpleRule := self styleRuleForSelector: (self selectorForId: #'selected').
	scopedRule := self styleRuleForSelector: (CgtThemeCombinatorSelector
		left: (self selectorForId: #'middle')
		combinator: #child
		right: (self selectorForId: #'selected')).
	model := CgtThemeStyleInspectorModel new.
	model
		configureForSelectedElement: selected
		hierarchyRoot: root
		selectedScopePath: (CgtElementPath anchorElement: selected)
		themeStyleRules: { simpleRule. scopedRule }.
	model selectorModel showOtherRuleContext.
	self assert: model selectorModel showsOtherRuleContext.
	self assert: (model selectorModel otherRuleProjectionNodes anySatisfy: [ :each |
		each representedElement == middle ]).
	path := CgtElementPath anchorElement: selected.
	path toggleUpstreamElement: middle.
	model selectedScopePath: path.
	self assert: model activeStyleRule identicalTo: scopedRule.
	self assert: model relatedStyleRules asArray equals: { simpleRule }.
	self assert: model selectorModel showsOtherRuleContext.
	self deny: (model selectorModel otherRuleProjectionNodes anySatisfy: [ :each |
		each representedElement == middle ]).
	self assert: (model selectorModel otherRuleProjectionNodes anySatisfy: [ :each |
		each representedElement == selected ]).
	^ model
]

{ #category : 'tests' }
CgtThemeStyleInspectorModelTests >> testActiveStyleRuleChangeClearsTemporaryRevealState [
	<gtExample>
	| root middle selected simpleRule scopedRule model compactedNode |
	root := self newTestElementWithId: #'root'.
	middle := root addChild: (self newTestElementWithId: #'middle').
	selected := middle addChild: (self newTestElementWithId: #'selected').
	simpleRule := self styleRuleForSelector: (self selectorForId: #'selected').
	scopedRule := self styleRuleForSelector: (CgtThemeCombinatorSelector
		left: (self selectorForId: #'middle')
		combinator: #child
		right: (self selectorForId: #'selected')).
	model := CgtThemeStyleInspectorModel new.
	model
		configureForStyleRule: simpleRule
		selectedElement: selected
		hierarchyRoot: root
		relatedStyleRules: { scopedRule }.
	compactedNode := model selectorModel compactedProjectionNodes first.
	model selectorModel revealCompactedProjectionNode: compactedNode.
	self assert: model selectorModel hasExpandedCompactedContext.
	model activeStyleRule: scopedRule.
	self assert: model activeStyleRule identicalTo: scopedRule.
	self deny: model selectorModel hasExpandedCompactedContext.
	^ model
]

{ #category : 'private' }
CgtThemeStyleInspectorModelTests >> newTestElementWithId: aSymbol [
	^ CgtThemeSelectorTestElement new
		id: (BlElementId named: aSymbol);
		yourself
]

{ #category : 'private' }
CgtThemeStyleInspectorModelTests >> selectorForId: aSymbol [
	^ CgtThemeSimpleSelector new
		addPredicate: (CgtThemeIdPredicate elementId: (BlElementId named: aSymbol));
		yourself
]

{ #category : 'private' }
CgtThemeStyleInspectorModelTests >> styleRuleForSelector: aSelector [
	^ CgtThemeStyleRule new
		selector: aSelector;
		yourself
]


{ #category : 'tests' }
CgtThemeStyleInspectorModelTests >> testSelectedScopePathChangeAnnouncesScopeChangedEvent [
	<gtExample>
	| root middle selected simpleRule scopedRule model path events |
	root := self newTestElementWithId: #'root'.
	middle := root addChild: (self newTestElementWithId: #'middle').
	selected := middle addChild: (self newTestElementWithId: #'selected').
	simpleRule := self styleRuleForSelector: (self selectorForId: #'selected').
	scopedRule := self styleRuleForSelector: (CgtThemeCombinatorSelector
		left: (self selectorForId: #'middle')
		combinator: #child
		right: (self selectorForId: #'selected')).
	events := OrderedCollection new.
	model := CgtThemeStyleInspectorModel new.
	model when: CgtThemeStyleInspectorScopeChangedEvent do: [ :anEvent | events add: anEvent ].
	model
		configureForSelectedElement: selected
		hierarchyRoot: root
		selectedScopePath: (CgtElementPath anchorElement: selected)
		themeStyleRules: { simpleRule. scopedRule }.
	path := CgtElementPath anchorElement: selected.
	path toggleUpstreamElement: middle.
	model selectedScopePath: path.
	self assert: events size equals: 1.
	self assert: events first previousScopePath anchorElement identicalTo: selected.
	self assert: events first scopePath identicalTo: path.
	^ model
]

{ #category : 'tests' }
CgtThemeStyleInspectorModelTests >> testSelectedScopePathChangeAnnouncesActiveRuleChangedEvent [
	<gtExample>
	| root middle selected simpleRule scopedRule model path events |
	root := self newTestElementWithId: #'root'.
	middle := root addChild: (self newTestElementWithId: #'middle').
	selected := middle addChild: (self newTestElementWithId: #'selected').
	simpleRule := self styleRuleForSelector: (self selectorForId: #'selected').
	scopedRule := self styleRuleForSelector: (CgtThemeCombinatorSelector
		left: (self selectorForId: #'middle')
		combinator: #child
		right: (self selectorForId: #'selected')).
	events := OrderedCollection new.
	model := CgtThemeStyleInspectorModel new.
	model
		configureForSelectedElement: selected
		hierarchyRoot: root
		selectedScopePath: (CgtElementPath anchorElement: selected)
		themeStyleRules: { simpleRule. scopedRule }.
	model when: CgtThemeStyleInspectorActiveRuleChangedEvent do: [ :anEvent | events add: anEvent ].
	path := CgtElementPath anchorElement: selected.
	path toggleUpstreamElement: middle.
	model selectedScopePath: path.
	self assert: events size equals: 1.
	self assert: events first previousActiveStyleRule identicalTo: simpleRule.
	self assert: events first activeStyleRule identicalTo: scopedRule.
	self assert: events first previousRelatedStyleRules asArray equals: { scopedRule }.
	self assert: events first relatedStyleRules asArray equals: { simpleRule }.
	^ model
]
