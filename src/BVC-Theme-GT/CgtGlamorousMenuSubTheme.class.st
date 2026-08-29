Class {
	#name : #CgtGlamorousMenuSubTheme,
	#superclass : #BlSubTheme,
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtGlamorousMenuSubTheme >> background [
	^ self theme default contentBackground
]

{ #category : #accessing }
CgtGlamorousMenuSubTheme >> borderColor [
	^ Color veryLightGray
]

{ #category : #accessing }
CgtGlamorousMenuSubTheme >> cornerRadius [
	^ BrMenuConstants cornerRadius
]

{ #category : #accessing }
CgtGlamorousMenuSubTheme >> contentInset [
	^ 0
]

{ #category : #accessing }
CgtGlamorousMenuSubTheme >> itemCornerRadius [
	^ 0
]

{ #category : #accessing }
CgtGlamorousMenuSubTheme >> shadowColor [
	^ self theme default defaultShadowColor
]

{ #category : #accessing }
CgtGlamorousMenuSubTheme >> shadowOffset [
	^ 0 @ 1
]

{ #category : #accessing }
CgtGlamorousMenuSubTheme >> shadowWidth [
	^ 2
]
