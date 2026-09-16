Extension { #name : #BlColorPaint }

{ #category : #'*BVC-Theme-GT' }
BlColorPaint >> asSpartaPaintOn: aCanvas [
	"Delegate conversion to the wrapped color-like value. This keeps the
	paint abstraction intact when the color is themeable instead of assuming
	that every color-like value can itself act as a Sparta paint."
	^ color asSpartaPaintOn: aCanvas
]
