Class {
	#name : #CgtFoundationTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'highlightColor',
		'textHighlightColor',
		'inactiveTextHighlightColor'
	],
	#category : #'BVC-Theme-GT'
}

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
		source: [ :aTheme | aTheme foundation inactiveTextHighlightColor ]
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
CgtFoundationTheme >> textHighlightColor [
	^ textHighlightColor
]
