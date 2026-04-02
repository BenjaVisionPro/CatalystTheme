
"
#Matcher Relation Element Tests
I verify matcher-relation interaction behavior. I am responsible for checking that the relation element presents direct-child vs any-depth state and emits explicit combinator change events without owning selector semantics.
"
Class {
	#name : 'CgtMatcherRelationElementTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtMatcherRelationElementTests >> testDefaultLabelUsesDirectChildRelation [
	<gtExample>
	| element |
	element := CgtMatcherRelationElement new.
	self assert: element displayLabel equals: CgtMatcherRelationVisualPolicy new labelForDirectChild.
	^ element
]

{ #category : 'tests' }
CgtMatcherRelationElementTests >> testChooseAnyDepthPublishesCombinatorChangedEvent [
	<gtExample>
	| relation element event |
	relation := CgtMatcherProjectionRelation new
		kind: #matcher;
		combinator: #child;
		yourself.
	element := CgtMatcherRelationElement new
		projectionRelation: relation;
		yourself.
	element when: CgtMatcherCombinatorChangedEvent do: [ :anEvent | event := anEvent ].
	element chooseAnyDepth.
	self assert: event notNil.
	self assert: event relation identicalTo: relation.
	self assert: event combinator equals: #descendant.
	self assert: element isAnyDepth.
	^ element
]

{ #category : 'tests' }
CgtMatcherRelationElementTests >> testChooseDirectChildPublishesCombinatorChangedEvent [
	<gtExample>
	| relation element event |
	relation := CgtMatcherProjectionRelation new
		kind: #matcher;
		combinator: #descendant;
		yourself.
	element := CgtMatcherRelationElement new
		projectionRelation: relation;
		yourself.
	element when: CgtMatcherCombinatorChangedEvent do: [ :anEvent | event := anEvent ].
	element chooseDirectChild.
	self assert: event notNil.
	self assert: event relation identicalTo: relation.
	self assert: event combinator equals: #child.
	self assert: element isDirectChild.
	^ element
]


{ #category : 'tests' }
CgtMatcherRelationElementTests >> testCompactDisplayLabelUsesDotForChild [
	| element |
	element := CgtMatcherRelationElement new.
	self assert: element compactDisplayLabel equals: '•'.
	^ element
]

{ #category : 'tests' }
CgtMatcherRelationElementTests >> testCompactDisplayLabelUsesOpenDotForDescendant [
	| relation element |
	relation := (CgtMatcherProjectionRelation from: CgtMatcherProjectionNode new to: CgtMatcherProjectionNode new)
		kind: #matcher;
		combinator: #descendant;
		yourself.
	element := CgtMatcherRelationElement new
		projectionRelation: relation;
		yourself.
	self assert: element compactDisplayLabel equals: '◌'.
	^ element
]
