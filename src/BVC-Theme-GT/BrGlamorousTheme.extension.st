Extension { #name : #BrGlamorousTheme }

{ #category : #'*BVC-Theme-GT' }
BrGlamorousTheme >> highlight [
	| aHighlightTheme |
	aHighlightTheme := CgtHighlightTheme theme: self.
	aHighlightTheme initializeThemeable.
	^ aHighlightTheme
]

{ #category : #'*BVC-Theme-GT' }
BrGlamorousTheme >> lighting [
	^ CgtLightingTheme theme: self
]

{ #category : #'*BVC-Theme-GT' }
BrGlamorousTheme >> surfaces [
	^ CgtGlamorousSurfacesTheme theme: self
]

{ #category : #'*BVC-Theme-GT' }
BrGlamorousTheme >> themeState [
	^ CgtThemeState default
]

{ #category : #'*BVC-Theme-GT' }
BrGlamorousTheme >> typography [
	^ CgtGlamorousTypographyTheme theme: self
]
