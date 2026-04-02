"
#Theme Style Rule Bootstrap Builder Tests
I verify that bootstrap selector/rule creation starts from the selected live element only.
"
Class {
	#name : 'CgtThemeStyleRuleBootstrapBuilderTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtThemeStyleRuleBootstrapBuilderTests >> testBuildsRuleForSelectedElementOnly [
	<gtExample>
	| root child selected rule |
	root := self newTestElementWithId: #'root'.
	child := root addChild: (self newTestElementWithId: #'child').
	selected := child addChild: (self newTestElementWithId: #'selected').
	rule := CgtThemeStyleRuleBootstrapBuilder
		ruleForSelectedElement: selected
		withinHierarchyRoot: root.
	self assert: rule selector displayString equals: '#selected'.
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
CgtThemeStyleRuleBootstrapBuilderTests >> newTestElementWithId: aSymbol [.
	^ CgtThemeSelectorTestElement new
		id: (BlElementId named: aSymbol);
		yourself
]
