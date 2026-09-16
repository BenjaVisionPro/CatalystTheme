Extension { #name : #BlCurveElement }

{ #category : #'*BVC-Theme-GT' }
BlCurveElement >> drawOnSpartaCanvas: aCanvas [
	| aBorder |
	aBorder := self border.
	aCanvas stroke
		alpha: aBorder opacity;
		paint: (aBorder paint blocResolveColorForTheme: self theme);
		path: (self geometry pathOnSpartaCanvas: aCanvas of: self);
		width: aBorder width;
		in: [ :aPainter | aBorder style applyOn: aPainter ];
		draw.
	self drawArrowHeadsOnSpartaCanvas: aCanvas
]
