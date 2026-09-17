Extension { #name : #BrGlamorousEditorSpacingAptitude }

{ #category : #'*BVC-Theme-GT' }
BrGlamorousEditorSpacingAptitude >> initialize [
	super initialize.
	self
		addChangeProperty: #(widgetContent background)
		with: [ self theme editor defaultBackground ].
	self
		addChangeProperty: #(widgetContent border)
		with: [ BlBorder paint: self theme editor borderColor width: 1 ]
]

{ #category : #'*BVC-Theme-GT' }
BrGlamorousEditorSpacingAptitude >> initializeListeners [
	super initializeListeners.

	self when: BlFocusOutEvent do: [ :anEvent | self blurEvent: anEvent ].
	self when: BlFocusInEvent do: [ :anEvent | self focusEvent: anEvent ]
]
