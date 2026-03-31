"
#Matcher Transition Policy Tests
I verify matcher transition policy defaults used by the matcher visual transitions.
"
Class {
	#name : 'CgtMatcherTransitionPolicyTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testHorizontalCorridorExpandsTowardLeft [
	self
		assert: (CgtMatcherTransitionPolicy new leadingExpansionSideForOrientation: #horizontal)
		equals: #left
]

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testKeepsFollowingNodeFixed [
	self assert: CgtMatcherTransitionPolicy new keepsFollowingNodeFixed
]

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testVerticalCorridorExpandsTowardUp [
	self
		assert: (CgtMatcherTransitionPolicy new leadingExpansionSideForOrientation: #vertical)
		equals: #up
]

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testVerticalRevealOffsetMovesUpward [
	self
		assert: (CgtMatcherTransitionPolicy new graphRevealOffsetForOrientation: #vertical)
		equals: (0 @ -24)
]


{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testStructuralRefreshAnchorUsesFollowingVisibleNodeAfterLeadingCompaction [
	| projection leadingGap selected relation policy |
	leadingGap := (CgtMatcherProjectionNode kind: #compactedSection)
		hiddenNodeCount: 2;
		yourself.
	selected := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: (CgtThemeSelectorTestElement named: #selected id: #selected);
		yourself.
	relation := CgtMatcherProjectionRelation from: leadingGap to: selected kind: #compaction.
	projection := CgtMatcherProjection new.
	projection
		selectedElement: selected representedElement;
		addNode: leadingGap;
		addNode: selected;
		addRelation: relation.
	policy := CgtMatcherTransitionPolicy new.
	self assert: (policy structuralRefreshAnchorProjectionNodeFor: projection) identicalTo: selected
]

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testStructuralRefreshRevealOffsetUsesLeadingCompactedGapOnly [
	| leadingProjection trailingProjection selected leadingGap trailingGap relation policy |
	selected := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: (CgtThemeSelectorTestElement named: #selected id: #selected);
		yourself.
	leadingGap := (CgtMatcherProjectionNode kind: #compactedSection)
		hiddenNodeCount: 2;
		yourself.
	trailingGap := (CgtMatcherProjectionNode kind: #compactedSection)
		hiddenNodeCount: 2;
		yourself.
	leadingProjection := CgtMatcherProjection new.
	leadingProjection
		selectedElement: selected representedElement;
		addNode: leadingGap;
		addNode: selected;
		addRelation: (CgtMatcherProjectionRelation from: leadingGap to: selected kind: #compaction).
	trailingProjection := CgtMatcherProjection new.
	trailingProjection
		selectedElement: selected representedElement;
		addNode: selected;
		addNode: trailingGap;
		addRelation: (CgtMatcherProjectionRelation from: selected to: trailingGap kind: #compaction).
	policy := CgtMatcherTransitionPolicy new.
	self assert: (policy structuralRefreshRevealOffsetForProjection: leadingProjection orientation: #vertical) equals: (0 @ -24).
	self assert: (policy structuralRefreshRevealOffsetForProjection: trailingProjection orientation: #vertical) equals: (0 @ 0)
]


{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> test_structuralRefreshPlanUsesRevealWhenLeadingCompactionAppears [
	| oldProjection newProjection plan oldSelected newSelected leadingGap selectedNode |
	oldSelected := CgtThemeSelectorTestElement new className: 'Selected'; yourself.
	newSelected := CgtThemeSelectorTestElement new className: 'Selected'; yourself.
	oldProjection := CgtMatcherProjection new.
	oldProjection
		selectedElement: oldSelected;
		addNode: ((CgtMatcherProjectionNode kind: #selectedElement)
			representedElement: oldSelected;
			yourself).
	newProjection := CgtMatcherProjection new.
	leadingGap := (CgtMatcherProjectionNode kind: #compactedSection)
		representedElements: { CgtThemeSelectorTestElement new className: 'Hidden'; yourself };
		yourself.
	selectedNode := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: newSelected;
		yourself.
	newProjection
		selectedElement: newSelected;
		addNode: leadingGap;
		addNode: selectedNode;
		addRelation: (CgtMatcherProjectionRelation
			from: leadingGap
			to: selectedNode
			kind: #compaction).
	plan := CgtMatcherTransitionPolicy new
		structuralRefreshPlanFrom: oldProjection
		to: newProjection
		orientation: #vertical.
	self assert: plan isReveal.
	self assert: plan revealOffset equals: (0 @ -24)
]

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> test_structuralRefreshPlanUsesCollapseWhenLeadingCompactionDisappears [
	| oldProjection newProjection plan oldSelected newSelected leadingGap selectedNode |
	oldSelected := CgtThemeSelectorTestElement new className: 'Selected'; yourself.
	newSelected := CgtThemeSelectorTestElement new className: 'Selected'; yourself.
	oldProjection := CgtMatcherProjection new.
	leadingGap := (CgtMatcherProjectionNode kind: #compactedSection)
		representedElements: { CgtThemeSelectorTestElement new className: 'Hidden'; yourself };
		yourself.
	selectedNode := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: oldSelected;
		yourself.
	oldProjection
		selectedElement: oldSelected;
		addNode: leadingGap;
		addNode: selectedNode;
		addRelation: (CgtMatcherProjectionRelation
			from: leadingGap
			to: selectedNode
			kind: #compaction).
	newProjection := CgtMatcherProjection new.
	newProjection
		selectedElement: newSelected;
		addNode: ((CgtMatcherProjectionNode kind: #selectedElement)
			representedElement: newSelected;
			yourself).
	plan := CgtMatcherTransitionPolicy new
		structuralRefreshPlanFrom: oldProjection
		to: newProjection
		orientation: #vertical.
	self assert: plan isCollapse.
	self assert: plan revealOffset equals: (0 @ 24)
]
