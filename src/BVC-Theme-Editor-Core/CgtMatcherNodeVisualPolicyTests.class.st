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
	| node policy |
	policy := CgtMatcherNodeVisualPolicy new.
	node := CgtMatcherProjectionNode new
		kind: #selectedElement;
		yourself.
	self assert: (policy roleLabelForNode: node) equals: 'Selected element'
]

{ #category : 'tests' }
CgtMatcherNodeVisualPolicyTests >> testMatchSummaryForClassAndIdNode [
	| node policy |
	policy := CgtMatcherNodeVisualPolicy new.
	node := CgtMatcherProjectionNode new
		kind: #selectedElement;
		matchByClass: true;
		matchById: true;
		yourself.
	self assert: (policy matchSummaryForNode: node) equals: 'Matches by class + id'
]

{ #category : 'tests' }
CgtMatcherNodeVisualPolicyTests >> testCompactedNodeUsesContextOnlySummary [
	| node policy |
	policy := CgtMatcherNodeVisualPolicy new.
	node := CgtMatcherProjectionNode new
		kind: #compactedSection;
		hiddenNodeCount: 2;
		isEditable: false;
		yourself.
	self assert: (policy titleForNode: node) equals: '2 hidden nodes'.
	self assert: (policy matchSummaryForNode: node) equals: 'Context only'
]
