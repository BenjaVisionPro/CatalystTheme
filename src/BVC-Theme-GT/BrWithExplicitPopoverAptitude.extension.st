Extension { #name : #BrWithExplicitPopoverAptitude }

{ #category : #'*BVC-Theme-GT' }
BrWithExplicitPopoverAptitude >> initializeListeners [
	super initializeListeners.

	self
		when: BrPopoverAboutToShowEvent
		do: [ :anEvent |
			anEvent menuContainer theme: anEvent anchorElement theme ]
]
