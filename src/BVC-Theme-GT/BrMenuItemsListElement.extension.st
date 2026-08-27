Extension { #name : #BrMenuItemsListElement }

{ #category : #'*BVC-Theme-GT' }
BrMenuItemsListElement >> applyMenuContentInset [
	listElement padding: (BlInsets all: self theme menu contentInset)
]

{ #category : #'*BVC-Theme-GT' }
BrMenuItemsListElement >> onThemeChanged [
	super onThemeChanged.
	self applyMenuContentInset
]
