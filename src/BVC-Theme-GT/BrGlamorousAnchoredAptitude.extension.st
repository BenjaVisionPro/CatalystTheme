Extension { #name : #BrGlamorousAnchoredAptitude }

{ #category : #'*BVC-Theme-GT' }
BrGlamorousAnchoredAptitude >> initialize [
	super initialize.
	background := self theme default contentBackground.
	border := self theme button defaultBorderColor asBlBorder.
	cornerRadius := 4.

	self
		add: BrShadowAptitude new;
		addChangeProperty: #(widget geometry)
			with: [ BrAnchoredGeometry cornerRadius: self cornerRadius element: widget ];
		addChangeProperty: #(widget background)
			with: [ self background ];
		addChangeProperty: #(widget border)
			with: [ border asBlBorder ]
]
