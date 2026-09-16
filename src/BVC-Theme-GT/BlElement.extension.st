Extension { #name : #BlElement }

{ #category : #'*BVC-Theme-GT' }
BlElement >> drawOnSpartaCanvas: aCanvas [
	self shouldDrawBackgroundOrBorder
		ifFalse: [ ^ self ].

	aCanvas figure
		path: (self geometry pathOnSpartaCanvas: aCanvas of: self);
		background: self background;
		backgroundAlpha: self background opacity;
		border: (self border paint blocResolveColorForTheme: self theme);
		borderAlpha: self border opacity;
		width: self border width;
		in: [ :aPainter | self border style applyOn: aPainter ];
		in: [ :aPainter |
			self outskirts = BlOutskirts outside
				ifTrue: [ aPainter borderOutside ].
			self outskirts = BlOutskirts centered
				ifTrue: [ aPainter borderCentered ].
			self outskirts = BlOutskirts inside
				ifTrue: [ aPainter borderInside ] ];
		draw
]
