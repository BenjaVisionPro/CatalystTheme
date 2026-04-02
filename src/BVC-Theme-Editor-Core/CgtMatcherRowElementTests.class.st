"
#Matcher Row Element Tests
I verify the composed matcher-row behavior for the upcoming custom style-rule selector widget. I am responsible for checking that relation and chip elements are composed correctly and that row-level hover, selection, and child edit events stay explicit.
"
Class {
	#name : 'CgtMatcherRowElementTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtMatcherRowElementTests >> testBuildsClassAndIdChipsFromProjectionNode [
	<gtExample>
	| node row |
	node := (CgtMatcherProjectionNode kind: #selectedElement)
		className: 'SelectedElement';
		elementId: (BlElementId named: #'selected-node');
		matchByClass: true;
		matchById: false;
		yourself.
	row := CgtMatcherRowElement new
		projectionNode: node;
		yourself.
	self assert: row hasClassMatcher.
	self assert: row hasIdMatcher.
	self assert: row classChipElement matcherLabel equals: 'SelectedElement'.
	self assert: row idChipElement matcherLabel equals: 'selected-node'.
	^ row
]

{ #category : 'tests' }
CgtMatcherRowElementTests >> testDoesNotBuildIdChipForSemanticNilElementId [
	<gtExample>
	| node row |
	node := (CgtMatcherProjectionNode kind: #selectedElement)
		className: 'SelectedElement';
		elementId: 'nil';
		yourself.
	row := CgtMatcherRowElement new
		projectionNode: node;
		yourself.
	self deny: row hasIdMatcher.
	^ row
]

{ #category : 'tests' }
CgtMatcherRowElementTests >> testFirstVisibleRowHasNoRelationElement [
	<gtExample>
	| node row |
	node := (CgtMatcherProjectionNode kind: #selectedElement)
		className: 'SelectedElement';
		yourself.
	row := CgtMatcherRowElement new
		projectionNode: node;
		yourself.
	self deny: row hasRelationElement.
	^ row
]

{ #category : 'tests' }
CgtMatcherRowElementTests >> testNonRootRowBuildsRelationElement [
	<gtExample>
	| parent child relation row |
	parent := (CgtMatcherProjectionNode kind: #upstreamScope)
		className: 'ParentElement';
		yourself.
	child := (CgtMatcherProjectionNode kind: #selectedElement)
		className: 'ChildElement';
		yourself.
	relation := (CgtMatcherProjectionRelation from: parent to: child kind: #matcher)
		combinator: #child;
		yourself.
	row := CgtMatcherRowElement new
		projectionNode: child;
		incomingRelation: relation;
		yourself.
	self assert: row hasRelationElement.
	self assert: row relationElement projectionRelation identicalTo: relation.
	^ row
]

{ #category : 'tests' }
CgtMatcherRowElementTests >> testClassChipToggleIsForwardedByRow [
	<gtExample>
	| node row event |
	node := (CgtMatcherProjectionNode kind: #selectedElement)
		className: 'SelectedElement';
		matchByClass: false;
		yourself.
	row := CgtMatcherRowElement new
		projectionNode: node;
		yourself.
	row when: CgtMatcherClassMatchToggledEvent do: [ :anEvent | event := anEvent ].
	row classChipElement toggleEnabled.
	self assert: event notNil.
	self assert: event projectionNode identicalTo: node.
	self assert: event shouldMatch.
	^ row
]

{ #category : 'tests' }
CgtMatcherRowElementTests >> testRelationChangeIsForwardedByRow [
	<gtExample>
	| parent child relation row event |
	parent := (CgtMatcherProjectionNode kind: #upstreamScope)
		className: 'ParentElement';
		yourself.
	child := (CgtMatcherProjectionNode kind: #selectedElement)
		className: 'ChildElement';
		yourself.
	relation := (CgtMatcherProjectionRelation from: parent to: child kind: #matcher)
		combinator: #child;
		yourself.
	row := CgtMatcherRowElement new
		projectionNode: child;
		incomingRelation: relation;
		yourself.
	row when: CgtMatcherCombinatorChangedEvent do: [ :anEvent | event := anEvent ].
	row relationElement chooseAnyDepth.
	self assert: event notNil.
	self assert: event relation identicalTo: relation.
	self assert: event combinator equals: #descendant.
	^ row
]

{ #category : 'tests' }
CgtMatcherRowElementTests >> testRowPublishesSelectionEvent [
	<gtExample>
	| node row event |
	node := (CgtMatcherProjectionNode kind: #selectedElement)
		className: 'SelectedElement';
		yourself.
	row := CgtMatcherRowElement new
		projectionNode: node;
		yourself.
	row when: CgtMatcherNodeSelectedEvent do: [ :anEvent | event := anEvent ].
	row onMouseSelect: nil.
	self assert: event notNil.
	self assert: event projectionNode identicalTo: node.
	^ row
]

{ #category : 'tests' }
CgtMatcherRowElementTests >> testRowPublishesHoverAndUnhoverEvents [
	<gtExample>
	| node row hovered unhovered |
	node := (CgtMatcherProjectionNode kind: #selectedElement)
		className: 'SelectedElement';
		yourself.
	row := CgtMatcherRowElement new
		projectionNode: node;
		yourself.
	row when: CgtMatcherNodeHoveredEvent do: [ :anEvent | hovered := anEvent ].
	row when: CgtMatcherNodeUnhoveredEvent do: [ :anEvent | unhovered := anEvent ].
	row onMouseEnter: nil.
	row onMouseLeave: nil.
	self assert: hovered notNil.
	self assert: unhovered notNil.
	self assert: hovered projectionNode identicalTo: node.
	self assert: unhovered projectionNode identicalTo: node.
	^ row
]


{ #category : 'tests' }
CgtMatcherRowElementTests >> testRowAllowsRevealedContextStateToBeApplied [
	<gtExample>
	| node row |
	node := (CgtMatcherProjectionNode kind: #upstreamScope)
		className: 'ContextElement';
		yourself.
	row := CgtMatcherRowElement new
		projectionNode: node;
		revealedContext: true;
		yourself.
	self assert: row isRevealedContext.
	self deny: row isInScope.
	^ row
]
