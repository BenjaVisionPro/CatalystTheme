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
	<gtExample>
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
	self assert: projection relations first combinator equals: #child.
	^ projection

]

{ #category : 'tests' }
CgtMatcherProjectionTests >> testProjectionNodeCarriesRuleMembershipAndMatchState [
	<gtExample>
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
	self assert: node matchById.
	^ node
]



{ #category : 'tests' }
CgtMatcherProjectionTests >> testProjectionNodeAllowsGenericRepresentedElementWithoutId [
	<gtExample>
	| element node |
	element := Object new.
	node := CgtMatcherProjectionNode kind: #selectedElement.
	node representedElement: element.
	self assert: node representedElement identicalTo: element.
	self assert: node className equals: Object name.
	self assert: node elementId isNil.
	^ node
]
{ #category : 'tests' }
CgtMatcherProjectionTests >> testProjectionSeparatesCurrentRuleNodesFromOtherRuleNodes [
	<gtExample>
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
	self deny: compactedNode isEditable.
	^ projection

]



{ #category : 'tests' }
CgtMatcherProjectionTests >> testProjectionProvidesExplicitCorridorAndIndicatorQueries [
	<gtExample>
	| projection upstream selected child compacted indicator |
	projection := CgtMatcherProjection new.
	upstream := CgtMatcherProjectionNode kind: #upstreamScope.
	selected := CgtMatcherProjectionNode kind: #selectedElement.
	child := CgtMatcherProjectionNode kind: #selectedChildScope.
	compacted := CgtMatcherProjectionNode kind: #compactedSection.
	indicator := CgtMatcherProjectionNode kind: #otherRuleIndicator.
	projection
		addNode: upstream;
		addNode: selected;
		addNode: child;
		addNode: compacted;
		addNode: indicator.
	self assert: projection upstreamScopeNodes asArray equals: { upstream }.
	self assert: projection selectedProjectionNode identicalTo: selected.
	self assert: projection selectedChildScopeNode identicalTo: child.
	self assert: projection selectedChildScopeNodes asArray equals: { child }.
	self assert: projection compactedSectionNodes asArray equals: { compacted }.
	self assert: projection otherRuleIndicatorNode identicalTo: indicator.
	self assert: projection otherRuleIndicatorNodes asArray equals: { indicator }.
	self assert: projection visibleCorridorNodes asArray equals: { upstream. selected. child. compacted }.
	^ projection
]

{ #category : 'tests' }
CgtMatcherProjectionTests >> testProjectionProvidesExplicitRelationQueries [
	<gtExample>
	| projection upstream selected child indicator matcherRelation compactionRelation otherRuleRelation |
	projection := CgtMatcherProjection new.
	upstream := CgtMatcherProjectionNode kind: #upstreamScope.
	selected := CgtMatcherProjectionNode kind: #selectedElement.
	child := CgtMatcherProjectionNode kind: #selectedChildScope.
	indicator := CgtMatcherProjectionNode kind: #otherRuleIndicator.
	matcherRelation := (CgtMatcherProjectionRelation from: upstream to: selected kind: #matcher)
		combinator: #child;
		yourself.
	compactionRelation := CgtMatcherProjectionRelation from: selected to: child kind: #compaction.
	otherRuleRelation := CgtMatcherProjectionRelation from: selected to: indicator kind: #otherRule.
	projection
		addNode: upstream;
		addNode: selected;
		addNode: child;
		addNode: indicator;
		addRelation: matcherRelation;
		addRelation: compactionRelation;
		addRelation: otherRuleRelation.
	self assert: projection matcherRelations asArray equals: { matcherRelation }.
	self assert: projection compactionRelations asArray equals: { compactionRelation }.
	self assert: projection otherRuleRelations asArray equals: { otherRuleRelation }.
	self assert: projection visibleCorridorRelations asArray equals: { matcherRelation. compactionRelation }.
	self assert: (projection relationFromNode: upstream toNode: selected) identicalTo: matcherRelation.
	self assert: (projection relationFromNode: selected toNode: child) identicalTo: compactionRelation.
	self assert: (projection relationFromNode: selected toNode: indicator) identicalTo: otherRuleRelation.
	^ projection
]

{ #category : 'private' }
CgtMatcherProjectionTests >> newTestElementWithId: aSymbol [.
	^ CgtThemeSelectorTestElement new
		id: (BlElementId named: aSymbol);
		yourself
]


{ #category : 'tests' }
CgtMatcherProjectionTests >> testLeadingAndTrailingCompactedProjectionQueries [
	<gtExample>
	| projection leadingGap selected trailingGap leadingRelation trailingRelation |
	leadingGap := CgtMatcherProjectionNode kind: #compactedSection.
	selected := (CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: CgtThemeSelectorTestElement new;
		yourself.
	trailingGap := CgtMatcherProjectionNode kind: #compactedSection.
	leadingRelation := CgtMatcherProjectionRelation from: leadingGap to: selected kind: #compaction.
	trailingRelation := CgtMatcherProjectionRelation from: selected to: trailingGap kind: #compaction.
	projection := CgtMatcherProjection new.
	projection
		selectedElement: selected representedElement;
		addNode: leadingGap;
		addNode: selected;
		addNode: trailingGap;
		addRelation: leadingRelation;
		addRelation: trailingRelation.
	self assert: projection hasLeadingCompactedProjectionNode.
	self assert: projection leadingCompactedProjectionNode identicalTo: leadingGap.
	self assert: projection trailingCompactedProjectionNode identicalTo: trailingGap.
	self assert: projection followingProjectionNodeAfterLeadingCompaction identicalTo: selected.
	^ projection

]
