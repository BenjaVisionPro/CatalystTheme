Class {
	#name : #CgtTypographyTheme,
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
CgtTypographyTheme >> bodyFontSize [ ^ bodyFontSize ]
{ #category : #accessing }
CgtTypographyTheme >> disabledForeground [ ^ disabledForeground ]
{ #category : #accessing }
CgtTypographyTheme >> groupHeadingFontSize [ ^ groupHeadingFontSize ]

{ #category : #initialization }
CgtTypographyTheme >> initialize [
	super initialize.
	bodyFontSize := 13.
	supportingFontSize := 11.
	groupHeadingFontSize := 14.
	titleFontSize := 16.
	metadataFontSize := 11
]

{ #category : #initialization }
CgtTypographyTheme >> initializeThemeable [
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
CgtTypographyTheme >> primaryForeground [ ^ primaryForeground ]
{ #category : #accessing }
CgtTypographyTheme >> quaternaryForeground [ ^ quaternaryForeground ]
{ #category : #accessing }
CgtTypographyTheme >> secondaryForeground [ ^ secondaryForeground ]
{ #category : #accessing }
CgtTypographyTheme >> supportingFontSize [ ^ supportingFontSize ]
{ #category : #accessing }
CgtTypographyTheme >> tertiaryForeground [ ^ tertiaryForeground ]

{ #category : #accessing }
CgtTypographyTheme >> titleFontSize [ ^ titleFontSize ]
{ #category : #accessing }
CgtTypographyTheme >> metadataFontSize [ ^ metadataFontSize ]
{ #category : #accessing }
CgtTypographyTheme >> titleForeground [ ^ titleForeground ]
{ #category : #accessing }
CgtTypographyTheme >> metadataForeground [ ^ metadataForeground ]
