Class {
	#name : #CgtGlamorousMenuTheme,
	#superclass : #BlSubTheme,
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtGlamorousMenuTheme >> background [
	^ self theme default contentBackground
]

{ #category : #accessing }
CgtGlamorousMenuTheme >> borderColor [
	^ Color veryLightGray
]

{ #category : #accessing }
CgtGlamorousMenuTheme >> cornerRadius [
	^ BrMenuConstants cornerRadius
]

{ #category : #accessing }
CgtGlamorousMenuTheme >> contentInset [
	^ 0
]

{ #category : #accessing }
CgtGlamorousMenuTheme >> itemCornerRadius [
	^ 0
]

{ #category : #accessing }
CgtGlamorousMenuTheme >> shadowColor [
	^ self theme default defaultShadowColor
]

{ #category : #accessing }
CgtGlamorousMenuTheme >> shadowOffset [
	^ 0 @ 1
]

{ #category : #accessing }
CgtGlamorousMenuTheme >> shadowWidth [
	^ 2
]
