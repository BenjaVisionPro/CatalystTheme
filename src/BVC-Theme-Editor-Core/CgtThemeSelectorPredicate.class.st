Class {
	#name : 'CgtThemeSelectorPredicate',
	#superclass : 'Object',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
	#comment : 'I am responsible for representing a single predicate inside the theme selector system. I act as the abstract role for concrete predicate types such as id, class, and ordinal matching.'
}

{ #category : 'testing' }
CgtThemeSelectorPredicate >> matchesElement: anElement [
	self subclassResponsibility
]

{ #category : 'printing' }
CgtThemeSelectorPredicate >> displayString [
	self subclassResponsibility
]
