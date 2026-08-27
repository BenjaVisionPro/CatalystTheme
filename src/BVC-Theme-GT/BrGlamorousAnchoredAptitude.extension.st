Extension { #name : #BrGlamorousAnchoredAptitude }

{ #category : #'*BVC-Theme-GT' }
BrGlamorousAnchoredAptitude >> initialize [
	super initialize.
	background := self theme interaction popupBackgroundTint
		blocResolveColorForTheme: self theme.
	border := (BlBorder
		paint: (self theme interaction controlBackgroundTint
			blocResolveColorForTheme: self theme)
		width: 1).
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
