Class {
	#name : 'CgtMatcherTransitionPolicyTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testExpansionDirectionFollowsHorizontalCorridorOrientation [
	self assert: CgtMatcherTransitionPolicy new expansionDirection equals: #left
]

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testLeadingMarginUsesLeftInsetForHorizontalCorridor [
	| margin |
	margin := CgtMatcherTransitionPolicy new leadingMarginForProgress: 0.0.
	self assert: margin left equals: -24.
	self assert: margin top equals: 0
]

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testCanStillSwitchToVerticalCorridor [
	| policy |
	policy := CgtMatcherTransitionPolicy new.
	policy corridorOrientation: #vertical.
	self assert: policy expansionDirection equals: #up
]
