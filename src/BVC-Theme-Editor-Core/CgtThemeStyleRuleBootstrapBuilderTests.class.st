"
#Theme Style Rule Bootstrap Builder Tests
I verify that bootstrap selector/rule creation now comes from the live hierarchy rather than from an editor path object.
"
Class {
	#name : 'CgtThemeStyleRuleBootstrapBuilderTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtThemeStyleRuleBootstrapBuilderTests >> testBuildsRuleFromHierarchyRootToSelectedElement [
	<gtExample>
	| root child selected rule |
	root := self newTestElementWithId: #'root'.
	child := root addChild: (self newTestElementWithId: #'child').
	selected := child addChild: (self newTestElementWithId: #'selected').
	rule := CgtThemeStyleRuleBootstrapBuilder
		ruleForSelectedElement: selected
		withinHierarchyRoot: root.
	self assert: rule selector displayString equals: '#root > #child > #selected'.
	^ rule

]

{ #category : 'tests' }
CgtThemeStyleRuleBootstrapBuilderTests >> testFallsBackToSelectedElementWhenHierarchyRootIsNotOnAncestorChain [
	<gtExample>
	| root selected rule |
	root := self newTestElementWithId: #'root'.
	selected := self newTestElementWithId: #'selected'.
	rule := CgtThemeStyleRuleBootstrapBuilder
		ruleForSelectedElement: selected
		withinHierarchyRoot: root.
	self assert: rule selector displayString equals: '#selected'.
	^ rule

]

{ #category : 'private' }
CgtThemeStyleRuleBootstrapBuilderTests >> newTestElementWithId: aSymbol [
	^ CgtThemeSelectorTestElement new
		id: (BlElementId named: aSymbol);
		yourself
]
