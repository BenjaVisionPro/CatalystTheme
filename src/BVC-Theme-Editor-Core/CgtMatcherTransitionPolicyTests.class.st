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
