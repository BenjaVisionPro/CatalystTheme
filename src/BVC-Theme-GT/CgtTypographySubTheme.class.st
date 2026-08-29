Class {
	#name : #CgtTypographySubTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'bodyFontSize',
		'supportingFontSize',
		'groupHeadingFontSize',
		'primaryForeground',
		'secondaryForeground',
		'tertiaryForeground',
		'quaternaryForeground',
		'disabledForeground',
		'titleFontSize',
		'metadataFontSize',
		'titleForeground',
		'metadataForeground'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtTypographySubTheme >> bodyFontSize [ ^ bodyFontSize ]
{ #category : #accessing }
CgtTypographySubTheme >> disabledForeground [ ^ disabledForeground ]
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

{ #category : #initialization }
CgtTypographySubTheme >> initializeThemeable [
	primaryForeground := self
		color: [ :aTheme | aTheme typography constantAt: #primaryForeground ]
		source: [ :aTheme | aTheme typography primaryForeground ].
	secondaryForeground := self
		color: [ :aTheme | aTheme typography constantAt: #secondaryForeground ]
		source: [ :aTheme | aTheme typography secondaryForeground ].
	tertiaryForeground := self
		color: [ :aTheme | aTheme typography constantAt: #tertiaryForeground ]
		source: [ :aTheme | aTheme typography tertiaryForeground ].
	quaternaryForeground := self
		color: [ :aTheme | aTheme typography constantAt: #quaternaryForeground ]
		source: [ :aTheme | aTheme typography quaternaryForeground ].
	disabledForeground := self
		color: [ :aTheme | aTheme typography constantAt: #disabledForeground ]
		source: [ :aTheme | aTheme typography disabledForeground ].
	titleForeground := self
		color: [ :aTheme | aTheme typography constantAt: #titleForeground ]
		source: [ :aTheme | aTheme typography titleForeground ].
	metadataForeground := self
		color: [ :aTheme | aTheme typography constantAt: #metadataForeground ]
		source: [ :aTheme | aTheme typography metadataForeground ]
]

{ #category : #accessing }
CgtTypographySubTheme >> primaryForeground [ ^ primaryForeground ]
{ #category : #accessing }
CgtTypographySubTheme >> quaternaryForeground [ ^ quaternaryForeground ]
{ #category : #accessing }
CgtTypographySubTheme >> secondaryForeground [ ^ secondaryForeground ]
{ #category : #accessing }
CgtTypographySubTheme >> supportingFontSize [ ^ supportingFontSize ]
{ #category : #accessing }
CgtTypographySubTheme >> tertiaryForeground [ ^ tertiaryForeground ]

{ #category : #accessing }
CgtTypographySubTheme >> titleFontSize [ ^ titleFontSize ]
{ #category : #accessing }
CgtTypographySubTheme >> metadataFontSize [ ^ metadataFontSize ]
{ #category : #accessing }
CgtTypographySubTheme >> titleForeground [ ^ titleForeground ]
{ #category : #accessing }
CgtTypographySubTheme >> metadataForeground [ ^ metadataForeground ]
