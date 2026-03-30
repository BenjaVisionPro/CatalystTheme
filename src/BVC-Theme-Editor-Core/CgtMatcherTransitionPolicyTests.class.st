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
CgtMatcherTransitionPolicyTests >> testDefaultExpansionDirectionIsLeft [
	self assert: CgtMatcherTransitionPolicy new expansionDirection equals: #left
]

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testDurationUsesRevealWhenExpandedGapCountIncreases [
	self assert: (CgtMatcherTransitionPolicy new durationFromExpandedGapCount: 0 to: 1) equals: CgtMatcherTransitionPolicy new revealDuration
]

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testDurationUsesCollapseWhenExpandedGapCountDecreases [
	self assert: (CgtMatcherTransitionPolicy new durationFromExpandedGapCount: 2 to: 1) equals: CgtMatcherTransitionPolicy new collapseDuration
]

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testLeadingMarginUsesLeftInsetForHorizontalCorridor [
	self assert: (CgtMatcherTransitionPolicy new leadingMarginForProgress: 0.0) left > 0
]

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testKeepsFollowingNodeFixed [
	self assert: CgtMatcherTransitionPolicy new keepsFollowingNodeFixed
]
