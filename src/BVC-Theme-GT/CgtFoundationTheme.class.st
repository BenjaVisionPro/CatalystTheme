Class {
	#name : #CgtFoundationTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'highlightColor',
		'textHighlightColor',
		'inactiveTextHighlightColor',
		'primaryForeground',
		'secondaryForeground',
		'tertiaryForeground',
		'quaternaryForeground',
		'disabledForeground',
		'formBackground',
		'cardBackground',
		'separatorColor'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtFoundationTheme >> cardBackground [
	^ cardBackground
]

{ #category : #accessing }
CgtFoundationTheme >> disabledForeground [
	^ disabledForeground
]

{ #category : #accessing }
CgtFoundationTheme >> formBackground [
	^ formBackground
]

{ #category : #accessing }
CgtFoundationTheme >> highlightColor [
	^ highlightColor
]

{ #category : #initialization }
CgtFoundationTheme >> initializeThemeable [
	highlightColor := self
		color: [ :aTheme | aTheme themeState highlightColor ]
		source: [ :aTheme | aTheme foundation highlightColor ].

	textHighlightColor := self
		color: [ :aTheme | aTheme themeState textHighlightColor ]
		source: [ :aTheme | aTheme foundation textHighlightColor ].

	inactiveTextHighlightColor := self
		color: [ :aTheme | self inactiveColorFor: aTheme themeState textHighlightColor ]
		source: [ :aTheme | aTheme foundation inactiveTextHighlightColor ].

	primaryForeground := self
		color: [ :aTheme | aTheme foundation constantAt: #primaryForeground ]
		source: [ :aTheme | aTheme foundation primaryForeground ].
	secondaryForeground := self
		color: [ :aTheme | aTheme foundation constantAt: #secondaryForeground ]
		source: [ :aTheme | aTheme foundation secondaryForeground ].
	tertiaryForeground := self
		color: [ :aTheme | aTheme foundation constantAt: #tertiaryForeground ]
		source: [ :aTheme | aTheme foundation tertiaryForeground ].
	quaternaryForeground := self
		color: [ :aTheme | aTheme foundation constantAt: #quaternaryForeground ]
		source: [ :aTheme | aTheme foundation quaternaryForeground ].
	disabledForeground := self
		color: [ :aTheme | aTheme foundation constantAt: #disabledForeground ]
		source: [ :aTheme | aTheme foundation disabledForeground ].

	formBackground := self
		color: [ :aTheme | aTheme foundation constantAt: #formBackground ]
		source: [ :aTheme | aTheme foundation formBackground ].
	cardBackground := self
		color: [ :aTheme | aTheme foundation constantAt: #cardBackground ]
		source: [ :aTheme | aTheme foundation cardBackground ].
	separatorColor := self
		color: [ :aTheme | aTheme foundation constantAt: #separatorColor ]
		source: [ :aTheme | aTheme foundation separatorColor ]
]

{ #category : #private }
CgtFoundationTheme >> inactiveColorFor: aColor [
	| aGrey desaturation aRed aGreen aBlue |
	aGrey := (aColor red * 0.2126)
		+ (aColor green * 0.7152)
		+ (aColor blue * 0.0722).
	desaturation := 0.50.
	aRed := aColor red + ((aGrey - aColor red) * desaturation).
	aGreen := aColor green + ((aGrey - aColor green) * desaturation).
	aBlue := aColor blue + ((aGrey - aColor blue) * desaturation).
	^ Color
		r: aRed + ((1.0 - aRed) * 0.30)
		g: aGreen + ((1.0 - aGreen) * 0.30)
		b: aBlue + ((1.0 - aBlue) * 0.30)
		alpha: aColor alpha
]

{ #category : #accessing }
CgtFoundationTheme >> inactiveTextHighlightColor [
	^ inactiveTextHighlightColor
]

{ #category : #accessing }
CgtFoundationTheme >> lightDirection [
	^ self theme themeState lightDirection
]

{ #category : #accessing }
CgtFoundationTheme >> primaryForeground [
	^ primaryForeground
]

{ #category : #accessing }
CgtFoundationTheme >> quaternaryForeground [
	^ quaternaryForeground
]

{ #category : #accessing }
CgtFoundationTheme >> secondaryForeground [
	^ secondaryForeground
]

{ #category : #accessing }
CgtFoundationTheme >> separatorColor [
	^ separatorColor
]

{ #category : #accessing }
CgtFoundationTheme >> tertiaryForeground [
	^ tertiaryForeground
]

{ #category : #accessing }
CgtFoundationTheme >> textHighlightColor [
	^ textHighlightColor
]
