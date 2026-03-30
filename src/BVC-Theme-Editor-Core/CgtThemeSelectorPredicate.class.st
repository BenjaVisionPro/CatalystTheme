"
#Theme Selector Predicate
I am the abstract root of theme selector predicates. I define the idea of one predicate that can contribute to selector matching.
"
Class {
	#name : 'CgtThemeSelectorPredicate',
	#superclass : 'Object',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'testing' }
CgtThemeSelectorPredicate >> matchesElement: anElement [
	self subclassResponsibility
]

{ #category : 'printing' }
CgtThemeSelectorPredicate >> displayString [
	self subclassResponsibility
]
