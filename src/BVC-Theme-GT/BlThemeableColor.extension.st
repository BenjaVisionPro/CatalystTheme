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
