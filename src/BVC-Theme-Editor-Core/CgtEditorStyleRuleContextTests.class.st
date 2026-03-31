"
#Editor Style Rule Context Tests
I verify that the editor forwards related style rule context into the style inspector flow and keeps the inspected rule in the context set when matcher edits occur.
"
Class {
	#name : 'CgtEditorStyleRuleContextTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtEditorStyleRuleContextTests >> testRelatedStyleRulesForStyleInspectorExcludeCurrentRule [
	| editor currentRule relatedRule |
	editor := self newEditor.
	currentRule := self styleRuleForSelector: (self selectorForId: #'selected').
	relatedRule := self styleRuleForSelector: (self selectorForId: #'root').
	editor styleRules: { currentRule. relatedRule }.
	editor instVarNamed: 'styleInspectorRule' put: currentRule.
	self assert: editor relatedStyleRulesForStyleInspector asArray equals: { relatedRule }
]

{ #category : 'tests' }
CgtEditorStyleRuleContextTests >> testMatcherSelectorChangedEventAddsInspectedRuleToStyleRules [
	| editor rule event selector |
	editor := self newEditor.
	rule := CgtThemeStyleRule new.
	editor instVarNamed: 'styleInspectorRule' put: rule.
	selector := self selectorForId: #'selected'.
	event := CgtThemeSelectorChangedEvent new
		selector: selector;
		yourself.
	editor matcherSelectorChangedEvent: event.
	self assert: rule selector identicalTo: selector.
	self assert: (editor styleRules includes: rule)
]

{ #category : 'private' }
CgtEditorStyleRuleContextTests >> newEditor [
	^ CgtEditor new initializeWith: BlElement new
]

{ #category : 'private' }
CgtEditorStyleRuleContextTests >> selectorForId: aSymbol [
	^ CgtThemeSimpleSelector new
		addPredicate: (CgtThemeIdPredicate elementId: (BlElementId named: aSymbol));
		yourself
]

{ #category : 'private' }
CgtEditorStyleRuleContextTests >> styleRuleForSelector: aSelector [
	^ CgtThemeStyleRule new
		selector: aSelector;
		yourself
]
