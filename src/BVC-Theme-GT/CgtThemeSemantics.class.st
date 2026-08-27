"I bridge Catalyst semantic theme domains across element construction. Attached elements use their effective theme; unattached elements safely fall back to the shared global theme state until they inherit a Catalyst theme."
Class {
	#name : #CgtThemeSemantics,
	#superclass : #Object,
	#category : #'BVC-Theme-GT'
}

{ #category : #'highlight' }
CgtThemeSemantics class >> highlightColorFor: aTheme [
	| aColor |
	aColor := (aTheme respondsTo: #highlight)
		ifTrue: [ aTheme highlight color ]
		ifFalse: [ CgtThemeState default highlightColor ].
	^ aColor blocResolveColorForTheme: aTheme
]

{ #category : #'highlight' }
CgtThemeSemantics class >> textHighlightColorFor: aTheme [
	| aColor |
	aColor := (aTheme respondsTo: #highlight)
		ifTrue: [ aTheme highlight textColor ]
		ifFalse: [ CgtThemeState default textHighlightColor ].
	^ aColor blocResolveColorForTheme: aTheme
]

{ #category : #'highlight' }
CgtThemeSemantics class >> inactiveTextHighlightColorFor: aTheme [
	| aColor |
	aColor := (aTheme respondsTo: #highlight)
		ifTrue: [ aTheme highlight inactiveTextColor ]
		ifFalse: [ self inactiveTextHighlightColor ].
	^ aColor blocResolveColorForTheme: aTheme
]

{ #category : #'highlight' }
CgtThemeSemantics class >> inactiveTextHighlightColor [
	| aColor aGrey desaturation aRed aGreen aBlue |
	aColor := CgtThemeState default textHighlightColor.
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

{ #category : #'typography' }
CgtThemeSemantics class >> primaryForegroundFor: aTheme [
	| aColor |
	aColor := (aTheme respondsTo: #typography)
		ifTrue: [ aTheme typography primaryForeground ]
		ifFalse: [ aTheme colors primaryTextColor ].
	^ aColor blocResolveColorForTheme: aTheme
]

{ #category : #'typography' }
CgtThemeSemantics class >> secondaryForegroundFor: aTheme [
	| aColor |
	aColor := (aTheme respondsTo: #typography)
		ifTrue: [ aTheme typography secondaryForeground ]
		ifFalse: [ aTheme colors secondaryTextColor ].
	^ aColor blocResolveColorForTheme: aTheme
]

{ #category : #'typography' }
CgtThemeSemantics class >> tertiaryForegroundFor: aTheme [
	| aColor |
	aColor := (aTheme respondsTo: #typography)
		ifTrue: [ aTheme typography tertiaryForeground ]
		ifFalse: [ aTheme colors tertiaryTextColor ].
	^ aColor blocResolveColorForTheme: aTheme
]

{ #category : #'typography' }
CgtThemeSemantics class >> bodyFontSizeFor: aTheme [
	^ (aTheme respondsTo: #typography)
		ifTrue: [ aTheme typography bodyFontSize ]
		ifFalse: [ 13 ]
]

{ #category : #'typography' }
CgtThemeSemantics class >> supportingFontSizeFor: aTheme [
	^ (aTheme respondsTo: #typography)
		ifTrue: [ aTheme typography supportingFontSize ]
		ifFalse: [ 11 ]
]

{ #category : #'typography' }
CgtThemeSemantics class >> groupHeadingFontSizeFor: aTheme [
	^ (aTheme respondsTo: #typography)
		ifTrue: [ aTheme typography groupHeadingFontSize ]
		ifFalse: [ 14 ]
]

{ #category : #'surfaces' }
CgtThemeSemantics class >> formBackgroundFor: aTheme [
	| aColor |
	aColor := (aTheme respondsTo: #surfaces)
		ifTrue: [ aTheme surfaces formBackground ]
		ifFalse: [ aTheme colors contentBackgroundColor ].
	^ aColor blocResolveColorForTheme: aTheme
]

{ #category : #'surfaces' }
CgtThemeSemantics class >> cardBackgroundFor: aTheme [
	| aColor |
	aColor := (aTheme respondsTo: #surfaces)
		ifTrue: [ aTheme surfaces cardBackground ]
		ifFalse: [ aTheme colors contentBackgroundColor ].
	^ aColor blocResolveColorForTheme: aTheme
]

{ #category : #'surfaces' }
CgtThemeSemantics class >> separatorColorFor: aTheme [
	| aColor |
	aColor := (aTheme respondsTo: #surfaces)
		ifTrue: [ aTheme surfaces separatorColor ]
		ifFalse: [ aTheme colors tertiaryTextColor ].
	^ aColor blocResolveColorForTheme: aTheme
]
