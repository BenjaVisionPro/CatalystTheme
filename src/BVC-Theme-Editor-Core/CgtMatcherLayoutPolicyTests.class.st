"
#Matcher Layout Policy Tests
I verify the explicit matcher layout constants. I am responsible for checking that the matcher visual foundation remains narrow, stable, and free from mystery numbers in the main widgets.
"
Class {
	#name : 'CgtMatcherLayoutPolicyTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtMatcherLayoutPolicyTests >> testNodeWidthIsCompact [
	self assert: CgtMatcherLayoutPolicy new nodeWidth equals: 180
]

{ #category : 'tests' }
CgtMatcherLayoutPolicyTests >> testPopoverMatcherHeightLeavesRoomForLabels [
	self assert: CgtMatcherLayoutPolicy new popoverMatcherHeight equals: 260
]
