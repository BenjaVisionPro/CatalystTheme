Class {
	#name : #CgtGlamorousTypographyTheme,
	#superclass : #BlSubTheme,
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtGlamorousTypographyTheme >> bodyFontSize [
	^ 13
]

{ #category : #accessing }
CgtGlamorousTypographyTheme >> disabledForeground [
	^ self theme colors disabledTextColor
]

{ #category : #accessing }
CgtGlamorousTypographyTheme >> groupHeadingFontSize [
	^ 14
]

{ #category : #accessing }
CgtGlamorousTypographyTheme >> primaryForeground [
	^ self theme label defaultTextForeground
]

{ #category : #accessing }
CgtGlamorousTypographyTheme >> quaternaryForeground [
	^ self theme colors disabledTextColor
]

{ #category : #accessing }
CgtGlamorousTypographyTheme >> secondaryForeground [
	^ self theme label metadataTextForeground
]

{ #category : #accessing }
CgtGlamorousTypographyTheme >> supportingFontSize [
	^ 11
]

{ #category : #accessing }
CgtGlamorousTypographyTheme >> tertiaryForeground [
	^ self theme colors tertiaryTextColor
]
