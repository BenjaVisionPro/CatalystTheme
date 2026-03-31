"
#Theme Style Rule Resolver Tests
I verify that active-rule resolution is explicit, scope-aware, and able to distinguish existing theme rules from bootstrapped editing targets.
"
Class {
	#name : 'CgtThemeStyleRuleResolverTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtThemeStyleRuleResolverTests >> testResolutionBootstrapsRuleWhenThemeHasNoMatchingRule [
	<gtExample>
	| root selected resolution |
	root := self newTestElementWithId: #'root'.
	selected := root addChild: (self newTestElementWithId: #'selected').
	resolution := CgtThemeStyleRuleResolver
		resolutionForSelectedElement: selected
		scopePath: (CgtElementPath anchorElement: selected)
		withinStyleRules: #()
		hierarchyRoot: root.
	self assert: resolution activeStyleRule notNil.
	self assert: resolution wasBootstrapped.
	self assert: resolution relatedStyleRules isEmpty.
	^ resolution
]

{ #category : 'tests' }
CgtThemeStyleRuleResolverTests >> testResolutionPrefersRuleMatchingCurrentUpstreamScopeDepth [
	<gtExample>
	| root middle selected simpleRule scopedRule path resolution |
	root := self newTestElementWithId: #'root'.
	middle := root addChild: (self newTestElementWithId: #'middle').
	selected := middle addChild: (self newTestElementWithId: #'selected').
	simpleRule := self styleRuleForSelector: (self selectorForId: #'selected').
	scopedRule := self styleRuleForSelector: (CgtThemeCombinatorSelector
		left: (self selectorForId: #'middle')
		combinator: #child
		right: (self selectorForId: #'selected')).
	path := CgtElementPath anchorElement: selected.
	path toggleUpstreamElement: middle.
	resolution := CgtThemeStyleRuleResolver
		resolutionForSelectedElement: selected
		scopePath: path
		withinStyleRules: { simpleRule. scopedRule }
		hierarchyRoot: root.
	self assert: resolution activeStyleRule identicalTo: scopedRule.
	self assert: resolution relatedStyleRules asArray equals: { simpleRule }.
	self deny: resolution wasBootstrapped.
	^ resolution
]

{ #category : 'tests' }
CgtThemeStyleRuleResolverTests >> testResolutionWithoutUpstreamScopePrefersSimpleSelectedRule [
	<gtExample>
	| root middle selected simpleRule scopedRule resolution |
	root := self newTestElementWithId: #'root'.
	middle := root addChild: (self newTestElementWithId: #'middle').
	selected := middle addChild: (self newTestElementWithId: #'selected').
	simpleRule := self styleRuleForSelector: (self selectorForId: #'selected').
	scopedRule := self styleRuleForSelector: (CgtThemeCombinatorSelector
		left: (self selectorForId: #'middle')
		combinator: #child
		right: (self selectorForId: #'selected')).
	resolution := CgtThemeStyleRuleResolver
		resolutionForSelectedElement: selected
		scopePath: (CgtElementPath anchorElement: selected)
		withinStyleRules: { simpleRule. scopedRule }
		hierarchyRoot: root.
	self assert: resolution activeStyleRule identicalTo: simpleRule.
	self assert: resolution relatedStyleRules asArray equals: { scopedRule }.
	^ resolution
]

{ #category : 'private' }
CgtThemeStyleRuleResolverTests >> newTestElementWithId: aSymbol [
	^ CgtThemeSelectorTestElement new
		id: (BlElementId named: aSymbol);
		yourself
]

{ #category : 'private' }
CgtThemeStyleRuleResolverTests >> selectorForId: aSymbol [
	^ CgtThemeSimpleSelector new
		addPredicate: (CgtThemeIdPredicate elementId: (BlElementId named: aSymbol));
		yourself
]

{ #category : 'private' }
CgtThemeStyleRuleResolverTests >> styleRuleForSelector: aSelector [
	^ CgtThemeStyleRule new
		selector: aSelector;
		yourself
]
