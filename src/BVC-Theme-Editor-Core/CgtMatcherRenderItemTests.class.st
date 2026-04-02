"
#Matcher Render Item Tests
I verify the linear render-item vocabulary for the upcoming custom selector widget. I am responsible for checking that row, gap, and other-rule indicator items carry explicit rendering facts without pretending to be the selector model.
"
Class {
	#name : 'CgtMatcherRenderItemTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtMatcherRenderItemTests >> testRowRenderItemCarriesProjectionNodeAndState [
	<gtExample>
	| node relation item |
	node := (CgtMatcherProjectionNode kind: #selectedElement)
		className: 'SelectedElement';
		elementId: (BlElementId named: #'selected-node');
		yourself.
	relation := (CgtMatcherProjectionRelation from: node to: node kind: #matcher)
		combinator: #child;
		yourself.
	item := CgtMatcherRowRenderItem new
		projectionNode: node;
		incomingRelation: relation;
		isSelected: true;
		isCurrentRule: true;
		isOtherRule: false;
		yourself.
	self assert: item isRowItem.
	self deny: item isGapItem.
	self assert: item projectionNode identicalTo: node.
	self assert: item incomingRelation identicalTo: relation.
	self assert: item isSelected.
	self assert: item isCurrentRule.
	self deny: item isOtherRule.
	self assert: item renderKey first equals: #row.
	^ item
]

{ #category : 'tests' }
CgtMatcherRenderItemTests >> testGapRenderItemCarriesSingleGapIdentityAndDirection [
	<gtExample>
	| item |
	item := CgtMatcherGapRenderItem new
		gapIdentity: #leadingGap;
		hiddenCount: 3;
		direction: #upstream;
		yourself.
	self assert: item isGapItem.
	self deny: item isRowItem.
	self assert: item gapIdentity equals: #leadingGap.
	self assert: item hiddenCount equals: 3.
	self assert: item direction equals: #upstream.
	self assert: item renderKey equals: #(gap leadingGap upstream).
	^ item
]

{ #category : 'tests' }
CgtMatcherRenderItemTests >> testOtherRuleIndicatorRenderItemCarriesHiddenCount [
	<gtExample>
	| item |
	item := CgtMatcherOtherRuleIndicatorRenderItem new
		hiddenCount: 2;
		yourself.
	self assert: item isOtherRuleIndicatorItem.
	self deny: item isRowItem.
	self deny: item isGapItem.
	self assert: item hiddenCount equals: 2.
	self assert: item renderKey equals: #(otherRuleIndicator 2).
	^ item
]
