"
#Style Inspector Popover Tests
I verify that the style inspector popover now projects a selector rule through the Mondrian matcher widget and keeps the rule display synchronized with matcher edits.
"
Class {
	#name : 'CgtStyleInspectorPopoverTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtStyleInspectorPopoverTests >> testBuildsMatcherProjectionFromStyleRuleAndSelectedElement [
	| root selected rule popover projection |
	root := self newTestElementWithId: #'root'.
	selected := root addChild: (self newTestElementWithId: #'selected').
	rule := self styleRuleForSelector: (CgtThemeCombinatorSelector
		left: (self selectorForId: #'root')
		combinator: #child
		right: (self selectorForId: #'selected')).
	popover := CgtStyleInspectorPopover new.
	popover pathRootElement: root.
	popover selectedElement: selected.
	popover styleRule: rule.
	projection := popover selectorWidget projection.
	self assert: projection notNil.
	self assert: projection selectedElement identicalTo: selected.
	self assert: projection nodes size equals: 2.
	self assert: (popover childWithId: #styleInspectorScopeLabel) text asString equals: '#root > #selected'
]

{ #category : 'tests' }
CgtStyleInspectorPopoverTests >> testElementPathStillFeedsSelectedElementIntoMatcherProjection [
	| root selected path rule popover projection |
	root := self newTestElementWithId: #'root'.
	selected := root addChild: (self newTestElementWithId: #'selected').
	path := CgtElementPath anchorElement: selected.
	rule := self styleRuleForSelector: (self selectorForId: #'selected').
	popover := CgtStyleInspectorPopover new.
	popover pathRootElement: root.
	popover elementPath: path.
	popover styleRule: rule.
	projection := popover selectorWidget projection.
	self assert: projection notNil.
	self assert: projection selectedElement identicalTo: selected.
	self assert: projection nodes first representedElement identicalTo: selected
]

{ #category : 'private' }
CgtStyleInspectorPopoverTests >> newTestElementWithId: aSymbol [
	^ CgtThemeSelectorTestElement new
		id: (BlElementId named: aSymbol);
		yourself
]

{ #category : 'private' }
CgtStyleInspectorPopoverTests >> selectorForId: aSymbol [
	^ CgtThemeSimpleSelector new
		addPredicate: (CgtThemeIdPredicate elementId: (BlElementId named: aSymbol));
		yourself
]

{ #category : 'private' }
CgtStyleInspectorPopoverTests >> styleRuleForSelector: aSelector [
	^ CgtThemeStyleRule new
		selector: aSelector;
		yourself
]
