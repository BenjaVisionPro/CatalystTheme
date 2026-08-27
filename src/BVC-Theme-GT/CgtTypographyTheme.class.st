Class {
	#name : #CgtTypographyTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'bodyFontSize',
		'supportingFontSize',
		'groupHeadingFontSize'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtTypographyTheme >> bodyFontSize [
	^ bodyFontSize
]

{ #category : #accessing }
CgtTypographyTheme >> groupHeadingFontSize [
	^ groupHeadingFontSize
]

{ #category : #initialization }
CgtTypographyTheme >> initialize [
	super initialize.
	bodyFontSize := 13.
	supportingFontSize := 11.
	groupHeadingFontSize := 14
]

{ #category : #accessing }
CgtTypographyTheme >> supportingFontSize [
	^ supportingFontSize
]
