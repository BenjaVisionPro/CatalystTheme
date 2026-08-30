Class {
	#name : #CgtPalette,
	#superclass : #Object,
	#category : #'BVC-Theme-Core'
}

{ #category : #'appearance - theme colour palette' }
CgtPalette class >> themeBlue [ ^ Color r: 52 g: 120 b: 247 range: 255 ]
{ #category : #'appearance - theme colour palette' }
CgtPalette class >> themePurple [ ^ Color r: 153 g: 84 b: 163 range: 255 ]
{ #category : #'appearance - theme colour palette' }
CgtPalette class >> themePink [ ^ Color r: 228 g: 92 b: 156 range: 255 ]
{ #category : #'appearance - theme colour palette' }
CgtPalette class >> themeRed [ ^ Color r: 237 g: 96 b: 93 range: 255 ]
{ #category : #'appearance - theme colour palette' }
CgtPalette class >> themeOrange [ ^ Color r: 232 g: 135 b: 58 range: 255 ]
{ #category : #'appearance - theme colour palette' }
CgtPalette class >> themeYellow [ ^ Color r: 245 g: 200 b: 68 range: 255 ]
{ #category : #'appearance - theme colour palette' }
CgtPalette class >> themeGreen [ ^ Color r: 120 g: 184 b: 86 range: 255 ]
{ #category : #'appearance - theme colour palette' }
CgtPalette class >> themeGrey [ ^ Color r: 141 g: 141 b: 140 range: 255 ]

{ #category : #'appearance - theme colour palette' }
CgtPalette class >> themeColours [
	^ { self themeBlue. self themePurple. self themePink. self themeRed.
		self themeOrange. self themeYellow. self themeGreen. self themeGrey }
]

{ #category : #'appearance - theme colour palette' }
CgtPalette class >> themeNameFor: aColour [
	aColour = self themeBlue ifTrue: [ ^ 'Blue' ].
	aColour = self themePurple ifTrue: [ ^ 'Purple' ].
	aColour = self themePink ifTrue: [ ^ 'Pink' ].
	aColour = self themeRed ifTrue: [ ^ 'Red' ].
	aColour = self themeOrange ifTrue: [ ^ 'Orange' ].
	aColour = self themeYellow ifTrue: [ ^ 'Yellow' ].
	aColour = self themeGreen ifTrue: [ ^ 'Green' ].
	aColour = self themeGrey ifTrue: [ ^ 'Grey' ].
	^ ''
]

{ #category : #'appearance - text selection palette' }
CgtPalette class >> textSelectionColourFor: aThemeColour [
	| lightened whiteWash |
	lightened := aThemeColour lighter.
	whiteWash := 0.12.
	^ (Color
		r: (lightened red * (1 - whiteWash)) + whiteWash
		g: (lightened green * (1 - whiteWash)) + whiteWash
		b: (lightened blue * (1 - whiteWash)) + whiteWash)
		alpha: 0.3
]

{ #category : #'appearance - text selection palette' }
CgtPalette class >> textSelectionBlue [ ^ self textSelectionColourFor: self themeBlue ]
{ #category : #'appearance - text selection palette' }
CgtPalette class >> textSelectionPurple [ ^ self textSelectionColourFor: self themePurple ]
{ #category : #'appearance - text selection palette' }
CgtPalette class >> textSelectionPink [ ^ self textSelectionColourFor: self themePink ]
{ #category : #'appearance - text selection palette' }
CgtPalette class >> textSelectionRed [ ^ self textSelectionColourFor: self themeRed ]
{ #category : #'appearance - text selection palette' }
CgtPalette class >> textSelectionOrange [ ^ self textSelectionColourFor: self themeOrange ]
{ #category : #'appearance - text selection palette' }
CgtPalette class >> textSelectionYellow [ ^ self textSelectionColourFor: self themeYellow ]
{ #category : #'appearance - text selection palette' }
CgtPalette class >> textSelectionGreen [ ^ self textSelectionColourFor: self themeGreen ]
{ #category : #'appearance - text selection palette' }
CgtPalette class >> textSelectionGraphite [ ^ self textSelectionColourFor: self themeGrey ]

{ #category : #'appearance - text selection palette' }
CgtPalette class >> textSelectionColours [
	^ { self textSelectionBlue. self textSelectionPurple. self textSelectionPink. self textSelectionRed.
		self textSelectionOrange. self textSelectionYellow. self textSelectionGreen. self textSelectionGraphite }
]

{ #category : #'appearance - text selection palette' }
CgtPalette class >> textSelectionNameFor: aColour [
	aColour ifNil: [ ^ 'Automatic' ].
	aColour = self textSelectionBlue ifTrue: [ ^ 'Blue' ].
	aColour = self textSelectionPurple ifTrue: [ ^ 'Purple' ].
	aColour = self textSelectionPink ifTrue: [ ^ 'Pink' ].
	aColour = self textSelectionRed ifTrue: [ ^ 'Red' ].
	aColour = self textSelectionOrange ifTrue: [ ^ 'Orange' ].
	aColour = self textSelectionYellow ifTrue: [ ^ 'Yellow' ].
	aColour = self textSelectionGreen ifTrue: [ ^ 'Green' ].
	aColour = self textSelectionGraphite ifTrue: [ ^ 'Graphite' ].
	^ ''
]

{ #category : #'appearance - text selection palette' }
CgtPalette class >> automaticTextSelectionColourForThemeColour: aThemeColour [
	| anIndex |
	anIndex := self themeColours indexOf: aThemeColour ifAbsent: [ 1 ].
	^ self textSelectionColours at: anIndex
]
