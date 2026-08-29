Extension { #name : #BrGlamorousTheme }


{ #category : #'*BVC-Theme-GT' }
BrGlamorousTheme >> controls [
	^ CgtGlamorousControlsSubTheme theme: self
]

{ #category : #'*BVC-Theme-GT' }
BrGlamorousTheme >> interaction [
	^ CgtGlamorousInteractionSubTheme theme: self
]

{ #category : #'*BVC-Theme-GT' }
BrGlamorousTheme >> surfaces [
	^ CgtGlamorousSurfacesSubTheme theme: self
]


{ #category : #'*BVC-Theme-GT' }
BrGlamorousTheme >> typography [
	^ CgtGlamorousTypographySubTheme theme: self
]

{ #category : #'*BVC-Theme-GT' }
BrGlamorousTheme >> menu [
	^ CgtGlamorousMenuSubTheme theme: self
]
