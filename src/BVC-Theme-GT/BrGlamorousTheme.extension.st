Extension { #name : #BrGlamorousTheme }




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

{ #category : #'*BVC-Theme-GT' }
BrGlamorousTheme >> toggleGroup [
	^ CgtGlamorousToggleGroupSubTheme theme: self
]

{ #category : #'*BVC-Theme-GT' }
BrGlamorousTheme >> slider [ ^ CgtGlamorousSliderSubTheme theme: self ]

{ #category : #'*BVC-Theme-GT' }
BrGlamorousTheme >> switch [ ^ CgtGlamorousSwitchSubTheme theme: self ]

{ #category : #'*BVC-Theme-GT' }
BrGlamorousTheme >> tag [ ^ CgtGlamorousTagSubTheme theme: self ]

{ #category : #'*BVC-Theme-GT' }
BrGlamorousTheme >> tabSwitcher [ ^ CgtGlamorousTabSwitcherSubTheme theme: self ]
