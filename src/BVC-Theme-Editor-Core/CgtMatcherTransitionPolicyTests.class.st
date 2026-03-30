Class {
	#name : 'CgtMatcherTransitionPolicyTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testExpansionDirectionFollowsVerticalCorridorOrientation [
	self assert: CgtMatcherTransitionPolicy new expansionDirection equals: #up
]

{ #category : 'tests' }
CgtMatcherTransitionPolicyTests >> testLeadingMarginUsesTopInsetForVerticalCorridor [
	| margin |
	margin := CgtMatcherTransitionPolicy new leadingMarginForProgress: 0.0.
	self assert: margin top equals: -24.
	self assert: margin left equals: 0
]
