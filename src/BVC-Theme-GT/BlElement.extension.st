Extension { #name : #BlElement }

{ #category : #'*BVC-Theme-GT' }
BlElement >> border: aBlBorder [
	"Change my border and invalidate me. Resolve themeable border paints at
	the same element/theme boundary already used by #background:."
	<argument: #aBlBorder satisfies: #notNil>
	<event: #BlElementBorderChangedEvent>
	| aNewBorder |
	aNewBorder := aBlBorder asBlBorder.
	aNewBorder := aNewBorder blocResolveForTheme: self theme.
	self border = aNewBorder
		ifTrue: [ ^ self ].

	visuals := visuals border: aNewBorder.
	self geometry releaseStrokedBoundsCache.
	self eventDispatcher dispatchBorderChanged.
	self invalidate
]

{ #category : #'*BVC-Theme-GT' }
BlElement >> onThemeChanged [
	self background: (self background blocResolveForTheme: self theme).
	self border: (self border blocResolveForTheme: self theme).
	self dispatchEvent: BlElementThemeChanged new
]
