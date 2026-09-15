Class {
	#name : #CgtGlamorousTabSwitcherSubTheme,
	#superclass : #BlSubTheme,
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtGlamorousTabSwitcherSubTheme >> background [ ^ Color white ]
{ #category : #accessing }
CgtGlamorousTabSwitcherSubTheme >> hoveredBackground [ ^ Color veryVeryLightGray lighter ]
{ #category : #accessing }
CgtGlamorousTabSwitcherSubTheme >> pressedBackground [ ^ Color veryVeryLightGray ]
{ #category : #accessing }
CgtGlamorousTabSwitcherSubTheme >> selectedBackground [ ^ self theme item selectedColor ]
{ #category : #accessing }
CgtGlamorousTabSwitcherSubTheme >> foreground [ ^ Color black ]
{ #category : #accessing }
CgtGlamorousTabSwitcherSubTheme >> headerBackground [ ^ Color white ]
