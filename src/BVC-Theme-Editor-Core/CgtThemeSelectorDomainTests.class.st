"
#Theme Selector Domain Tests
I verify the pure selector domain model. I am responsible for round-trip tests and matching tests for selector predicates and combinators.
"
Class {
	#name : 'CgtThemeSelectorDomainTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtThemeSelectorDomainTests >> testClassAndIdSimpleSelectorRoundTripsThroughSteps [
	<gtExample>
	| selector rebuiltSelector element sameClassWrongId wrongClass |
	selector := CgtThemeSimpleSelector new.
	selector addPredicate: (CgtThemeClassPredicate elementClass: CgtThemeSelectorTestElement).
	selector addPredicate: (CgtThemeIdPredicate elementId: (BlElementId named: #'selected-node')).
	
	rebuiltSelector := CgtThemeSelectorComposer selectorFromSteps: (CgtThemeSelectorDecomposer stepsForSelector: selector).
	
	self assert: rebuiltSelector displayString equals: selector displayString.
	
	element := self newTestElementWithId: #'selected-node'.
	sameClassWrongId := self newTestElementWithId: #'other-node'.
	wrongClass := Object new.
	
	self assert: (rebuiltSelector matchesElement: element).
	self deny: (rebuiltSelector matchesElement: sameClassWrongId).
	self deny: (rebuiltSelector matchesElement: wrongClass)
	^ selector

]

{ #category : 'tests' }
CgtThemeSelectorDomainTests >> testChildCombinatorRoundTripsThroughSteps [
	<gtExample>
	| parent child grandChild selector rebuiltSelector |
	parent := self newTestElementWithId: #'parent'.
	child := parent addChild: (self newTestElementWithId: #'child').
	grandChild := child addChild: (self newTestElementWithId: #'grandChild').
	
	selector := CgtThemeCombinatorSelector
		left: (self selectorForId: #'parent')
		combinator: #child
		right: (self selectorForId: #'child').
	
	rebuiltSelector := CgtThemeSelectorComposer selectorFromSteps: (CgtThemeSelectorDecomposer stepsForSelector: selector).
	
	self assert: rebuiltSelector displayString equals: selector displayString.
	self assert: (rebuiltSelector matchesElement: child).
	self deny: (rebuiltSelector matchesElement: grandChild)
	^ selector

]

{ #category : 'tests' }
CgtThemeSelectorDomainTests >> testDescendantCombinatorRoundTripsThroughSteps [
	<gtExample>
	| root middle leaf selector rebuiltSelector |
	root := self newTestElementWithId: #'root'.
	middle := root addChild: (self newTestElementWithId: #'middle').
	leaf := middle addChild: (self newTestElementWithId: #'leaf').
	
	selector := CgtThemeCombinatorSelector
		left: (self selectorForId: #'root')
		combinator: #descendant
		right: (self selectorForId: #'leaf').
	
	rebuiltSelector := CgtThemeSelectorComposer selectorFromSteps: (CgtThemeSelectorDecomposer stepsForSelector: selector).
	
	self assert: rebuiltSelector displayString equals: selector displayString.
	self assert: (rebuiltSelector matchesElement: leaf).
	self deny: (rebuiltSelector matchesElement: middle)
	^ selector

]

{ #category : 'private' }
CgtThemeSelectorDomainTests >> newTestElementWithId: aSymbol [
	^ CgtThemeSelectorTestElement new
		id: (BlElementId named: aSymbol);
		yourself
]

{ #category : 'private' }
CgtThemeSelectorDomainTests >> selectorForId: aSymbol [
	^ CgtThemeSimpleSelector new
		addPredicate: (CgtThemeIdPredicate elementId: (BlElementId named: aSymbol));
		yourself
]
