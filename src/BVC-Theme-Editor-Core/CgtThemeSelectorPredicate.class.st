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
