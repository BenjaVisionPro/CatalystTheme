Extension { #name : #BrGlamorousTheme }


{ #category : #'*BVC-Theme-GT' }
BrGlamorousTheme >> controls [
	^ CgtGlamorousControlsSubTheme theme: self
]

{ #category : #'*BVC-Theme-GT' }
BrGlamorousTheme >> toggleGroup [
	^ CgtGlamorousToggleGroupSubTheme theme: self
]



{ #category : #'*BVC-Theme-GT' }
BrGlamorousTheme >> typography [
	^ CgtGlamorousTypographySubTheme theme: self
]

{ #category : #'*BVC-Theme-GT' }
BrGlamorousTheme >> menu [
	^ CgtGlamorousMenuSubTheme theme: self
]

{ #category : #'*BVC-Theme-GT' }
BrGlamorousTheme >> tooltip [
	^ CgtTooltipSubTheme theme: self
]
