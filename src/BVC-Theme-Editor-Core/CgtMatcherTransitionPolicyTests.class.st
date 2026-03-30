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
CgtMatcherTransitionPolicyTests >> testDefaultExpansionDirectionIsLeftForHorizontalCorridor [
	self assert: CgtMatcherTransitionPolicy new expansionDirection equals: #left
]

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testKeepsFollowingNodeFixed [
	self assert: CgtMatcherTransitionPolicy new keepsFollowingNodeFixed
]

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testUsesRevealDurationWhenExpandedGapCountIncreases [
	self
		assert: (CgtMatcherTransitionPolicy new durationFromExpandedGapCount: 0 to: 1)
		equals: CgtMatcherTransitionPolicy new revealDuration
]

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testUsesCollapseDurationWhenExpandedGapCountDecreases [
	self
		assert: (CgtMatcherTransitionPolicy new durationFromExpandedGapCount: 2 to: 1)
		equals: CgtMatcherTransitionPolicy new collapseDuration
]

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testUsesStructuralRefreshDurationWhenExpandedGapCountIsStable [
	self
		assert: (CgtMatcherTransitionPolicy new durationFromExpandedGapCount: 1 to: 1)
		equals: CgtMatcherTransitionPolicy new structuralRefreshDuration
]

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testVerticalCorridorExpandsUp [
	| policy |
	policy := CgtMatcherTransitionPolicy new
		corridorOrientation: #vertical;
		yourself.
	self assert: policy expansionDirection equals: #up
]

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testHorizontalLeadingMarginUsesLeftInset [
	| margin |
	margin := CgtMatcherTransitionPolicy new leadingMarginForProgress: 1.0.
	self assert: margin left > 0.
	self assert: margin top equals: 0
]

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testVerticalLeadingMarginUsesTopInset [
	| policy margin |
	policy := CgtMatcherTransitionPolicy new
		corridorOrientation: #vertical;
		yourself.
	margin := policy leadingMarginForProgress: 1.0.
	self assert: margin top > 0.
	self assert: margin left equals: 0
]
