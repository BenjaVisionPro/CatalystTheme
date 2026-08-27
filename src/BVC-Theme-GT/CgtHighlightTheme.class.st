Class {
	#name : #CgtHighlightTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'color',
		'textColor',
		'inactiveTextColor'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtHighlightTheme >> color [ ^ color ]

{ #category : #private }
CgtHighlightTheme >> inactiveColorFor: aColor [
	| aGrey desaturation aRed aGreen aBlue |
	aGrey := (aColor red * 0.2126) + (aColor green * 0.7152) + (aColor blue * 0.0722).
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
CgtHighlightTheme >> inactiveTextColor [ ^ inactiveTextColor ]

{ #category : #initialization }
CgtHighlightTheme >> initializeThemeable [
	color := self
		color: [ :aTheme | aTheme themeState highlightColor ]
		source: [ :aTheme |
			(aTheme respondsTo: #highlight)
				ifTrue: [ aTheme highlight color ]
				ifFalse: [ self theme themeState highlightColor ] ].
	textColor := self
		color: [ :aTheme | aTheme themeState textHighlightColor ]
		source: [ :aTheme |
			(aTheme respondsTo: #highlight)
				ifTrue: [ aTheme highlight textColor ]
				ifFalse: [ self theme themeState textHighlightColor ] ].
	inactiveTextColor := self
		color: [ :aTheme | self inactiveColorFor: aTheme themeState textHighlightColor ]
		source: [ :aTheme |
			(aTheme respondsTo: #highlight)
				ifTrue: [ aTheme highlight inactiveTextColor ]
				ifFalse: [ self inactiveColorFor: self theme themeState textHighlightColor ] ]
]

{ #category : #accessing }
CgtHighlightTheme >> textColor [ ^ textColor ]
