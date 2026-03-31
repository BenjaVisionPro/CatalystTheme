"
#Matcher Relation Visual Policy Tests
I verify the explicit visual semantics for matcher relations. I am responsible for checking that relation kinds map to stable user-facing labels and styling choices.
"
Class {
	#name : 'CgtMatcherRelationVisualPolicyTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtMatcherRelationVisualPolicyTests >> testOtherRuleRelationUsesOtherRuleLabel [
	<gtExample>
	| policy relation |
	policy := CgtMatcherRelationVisualPolicy new.
	relation := CgtMatcherProjectionRelation from: CgtMatcherProjectionNode new to: CgtMatcherProjectionNode new kind: #otherRule.
	self assert: (policy labelForRelation: relation) equals: 'Other rule'.
	self assert: (policy widthForRelation: relation) equals: 3.
	^ policy

]

{ #category : 'tests' }
CgtMatcherRelationVisualPolicyTests >> testDescendantMatcherRelationUsesDescendantLabel [
	<gtExample>
	| policy relation |
	policy := CgtMatcherRelationVisualPolicy new.
	relation := (CgtMatcherProjectionRelation from: CgtMatcherProjectionNode new to: CgtMatcherProjectionNode new kind: #matcher)
		combinator: #descendant;
		yourself.
	self assert: (policy labelForRelation: relation) equals: 'Descendant relation'.
	^ policy

]
