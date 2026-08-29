Class {
	#name : #CgtGlamorousTypographySubTheme,
	#superclass : #BlSubTheme,
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtGlamorousTypographySubTheme >> bodyFontSize [
	^ 13
]

{ #category : #accessing }
CgtGlamorousTypographySubTheme >> disabledForeground [
	^ self theme colors disabledTextColor
]

{ #category : #accessing }
CgtGlamorousTypographySubTheme >> groupHeadingFontSize [
	^ 14
]

{ #category : #accessing }
CgtGlamorousTypographySubTheme >> primaryForeground [
	^ self theme label defaultTextForeground
]

{ #category : #accessing }
CgtGlamorousTypographySubTheme >> quaternaryForeground [
	^ self theme colors disabledTextColor
]

{ #category : #accessing }
CgtGlamorousTypographySubTheme >> secondaryForeground [
	^ self theme label metadataTextForeground
]

{ #category : #accessing }
CgtGlamorousTypographySubTheme >> supportingFontSize [
	^ 11
]

{ #category : #accessing }
CgtGlamorousTypographySubTheme >> tertiaryForeground [
	^ self theme colors tertiaryTextColor
]

{ #category : #accessing }
CgtGlamorousTypographySubTheme >> titleFontSize [ ^ 16 ]
{ #category : #accessing }
CgtGlamorousTypographySubTheme >> metadataFontSize [ ^ 11 ]
{ #category : #accessing }
CgtGlamorousTypographySubTheme >> titleForeground [ ^ self theme colors primaryTextColor ]
{ #category : #accessing }
CgtGlamorousTypographySubTheme >> metadataForeground [ ^ self theme colors secondaryTextColor ]
