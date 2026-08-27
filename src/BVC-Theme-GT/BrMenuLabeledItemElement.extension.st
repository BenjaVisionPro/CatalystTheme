Extension { #name : #BrMenuLabeledItemElement }

{ #category : #'*BVC-Theme-GT' }
BrMenuLabeledItemElement >> applySelectionStateToLabel [
	self menuModel ifNil: [ ^ self ].
	labelElement dispatchEvent:
		(BlElementSelectedStateWish selected: self menuModel isSelected)
]

{ #category : #'*BVC-Theme-GT' }
BrMenuLabeledItemElement >> onMenuModelChanged [
	super onMenuModelChanged.
	self updateLabelElement.
	self applySelectionStateToLabel
]

{ #category : #'*BVC-Theme-GT' }
BrMenuLabeledItemElement >> onSelectionChanged: anAnnouncement [
	super onSelectionChanged: anAnnouncement.
	self applySelectionStateToLabel
]
