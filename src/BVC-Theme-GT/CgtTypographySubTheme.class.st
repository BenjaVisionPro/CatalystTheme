Class {
	#name : #CgtTypographySubTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'bodyFontSize',
		'supportingFontSize',
		'groupHeadingFontSize',
		'titleFontSize',
		'metadataFontSize'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtTypographySubTheme >> bodyFontSize [ ^ bodyFontSize ]
{ #category : #accessing }
CgtTypographySubTheme >> groupHeadingFontSize [ ^ groupHeadingFontSize ]

{ #category : #initialization }
CgtTypographySubTheme >> initialize [
	super initialize.
	bodyFontSize := 13.
	supportingFontSize := 11.
	groupHeadingFontSize := 14.
	titleFontSize := 16.
	metadataFontSize := 11
]

{ #category : #accessing }
CgtTypographySubTheme >> supportingFontSize [ ^ supportingFontSize ]
{ #category : #accessing }
CgtTypographySubTheme >> titleFontSize [ ^ titleFontSize ]
{ #category : #accessing }
CgtTypographySubTheme >> metadataFontSize [ ^ metadataFontSize ]
