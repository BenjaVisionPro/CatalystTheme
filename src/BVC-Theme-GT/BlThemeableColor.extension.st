Extension { #name : #BlThemeableColor }

{ #category : #'*BVC-Theme-GT' }
BlThemeableColor >> alpha: anAlpha [
	^ self class
		color: [ :aTheme |
			(colorComputation value: aTheme) alpha: anAlpha ]
		source: [ :aTheme |
			(themeableColorComputation value: aTheme) alpha: anAlpha ]
		forTheme: theme
]

{ #category : #'*BVC-Theme-GT' }
BlThemeableColor >> darker [
	^ self class
		color: [ :aTheme |
			(colorComputation value: aTheme) darker ]
		source: [ :aTheme |
			(themeableColorComputation value: aTheme) darker ]
		forTheme: theme
]

{ #category : #'*BVC-Theme-GT' }
BlThemeableColor >> lighter [
	^ self class
		color: [ :aTheme |
			(colorComputation value: aTheme) lighter ]
		source: [ :aTheme |
			(themeableColorComputation value: aTheme) lighter ]
		forTheme: theme
]

{ #category : #'*BVC-Theme-GT' }
BlThemeableColor >> muchDarker [
	^ self class
		color: [ :aTheme |
			(colorComputation value: aTheme) muchDarker ]
		source: [ :aTheme |
			(themeableColorComputation value: aTheme) muchDarker ]
		forTheme: theme
]

{ #category : #'*BVC-Theme-GT' }
BlThemeableColor >> muchLighter [
	^ self class
		color: [ :aTheme |
			(colorComputation value: aTheme) muchLighter ]
		source: [ :aTheme |
			(themeableColorComputation value: aTheme) muchLighter ]
		forTheme: theme
]

{ #category : #'*BVC-Theme-GT' }
BlThemeableColor >> spartaFillCircle: aSpartaCircle with: aFillPainter [
	color spartaFillCircle: aSpartaCircle with: aFillPainter
]

{ #category : #'*BVC-Theme-GT' }
BlThemeableColor >> spartaFillPath: aPath with: aFillPainter [
	color spartaFillPath: aPath with: aFillPainter
]

{ #category : #'*BVC-Theme-GT' }
BlThemeableColor >> spartaFillRectangle: aRectangle with: aFillPainter [
	color spartaFillRectangle: aRectangle with: aFillPainter
]

{ #category : #'*BVC-Theme-GT' }
BlThemeableColor >> spartaFillRoundedRectangle: aRectangle with: aFillPainter [
	color spartaFillRoundedRectangle: aRectangle with: aFillPainter
]

{ #category : #'*BVC-Theme-GT' }
BlThemeableColor >> spartaFillString: aString with: aTextPainter [
	color spartaFillString: aString with: aTextPainter
]

{ #category : #'*BVC-Theme-GT' }
BlThemeableColor >> spartaFillTextRun: aTextRun with: aTextPainter [
	color spartaFillTextRun: aTextRun with: aTextPainter
]

{ #category : #'*BVC-Theme-GT' }
BlThemeableColor >> spartaMaskOn: aSpartaCanvas with: aMaskPainter [
	color spartaMaskOn: aSpartaCanvas with: aMaskPainter
]

{ #category : #'*BVC-Theme-GT' }
BlThemeableColor >> spartaStrokeCircle: aSpartaCircle with: aStrokePainter [
	color spartaStrokeCircle: aSpartaCircle with: aStrokePainter
]

{ #category : #'*BVC-Theme-GT' }
BlThemeableColor >> spartaStrokeLine: aLine with: aStrokePainter [
	color spartaStrokeLine: aLine with: aStrokePainter
]

{ #category : #'*BVC-Theme-GT' }
BlThemeableColor >> spartaStrokeRectangle: aRectangle with: aStrokePainter [
	color spartaStrokeRectangle: aRectangle with: aStrokePainter
]

{ #category : #'*BVC-Theme-GT' }
BlThemeableColor >> spartaStrokeRoundedRectangle: aRoundedRectangle with: aStrokePainter [
	color spartaStrokeRoundedRectangle: aRoundedRectangle with: aStrokePainter
]

{ #category : #'*BVC-Theme-GT' }
BlThemeableColor >> spartaStrokeString: aString fillColor: aFillColor with: aTextPainter [
	color spartaStrokeString: aString fillColor: aFillColor with: aTextPainter
]

{ #category : #'*BVC-Theme-GT' }
BlThemeableColor >> spartaStrokeString: aString fillPaint: aFillPaint with: aTextPainter [
	color spartaStrokeString: aString fillPaint: aFillPaint with: aTextPainter
]

{ #category : #'*BVC-Theme-GT' }
BlThemeableColor >> spartaStrokeTextRun: aTextRun fillColor: aFillColor with: aTextPainter [
	color spartaStrokeTextRun: aTextRun fillColor: aFillColor with: aTextPainter
]

{ #category : #'*BVC-Theme-GT' }
BlThemeableColor >> spartaStrokeTextRun: aTextRun fillPaint: aFillPaint with: aTextPainter [
	color spartaStrokeTextRun: aTextRun fillPaint: aFillPaint with: aTextPainter
]
