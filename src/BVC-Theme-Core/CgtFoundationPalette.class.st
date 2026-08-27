Class {
	#name : #CgtFoundationPalette,
	#superclass : #Object,
	#category : #'BVC-Theme-Core'
}

{ #category : #'accent - highlight palette' }
CgtFoundationPalette class >> highlightBlue [ ^ Color r: 52 g: 120 b: 247 range: 255 ]
{ #category : #'accent - highlight palette' }
CgtFoundationPalette class >> highlightPurple [ ^ Color r: 153 g: 84 b: 163 range: 255 ]
{ #category : #'accent - highlight palette' }
CgtFoundationPalette class >> highlightPink [ ^ Color r: 228 g: 92 b: 156 range: 255 ]
{ #category : #'accent - highlight palette' }
CgtFoundationPalette class >> highlightRed [ ^ Color r: 237 g: 96 b: 93 range: 255 ]
{ #category : #'accent - highlight palette' }
CgtFoundationPalette class >> highlightOrange [ ^ Color r: 232 g: 135 b: 58 range: 255 ]
{ #category : #'accent - highlight palette' }
CgtFoundationPalette class >> highlightYellow [ ^ Color r: 245 g: 200 b: 68 range: 255 ]
{ #category : #'accent - highlight palette' }
CgtFoundationPalette class >> highlightGreen [ ^ Color r: 120 g: 184 b: 86 range: 255 ]
{ #category : #'accent - highlight palette' }
CgtFoundationPalette class >> highlightGrey [ ^ Color r: 141 g: 141 b: 140 range: 255 ]

{ #category : #'accent - highlight palette' }
CgtFoundationPalette class >> highlightColours [
	^ { self highlightBlue. self highlightPurple. self highlightPink. self highlightRed.
		self highlightOrange. self highlightYellow. self highlightGreen. self highlightGrey }
]

{ #category : #'accent - highlight palette' }
CgtFoundationPalette class >> highlightNameFor: aColour [
	aColour = self highlightBlue ifTrue: [ ^ 'Blue' ].
	aColour = self highlightPurple ifTrue: [ ^ 'Purple' ].
	aColour = self highlightPink ifTrue: [ ^ 'Pink' ].
	aColour = self highlightRed ifTrue: [ ^ 'Red' ].
	aColour = self highlightOrange ifTrue: [ ^ 'Orange' ].
	aColour = self highlightYellow ifTrue: [ ^ 'Yellow' ].
	aColour = self highlightGreen ifTrue: [ ^ 'Green' ].
	aColour = self highlightGrey ifTrue: [ ^ 'Grey' ].
	^ ''
]

{ #category : #'accent - text highlight palette' }
CgtFoundationPalette class >> textHighlightBlue [ ^ Color r: 186 g: 213 b: 251 range: 255 ]
{ #category : #'accent - text highlight palette' }
CgtFoundationPalette class >> textHighlightPurple [ ^ Color r: 218 g: 197 b: 222 range: 255 ]
{ #category : #'accent - text highlight palette' }
CgtFoundationPalette class >> textHighlightPink [ ^ Color r: 245 g: 204 b: 225 range: 255 ]
{ #category : #'accent - text highlight palette' }
CgtFoundationPalette class >> textHighlightRed [ ^ Color r: 237 g: 197 b: 198 range: 255 ]
{ #category : #'accent - text highlight palette' }
CgtFoundationPalette class >> textHighlightOrange [ ^ Color r: 248 g: 219 b: 191 range: 255 ]
{ #category : #'accent - text highlight palette' }
CgtFoundationPalette class >> textHighlightYellow [ ^ Color r: 252 g: 238 b: 196 range: 255 ]
{ #category : #'accent - text highlight palette' }
CgtFoundationPalette class >> textHighlightGreen [ ^ Color r: 213 g: 233 b: 203 range: 255 ]
{ #category : #'accent - text highlight palette' }
CgtFoundationPalette class >> textHighlightGraphite [ ^ Color r: 223 g: 223 b: 224 range: 255 ]

{ #category : #'accent - text highlight palette' }
CgtFoundationPalette class >> textHighlightColours [
	^ { self textHighlightBlue. self textHighlightPurple. self textHighlightPink. self textHighlightRed.
		self textHighlightOrange. self textHighlightYellow. self textHighlightGreen. self textHighlightGraphite }
]

{ #category : #'accent - text highlight palette' }
CgtFoundationPalette class >> textHighlightNameFor: aColour [
	aColour ifNil: [ ^ 'Automatic' ].
	aColour = self textHighlightBlue ifTrue: [ ^ 'Blue' ].
	aColour = self textHighlightPurple ifTrue: [ ^ 'Purple' ].
	aColour = self textHighlightPink ifTrue: [ ^ 'Pink' ].
	aColour = self textHighlightRed ifTrue: [ ^ 'Red' ].
	aColour = self textHighlightOrange ifTrue: [ ^ 'Orange' ].
	aColour = self textHighlightYellow ifTrue: [ ^ 'Yellow' ].
	aColour = self textHighlightGreen ifTrue: [ ^ 'Green' ].
	aColour = self textHighlightGraphite ifTrue: [ ^ 'Graphite' ].
	^ ''
]

{ #category : #'accent - text highlight palette' }
CgtFoundationPalette class >> automaticTextHighlightColourForHighlight: aHighlightColour [
	| anIndex |
	anIndex := self highlightColours indexOf: aHighlightColour ifAbsent: [ 1 ].
	^ self textHighlightColours at: anIndex
]
