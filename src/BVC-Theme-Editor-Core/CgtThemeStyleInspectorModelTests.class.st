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
