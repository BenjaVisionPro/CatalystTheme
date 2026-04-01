"
#Element Path Tests
I verify the concrete path semantics used by the editor for upstream scopes and the optional selected child scope.
"
Class {
	#name : 'CgtElementPathTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtElementPathTests >> testSelectedChildScopeReplacementKeepsOnlyTheLatestChildScope [
	<gtExample>
	| anchor firstChild secondChild path |
	anchor := self newTestElementWithId: #'anchor'.
	firstChild := anchor addChild: (self newTestElementWithId: #'firstChild').
	secondChild := anchor addChild: (self newTestElementWithId: #'secondChild').
	path := CgtElementPath anchorElement: anchor.
	path selectedChildScopeElement: firstChild.
	self assert: path selectedChildScopeElement identicalTo: firstChild.
	path selectedChildScopeElement: secondChild.
	self assert: path selectedChildScopeElements asArray equals: { secondChild }.
	self assert: path selectedChildScopeElement identicalTo: secondChild.
	self assert: path nodes size equals: 2.
	^ path
]

{ #category : 'tests' }
CgtElementPathTests >> testClearingSelectedChildScopeRebuildsCorridorBackToAnchorOnly [
	<gtExample>
	| anchor child path |
	anchor := self newTestElementWithId: #'anchor'.
	child := anchor addChild: (self newTestElementWithId: #'child').
	path := CgtElementPath anchorElement: anchor.
	path selectedChildScopeElement: child.
	self assert: path selectedChildScopeElement identicalTo: child.
	path clearSelectedChildScope.
	self assert: path selectedChildScopeElement isNil.
	self assert: path nodes size equals: 1.
	self assert: path anchorElement identicalTo: anchor.
	^ path
]

{ #category : 'private' }
CgtElementPathTests >> newTestElementWithId: aSymbol [
	^ CgtThemeSelectorTestElement new
		id: (BlElementId named: aSymbol);
		yourself
]
