"
#Matcher Layout Policy Tests
I verify that matcher layout policy exposes the compact sizing constants used by the matcher visual composition.
"
Class {
	#name : 'CgtMatcherLayoutPolicyTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtMatcherLayoutPolicyTests >> testCompactNodeWidthIsPositive [
	self assert: CgtMatcherLayoutPolicy new nodeWidth > 0
]

{ #category : 'tests' }
CgtMatcherLayoutPolicyTests >> testPopoverMatcherHeightIsPositive [
	self assert: CgtMatcherLayoutPolicy new popoverMatcherHeight > 0
]

{ #category : 'tests' }
CgtMatcherLayoutPolicyTests >> testBadgePaddingExists [
	self assert: CgtMatcherLayoutPolicy new badgePadding notNil
]
