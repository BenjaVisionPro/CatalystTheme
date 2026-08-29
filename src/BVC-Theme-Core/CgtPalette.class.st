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
CgtPalette class >> textSelectionBlue [ ^ Color r: 186 g: 213 b: 251 range: 255 ]
{ #category : #'appearance - text selection palette' }
CgtPalette class >> textSelectionPurple [ ^ Color r: 218 g: 197 b: 222 range: 255 ]
{ #category : #'appearance - text selection palette' }
CgtPalette class >> textSelectionPink [ ^ Color r: 245 g: 204 b: 225 range: 255 ]
{ #category : #'appearance - text selection palette' }
CgtPalette class >> textSelectionRed [ ^ Color r: 237 g: 197 b: 198 range: 255 ]
{ #category : #'appearance - text selection palette' }
CgtPalette class >> textSelectionOrange [ ^ Color r: 248 g: 219 b: 191 range: 255 ]
{ #category : #'appearance - text selection palette' }
CgtPalette class >> textSelectionYellow [ ^ Color r: 252 g: 238 b: 196 range: 255 ]
{ #category : #'appearance - text selection palette' }
CgtPalette class >> textSelectionGreen [ ^ Color r: 213 g: 233 b: 203 range: 255 ]
{ #category : #'appearance - text selection palette' }
CgtPalette class >> textSelectionGraphite [ ^ Color r: 223 g: 223 b: 224 range: 255 ]

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
