"
#Matcher Projection Builder Tests
I verify projection building from a selector rule, a selected element, and a live hierarchy. I am responsible for checking current-rule mapping, downstream mapping, compaction, and no-match fallback behavior.
"
Class {
	#name : 'CgtMatcherProjectionBuilderTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtMatcherProjectionBuilderTests >> testBuildsCompactedSectionForDescendantGap [
	| root middle selected rule projection compacted |
	root := self newTestElementWithId: #'root'.
	middle := root addChild: (self newTestElementWithId: #'middle').
	selected := middle addChild: (self newTestElementWithId: #'selected').
	rule := self styleRuleForSelector: (CgtThemeCombinatorSelector
		left: (self selectorForId: #'root')
		combinator: #descendant
		right: (self selectorForId: #'selected')).
	projection := CgtMatcherProjectionBuilder
		projectionForStyleRule: rule
		selectedElement: selected
		hierarchyRoot: root.
	compacted := projection nodes second.
	self assert: (projection nodes collect: [ :each | each kind ]) asArray equals: #(upstreamScope compactedSection selectedElement).
	self assert: compacted hiddenNodeCount equals: 1.
	self deny: compacted isEditable.
	self assert: compacted representedElements asArray equals: { middle }.
	self assert: projection relations size equals: 2.
	self assert: projection relations first kind equals: #compaction.
	self assert: projection relations second kind equals: #matcher.
	self assert: projection relations second combinator equals: #descendant
]

{ #category : 'tests' }
CgtMatcherProjectionBuilderTests >> testBuildsProjectionForSelectedElementAtTerminalRuleStep [
	| root selected rule projection |
	root := self newTestElementWithId: #'root'.
	selected := root addChild: (self newTestElementWithId: #'selected').
	rule := self styleRuleForSelector: (CgtThemeCombinatorSelector
		left: (self selectorForId: #'root')
		combinator: #child
		right: (self selectorForId: #'selected')).
	projection := CgtMatcherProjectionBuilder
		projectionForStyleRule: rule
		selectedElement: selected
		hierarchyRoot: root.
	self assert: (projection nodes collect: [ :each | each kind ]) asArray equals: #(upstreamScope selectedElement).
	self assert: projection currentRuleNodes size equals: 2.
	self assert: projection relations size equals: 1.
	self assert: projection relations first kind equals: #matcher.
	self assert: projection relations first combinator equals: #child
]

{ #category : 'tests' }
CgtMatcherProjectionBuilderTests >> testBuildsProjectionWithDownstreamScopeWhenSelectedMatchesEarlierRuleStep [
	| selected child rule projection |
	selected := self newTestElementWithId: #'selected'.
	child := selected addChild: (self newTestElementWithId: #'child').
	rule := self styleRuleForSelector: (CgtThemeCombinatorSelector
		left: (self selectorForId: #'selected')
		combinator: #child
		right: (self selectorForId: #'child')).
	projection := CgtMatcherProjectionBuilder
		projectionForStyleRule: rule
		selectedElement: selected
		hierarchyRoot: selected.
	self assert: (projection nodes collect: [ :each | each kind ]) asArray equals: #(selectedElement downstreamScope).
	self assert: projection currentRuleNodes size equals: 2.
	self assert: projection relations first combinator equals: #child.
	self assert: projection nodes second representedElement identicalTo: child
]

{ #category : 'tests' }
CgtMatcherProjectionBuilderTests >> testFallsBackToStandaloneSelectedNodeWhenRuleDoesNotMatchSelectedElement [
	| root child selected rule projection |
	root := self newTestElementWithId: #'root'.
	child := root addChild: (self newTestElementWithId: #'child').
	selected := self newTestElementWithId: #'selected'.
	rule := self styleRuleForSelector: (CgtThemeCombinatorSelector
		left: (self selectorForId: #'root')
		combinator: #child
		right: (self selectorForId: #'child')).
	projection := CgtMatcherProjectionBuilder
		projectionForStyleRule: rule
		selectedElement: selected
		hierarchyRoot: root.
	self assert: projection nodes size equals: 1.
	self assert: projection nodes first kind equals: #selectedElement.
	self deny: projection nodes first isInCurrentRule.
	self assert: projection relations isEmpty
]


{ #category : 'tests' }
CgtMatcherProjectionBuilderTests >> testMarksSelectedNodeAsInOtherRuleWhenRelatedRuleAlsoMatchesSelectedElement [
	| root selected currentRule relatedRule projection selectedNode |
	root := self newTestElementWithId: #'root'.
	selected := root addChild: (self newTestElementWithId: #'selected').
	currentRule := self styleRuleForSelector: (self selectorForId: #'selected').
	relatedRule := self styleRuleForSelector: (CgtThemeCombinatorSelector
		left: (self selectorForId: #'root')
		combinator: #child
		right: (self selectorForId: #'selected')).
	projection := CgtMatcherProjectionBuilder
		projectionForStyleRule: currentRule
		selectedElement: selected
		hierarchyRoot: root
		relatedStyleRules: { relatedRule }
		visibilityState: (CgtMatcherVisibilityState new showsOtherRuleContext: true; yourself).
	selectedNode := projection nodes detect: [ :each | each kind = #selectedElement ].
	self assert: selectedNode isInCurrentRule.
	self assert: selectedNode isInOtherRule
]

{ #category : 'tests' }
CgtMatcherProjectionBuilderTests >> testAddsOtherRuleNodesForRelatedRuleContext [
	| root selected sibling currentRule relatedRule projection otherRuleNode otherRelation |
	root := self newTestElementWithId: #'root'.
	selected := root addChild: (self newTestElementWithId: #'selected').
	sibling := selected addChild: (self newTestElementWithId: #'otherChild').
	currentRule := self styleRuleForSelector: (self selectorForId: #'selected').
	relatedRule := self styleRuleForSelector: (CgtThemeCombinatorSelector
		left: (self selectorForId: #'selected')
		combinator: #child
		right: (self selectorForId: #'otherChild')).
	projection := CgtMatcherProjectionBuilder
		projectionForStyleRule: currentRule
		selectedElement: selected
		hierarchyRoot: root
		relatedStyleRules: { relatedRule }
		visibilityState: (CgtMatcherVisibilityState new showsOtherRuleContext: true; yourself).
	otherRuleNode := projection otherRuleNodes detect: [ :each | each representedElement == sibling ].
	self deny: otherRuleNode isInCurrentRule.
	self assert: otherRuleNode isInOtherRule.
	self deny: otherRuleNode isEditable.
	otherRelation := projection relations detect: [ :each | each kind = #otherRule ].
	self assert: otherRelation fromNode representedElement identicalTo: selected.
	self assert: otherRelation toNode representedElement identicalTo: sibling.
	self assert: otherRelation combinator equals: #child
]

{ #category : 'private' }
CgtMatcherProjectionBuilderTests >> newTestElementWithId: aSymbol [
	^ CgtThemeSelectorTestElement new
		id: (BlElementId named: aSymbol);
		yourself
]

{ #category : 'private' }
CgtMatcherProjectionBuilderTests >> selectorForId: aSymbol [
	^ CgtThemeSimpleSelector new
		addPredicate: (CgtThemeIdPredicate elementId: (BlElementId named: aSymbol));
		yourself
]

{ #category : 'private' }
CgtMatcherProjectionBuilderTests >> styleRuleForSelector: aSelector [
	^ CgtThemeStyleRule new
		selector: aSelector;
		yourself
]


{ #category : 'tests' }
CgtMatcherProjectionBuilderTests >> testBuildsLeadingCompactedSectionForSingleSelectedRule [
	| root middle selected rule projection leadingGap |
	root := self newTestElementWithId: #'root'.
	middle := root addChild: (self newTestElementWithId: #'middle').
	selected := middle addChild: (self newTestElementWithId: #'selected').
	rule := self styleRuleForSelector: (self selectorForId: #'selected').
	projection := CgtMatcherProjectionBuilder
		projectionForStyleRule: rule
		selectedElement: selected
		hierarchyRoot: root.
	self assert: (projection nodes count: [ :each | each kind = #compactedSection ]) equals: 1.
	leadingGap := projection nodes detect: [ :each | each kind = #compactedSection ].
	self assert: leadingGap hiddenNodeCount equals: 2.
	self assert: leadingGap representedElements asArray equals: { root. middle }.
	self assert: (projection relations anySatisfy: [ :each |
		each kind = #compaction and: [ each toNode kind = #selectedElement ] ])
]

{ #category : 'tests' }
CgtMatcherProjectionBuilderTests >> testBuildsLeadingAndTrailingCompactedSectionsAroundFocusedCorridor [
	| root selected child grandChild rule projection compactedNodes |
	root := self newTestElementWithId: #'root'.
	selected := root addChild: (self newTestElementWithId: #'selected').
	child := selected addChild: (self newTestElementWithId: #'child').
	grandChild := child addChild: (self newTestElementWithId: #'grandChild').
	rule := self styleRuleForSelector: (self selectorForId: #'selected').
	projection := CgtMatcherProjectionBuilder
		projectionForStyleRule: rule
		selectedElement: selected
		hierarchyRoot: root.
	compactedNodes := projection nodes select: [ :each | each kind = #compactedSection ].
	self assert: compactedNodes size equals: 1.
	self assert: compactedNodes first representedElements asArray equals: { child. grandChild }.
	self assert: (projection relations anySatisfy: [ :each |
		each kind = #compaction and: [ each fromNode kind = #selectedElement ] ])
]


{ #category : 'tests' }
CgtMatcherProjectionBuilderTests >> testKeepsDescendantGapCompactedByDefaultWhenVisibilityStateIsCollapsed [
	| root middle selected rule projection compactedNode state |
	root := self newTestElementWithId: #'root'.
	middle := root addChild: (self newTestElementWithId: #'middle').
	selected := middle addChild: (self newTestElementWithId: #'selected').
	rule := self styleRuleForSelector: (CgtThemeCombinatorSelector
		left: (self selectorForId: #'root')
		combinator: #descendant
		right: (self selectorForId: #'selected')).
	state := CgtMatcherVisibilityState new.
	projection := CgtMatcherProjectionBuilder
		projectionForStyleRule: rule
		selectedElement: selected
		hierarchyRoot: root
		relatedStyleRules: #()
		visibilityState: state.
	compactedNode := projection nodes detect: [ :each | each kind = #compactedSection ].
	self assert: compactedNode representedElements asArray equals: { middle }
]

{ #category : 'tests' }
CgtMatcherProjectionBuilderTests >> testRevealsDescendantGapWhenVisibilityStateMarksGapExpanded [
	| root middle selected rule projection state |
	root := self newTestElementWithId: #'root'.
	middle := root addChild: (self newTestElementWithId: #'middle').
	selected := middle addChild: (self newTestElementWithId: #'selected').
	rule := self styleRuleForSelector: (CgtThemeCombinatorSelector
		left: (self selectorForId: #'root')
		combinator: #descendant
		right: (self selectorForId: #'selected')).
	state := CgtMatcherVisibilityState new
		expandElements: { middle };
		yourself.
	projection := CgtMatcherProjectionBuilder
		projectionForStyleRule: rule
		selectedElement: selected
		hierarchyRoot: root
		relatedStyleRules: #()
		visibilityState: state.
	self assert: (projection nodes noneSatisfy: [ :each | each kind = #compactedSection ]).
	self assert: (projection nodes anySatisfy: [ :each | each representedElement == middle and: [ each isEditable ] ])
]

{ #category : 'tests' }
CgtMatcherProjectionBuilderTests >> testHidesOtherRuleContextByDefaultThroughVisibilityState [
	| root selected other currentRule relatedRule projection state |
	root := self newTestElementWithId: #'root'.
	selected := root addChild: (self newTestElementWithId: #'selected').
	other := selected addChild: (self newTestElementWithId: #'otherChild').
	currentRule := self styleRuleForSelector: (self selectorForId: #'selected').
	relatedRule := self styleRuleForSelector: (CgtThemeCombinatorSelector
		left: (self selectorForId: #'selected')
		combinator: #child
		right: (self selectorForId: #'otherChild')).
	state := CgtMatcherVisibilityState new.
	projection := CgtMatcherProjectionBuilder
		projectionForStyleRule: currentRule
		selectedElement: selected
		hierarchyRoot: root
		relatedStyleRules: { relatedRule }
		visibilityState: state.
	self assert: projection otherRuleNodes isEmpty
]
