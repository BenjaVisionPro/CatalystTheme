"
#Theme Selector
I am the abstract root of the theme selector model. I describe how a style rule chooses matching elements in the rendered tree.
"
Class {
	#name : 'CgtThemeSelector',
	#superclass : 'Object',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'instance creation' }
CgtThemeSelector class >> bootstrapForSelectedElement: anElement withinHierarchyRoot: aHierarchyRoot [
	^ CgtThemeSelectorBootstrapBuilder
		selectorForSelectedElement: anElement
		withinHierarchyRoot: aHierarchyRoot
]

{ #category : 'testing' }
CgtThemeSelector >> matchesElement: anElement [
	self subclassResponsibility
]

{ #category : 'printing' }
CgtThemeSelector >> displayString [
	self subclassResponsibility
]
