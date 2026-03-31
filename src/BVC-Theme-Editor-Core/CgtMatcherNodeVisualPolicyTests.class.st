"
#Matcher Node Visual Policy Tests
I verify the explicit visual semantics for matcher projection nodes. I am responsible for checking that node kinds and matcher flags map to stable user-facing labels, summaries, and render priorities.
"
Class {
	#name : 'CgtMatcherNodeVisualPolicyTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtMatcherNodeVisualPolicyTests >> testRoleLabelForSelectedElementNode [
	<gtExample>
	| node policy |
	policy := CgtMatcherNodeVisualPolicy new.
	node := CgtMatcherProjectionNode new
		kind: #selectedElement;
		yourself.
	self assert: (policy roleLabelForNode: node) equals: 'Selected'.
	^ policy

]

{ #category : 'tests' }
CgtMatcherNodeVisualPolicyTests >> testMatchSummaryForClassAndIdNode [
	<gtExample>
	| node policy |
	policy := CgtMatcherNodeVisualPolicy new.
	node := CgtMatcherProjectionNode new
		kind: #selectedElement;
		matchByClass: true;
		matchById: true;
		yourself.
	self assert: (policy matchSummaryForNode: node) equals: 'Class + id'.
	^ policy

]

{ #category : 'tests' }
CgtMatcherNodeVisualPolicyTests >> testCompactedNodeUsesContextOnlySummary [
	<gtExample>
	| node policy |
	policy := CgtMatcherNodeVisualPolicy new.
	node := CgtMatcherProjectionNode new
		kind: #compactedSection;
		hiddenNodeCount: 2;
		isEditable: false;
		yourself.
	self assert: (policy titleForNode: node) equals: '2 hidden nodes'.
	self assert: (policy matchSummaryForNode: node) equals: 'Context only'.
	^ CgtMatcherNodeVisualPolicy
]


{ #category : 'tests' }
CgtMatcherNodeVisualPolicyTests >> testSelectedRoleLabelIsShort [
	<gtExample>
	| policy node |
	policy := CgtMatcherNodeVisualPolicy new.
	node := CgtMatcherProjectionNode kind: #selectedElement.
	self assert: (policy roleLabelForNode: node) equals: 'Selected'.
	^ policy

]
