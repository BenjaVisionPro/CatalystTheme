"
#Matcher Projection Tests
I verify the passive matcher projection model. I am responsible for checking explicit node kinds, relation capture, and rule-membership partitioning before any builder or widget logic is added.
"
Class {
	#name : 'CgtMatcherProjectionTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtMatcherProjectionTests >> testProjectionKeepsRelationsExplicit [
	| parentNode childNode relation projection |
	projection := CgtMatcherProjection new.
	parentNode := CgtMatcherProjectionNode kind: #upstreamScope.
	childNode := CgtMatcherProjectionNode kind: #selectedElement.
	relation := CgtMatcherProjectionRelation from: parentNode to: childNode kind: #matcher.
	relation combinator: #child.
	
	projection addNode: parentNode.
	projection addNode: childNode.
	projection addRelation: relation.
	
	self assert: projection relations size equals: 1.
	self assert: projection relations first fromNode identicalTo: parentNode.
	self assert: projection relations first toNode identicalTo: childNode.
	self assert: projection relations first kind equals: #matcher.
	self assert: projection relations first combinator equals: #child
]

{ #category : 'tests' }
CgtMatcherProjectionTests >> testProjectionNodeCarriesRuleMembershipAndMatchState [
	| element node |
	element := self newTestElementWithId: #'selected-node'.
	node := CgtMatcherProjectionNode kind: #selectedElement.
	node representedElement: element.
	node isInCurrentRule: true.
	node isInOtherRule: false.
	node matchByClass: true.
	node matchById: true.
	
	self assert: node kind equals: #selectedElement.
	self assert: node representedElement identicalTo: element.
	self assert: node className equals: CgtThemeSelectorTestElement name.
	self assert: node elementId equals: (BlElementId named: #'selected-node').
	self assert: node isInCurrentRule.
	self deny: node isInOtherRule.
	self assert: node matchByClass.
	self assert: node matchById
]

{ #category : 'tests' }
CgtMatcherProjectionTests >> testProjectionSeparatesCurrentRuleNodesFromOtherRuleNodes [
	| projection selectedNode otherRuleNode compactedNode |
	projection := CgtMatcherProjection new.
	selectedNode := CgtMatcherProjectionNode kind: #selectedElement.
	selectedNode isInCurrentRule: true.
	otherRuleNode := CgtMatcherProjectionNode kind: #otherRuleRelated.
	otherRuleNode isInOtherRule: true.
	compactedNode := CgtMatcherProjectionNode kind: #compactedSection.
	compactedNode hiddenNodeCount: 3.
	compactedNode isEditable: false.
	
	projection addNode: selectedNode.
	projection addNode: otherRuleNode.
	projection addNode: compactedNode.
	
	self assert: projection currentRuleNodes asArray equals: { selectedNode }.
	self assert: projection otherRuleNodes asArray equals: { otherRuleNode }.
	self assert: (projection nodesOfKind: #compactedSection) asArray equals: { compactedNode }.
	self assert: compactedNode hiddenNodeCount equals: 3.
	self deny: compactedNode isEditable
]

{ #category : 'private' }
CgtMatcherProjectionTests >> newTestElementWithId: aSymbol [
	^ CgtThemeSelectorTestElement new
		id: (BlElementId named: aSymbol);
		yourself
]
