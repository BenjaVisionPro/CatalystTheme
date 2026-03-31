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
CgtMatcherLayoutPolicyTests >> testDefaultCorridorOrientationIsVertical [
	<gtExample>
	self assert: CgtMatcherLayoutPolicy new corridorOrientation equals: #vertical.
	^ CgtMatcherLayoutPolicy new

]

{ #category : 'tests' }
CgtMatcherLayoutPolicyTests >> testNodeWidthIsCompact [
	<gtExample>
	self assert: CgtMatcherLayoutPolicy new nodeWidth equals: 180.
	^ CgtMatcherLayoutPolicy new

]

{ #category : 'tests' }
CgtMatcherLayoutPolicyTests >> testPopoverMatcherHeightLeavesRoomForLabels [
	<gtExample>
	self assert: CgtMatcherLayoutPolicy new popoverMatcherHeight equals: 260.
	^ CgtMatcherLayoutPolicy new
]


{ #category : 'tests' }
CgtMatcherLayoutPolicyTests >> testSelectedNodeIsWiderThanContextNode [
	<gtExample>
	| policy |
	policy := CgtMatcherLayoutPolicy new.
	self assert: policy selectedNodeWidth > policy contextNodeWidth.
	self assert: policy scopeNodeWidth > policy compactedGapWidth.
	^ CgtMatcherLayoutPolicy new

]

{ #category : 'tests' }
CgtMatcherLayoutPolicyTests >> testVerticalEdgeConnectionsPointDownwardThroughCorridor [
	<gtExample>
	self
		assert: (CgtMatcherLayoutPolicy new edgeConnectionSelectorsForOrientation: #vertical)
		equals: #(fromCenterBottom toCenterTop).
	^ CgtMatcherLayoutPolicy new

]
