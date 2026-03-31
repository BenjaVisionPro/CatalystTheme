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
	<gtExample>
	self
		assert: (CgtMatcherTransitionPolicy new leadingExpansionSideForOrientation: #horizontal)
		equals: #left
	^ CgtMatcherTransitionPolicy new

]

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testKeepsFollowingNodeFixed [
	<gtExample>
	self assert: CgtMatcherTransitionPolicy new keepsFollowingNodeFixed.
	^ CgtMatcherTransitionPolicy new

]

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testVerticalCorridorExpandsTowardUp [
	<gtExample>
	self
		assert: (CgtMatcherTransitionPolicy new leadingExpansionSideForOrientation: #vertical)
		equals: #up
	^ CgtMatcherTransitionPolicy new

]

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testVerticalRevealOffsetMovesUpward [
	<gtExample>
	self
		assert: (CgtMatcherTransitionPolicy new graphRevealOffsetForOrientation: #vertical)
		equals: (0 @ -24)
	^ CgtMatcherTransitionPolicy new
]


{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testStructuralRefreshAnchorUsesFollowingVisibleNodeAfterLeadingCompaction [
	<gtExample>
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
	self assert: (policy structuralRefreshAnchorProjectionNodeFor: projection) identicalTo: selected.
	^ CgtMatcherTransitionPolicy new

]

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testStructuralRefreshRevealOffsetUsesLeadingCompactedGapOnly [
	<gtExample>
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
	self assert: (policy structuralRefreshRevealOffsetForProjection: trailingProjection orientation: #vertical) equals: (0 @ 0).
	^ CgtMatcherTransitionPolicy new
]


{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> test_structuralRefreshPlanUsesRevealWhenLeadingCompactionAppears [
	<gtExample>
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
		gapIdentity: #(hiddenGap);
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
	self assert: plan revealOffset equals: (0 @ -24).
	^ policy

]

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> test_structuralRefreshPlanUsesCollapseWhenLeadingCompactionDisappears [
	<gtExample>
	| oldProjection newProjection plan oldSelected newSelected leadingGap selectedNode |
	oldSelected := CgtThemeSelectorTestElement new className: 'Selected'; yourself.
	newSelected := CgtThemeSelectorTestElement new className: 'Selected'; yourself.
	oldProjection := CgtMatcherProjection new.
	leadingGap := (CgtMatcherProjectionNode kind: #compactedSection)
		representedElements: { CgtThemeSelectorTestElement new className: 'Hidden'; yourself };
		gapIdentity: #(hiddenGap);
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
	self assert: plan revealOffset equals: (0 @ 24).
	^ CgtMatcherTransitionPolicy new
]


{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testStructuralRefreshDurationUsesRevealAndCollapseSpecificDurations [
	<gtExample>
	| policy revealPlan collapsePlan stablePlan |
	policy := CgtMatcherTransitionPolicy new.
	revealPlan := CgtMatcherStructuralRefreshPlan new transitionKind: #reveal; yourself.
	collapsePlan := CgtMatcherStructuralRefreshPlan new transitionKind: #collapse; yourself.
	stablePlan := CgtMatcherStructuralRefreshPlan new transitionKind: #stable; yourself.
	self assert: (policy structuralRefreshDurationForPlan: revealPlan) equals: policy revealDuration.
	self assert: (policy structuralRefreshDurationForPlan: collapsePlan) equals: policy collapseDuration.
	self assert: (policy structuralRefreshDurationForPlan: stablePlan) equals: policy structuralRefreshDuration.
	^ selectedNode

]

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testStructuralRefreshOpacityUsesStableNoFadeAndRevealFadeIn [
	<gtExample>
	| policy revealPlan stablePlan |
	policy := CgtMatcherTransitionPolicy new.
	revealPlan := CgtMatcherStructuralRefreshPlan new transitionKind: #reveal; yourself.
	stablePlan := CgtMatcherStructuralRefreshPlan new transitionKind: #stable; yourself.
	self assert: (policy structuralRefreshStartOpacityForPlan: revealPlan) equals: policy graphRevealStartOpacity.
	self assert: (policy structuralRefreshStartOpacityForPlan: stablePlan) equals: policy graphRevealEndOpacity.
	self assert: (policy structuralRefreshEndOpacityForPlan: stablePlan) equals: policy graphRevealEndOpacity.
	^ policy

]

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testStructuralRefreshPlanIsStableWhenLeadingCompactionGapIdentityIsUnchanged [
	<gtExample>
	| oldProjection newProjection plan oldGap newGap oldSelected newSelected |
	oldSelected := CgtThemeSelectorTestElement named: #selected id: #selected.
	newSelected := CgtThemeSelectorTestElement named: #selected id: #selected.
	oldGap := (CgtMatcherProjectionNode kind: #compactedSection)
		gapIdentity: #(leading same);
		hiddenNodeCount: 2;
		yourself.
	newGap := (CgtMatcherProjectionNode kind: #compactedSection)
		gapIdentity: #(leading same);
		hiddenNodeCount: 3;
		yourself.
	oldProjection := CgtMatcherProjection new.
	oldProjection
		selectedElement: oldSelected;
		addNode: oldGap;
		addNode: ((CgtMatcherProjectionNode kind: #selectedElement)
			representedElement: oldSelected;
			yourself);
		addRelation: (CgtMatcherProjectionRelation from: oldGap to: oldProjection selectedProjectionNode kind: #compaction).
	newProjection := CgtMatcherProjection new.
	newProjection
		selectedElement: newSelected;
		addNode: newGap;
		addNode: ((CgtMatcherProjectionNode kind: #selectedElement)
			representedElement: newSelected;
			yourself);
		addRelation: (CgtMatcherProjectionRelation from: newGap to: newProjection selectedProjectionNode kind: #compaction).
	plan := CgtMatcherTransitionPolicy new
		structuralRefreshPlanFrom: oldProjection
		to: newProjection
		orientation: #vertical.
	self assert: plan isStable.
	self assert: plan revealOffset equals: (0 @ 0).
	^ newSelected

]

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testStructuralRefreshPlanUsesReplaceWhenLeadingCompactionGapIdentityChanges [
	<gtExample>
	| oldProjection newProjection plan oldGap newGap oldSelected newSelected |
	oldSelected := CgtThemeSelectorTestElement named: #selected id: #selected.
	newSelected := CgtThemeSelectorTestElement named: #selected id: #selected.
	oldGap := (CgtMatcherProjectionNode kind: #compactedSection)
		gapIdentity: #(leading old);
		hiddenNodeCount: 2;
		yourself.
	newGap := (CgtMatcherProjectionNode kind: #compactedSection)
		gapIdentity: #(leading new);
		hiddenNodeCount: 2;
		yourself.
	oldProjection := CgtMatcherProjection new.
	oldProjection
		selectedElement: oldSelected;
		addNode: oldGap;
		addNode: ((CgtMatcherProjectionNode kind: #selectedElement)
			representedElement: oldSelected;
			yourself);
		addRelation: (CgtMatcherProjectionRelation from: oldGap to: oldProjection selectedProjectionNode kind: #compaction).
	newProjection := CgtMatcherProjection new.
	newProjection
		selectedElement: newSelected;
		addNode: newGap;
		addNode: ((CgtMatcherProjectionNode kind: #selectedElement)
			representedElement: newSelected;
			yourself);
		addRelation: (CgtMatcherProjectionRelation from: newGap to: newProjection selectedProjectionNode kind: #compaction).
	plan := CgtMatcherTransitionPolicy new
		structuralRefreshPlanFrom: oldProjection
		to: newProjection
		orientation: #vertical.
	self assert: plan isReplace.
	self assert: plan revealOffset equals: (0 @ -24).
	^ CgtMatcherTransitionPolicy new
]



{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testShouldAnimateStructuralRefreshPlanOnlyForRevealAndCollapse [
	<gtExample>
	| policy revealPlan collapsePlan stablePlan |
	policy := CgtMatcherTransitionPolicy new.
	revealPlan := CgtMatcherStructuralRefreshPlan new transitionKind: #reveal; yourself.
	collapsePlan := CgtMatcherStructuralRefreshPlan new transitionKind: #collapse; yourself.
	stablePlan := CgtMatcherStructuralRefreshPlan new transitionKind: #stable; yourself.
	self assert: (policy shouldAnimateStructuralRefreshPlan: revealPlan).
	self assert: (policy shouldAnimateStructuralRefreshPlan: collapsePlan).
	self deny: (policy shouldAnimateStructuralRefreshPlan: stablePlan)
	^ CgtMatcherTransitionPolicy new
]


{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testStructuralRefreshDurationUsesReplaceDuration [
	<gtExample>
	| policy replacePlan |
	policy := CgtMatcherTransitionPolicy new.
	replacePlan := CgtMatcherStructuralRefreshPlan new transitionKind: #replace; yourself.
	self assert: (policy structuralRefreshDurationForPlan: replacePlan) equals: policy replaceDuration.
	^ newSelected

]

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testStructuralRefreshOpacityUsesReplaceNoFade [
	<gtExample>
	| policy replacePlan |
	policy := CgtMatcherTransitionPolicy new.
	replacePlan := CgtMatcherStructuralRefreshPlan new transitionKind: #replace; yourself.
	self assert: (policy structuralRefreshStartOpacityForPlan: replacePlan) equals: policy graphRevealEndOpacity.
	self assert: (policy structuralRefreshEndOpacityForPlan: replacePlan) equals: policy graphRevealEndOpacity.
	^ policy

]
