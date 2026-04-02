"
#Theme Bootstrap Cleanup Tests
I verify that bootstrap entry points live on the rule and selector domain classes without keeping the old path-based factories around.
"
Class {
	#name : 'CgtThemeBootstrapCleanupTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtThemeBootstrapCleanupTests >> testSelectorBootstrapClassSideEntryPointBuildsSelectedElementOnly [
	<gtExample>
	| root child selected selector |
	root := self newTestElementWithId: #'root'.
	child := root addChild: (self newTestElementWithId: #'child').
	selected := child addChild: (self newTestElementWithId: #'selected').
	selector := CgtThemeSelector
		bootstrapForSelectedElement: selected
		withinHierarchyRoot: root.
	self assert: selector displayString equals: '#selected'.
	^ selector

]

{ #category : 'tests' }
CgtThemeBootstrapCleanupTests >> testStyleRuleBootstrapClassSideEntryPointBuildsSelectedElementOnly [
	<gtExample>
	| root selected rule |
	root := self newTestElementWithId: #'root'.
	selected := root addChild: (self newTestElementWithId: #'selected').
	rule := CgtThemeStyleRule
		bootstrapForSelectedElement: selected
		withinHierarchyRoot: root.
	self assert: rule selector displayString equals: '#selected'.
	^ rule

]

{ #category : 'tests' }
CgtThemeBootstrapCleanupTests >> testThemeSelectorNoLongerRespondsToPathBootstrapFactory [
	<gtExample>
	self deny: (CgtThemeSelector class canUnderstand: #selectorFromElementPath:).
	^ CgtThemeSelector

]

{ #category : 'tests' }
CgtThemeBootstrapCleanupTests >> testThemeStyleRuleNoLongerRespondsToPathBootstrapFactory [
	<gtExample>
	self deny: (CgtThemeStyleRule class canUnderstand: #fromElementPath:).
	^ CgtThemeStyleRule

]

{ #category : 'private' }
CgtThemeBootstrapCleanupTests >> newTestElementWithId: aSymbol [.
	^ CgtThemeSelectorTestElement new
		id: (BlElementId named: aSymbol);
		yourself
]
