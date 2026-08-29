Class {
	#name : #CgtSurfacesSubTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'baseBackground',
		'cardTint',
		'separatorTint'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtSurfacesSubTheme >> baseBackground [ ^ baseBackground ]

{ #category : #accessing }
CgtSurfacesSubTheme >> cardTint [ ^ cardTint ]

{ #category : #initialization }
CgtSurfacesSubTheme >> initializeThemeable [
	baseBackground := self
		color: [ :aTheme | aTheme surfaces constantAt: #baseBackground ]
		source: [ :aTheme | aTheme surfaces baseBackground ].
	cardTint := self
		color: [ :aTheme | aTheme surfaces constantAt: #cardTint ]
		source: [ :aTheme | aTheme surfaces cardTint ].
	separatorTint := self
		color: [ :aTheme | aTheme surfaces constantAt: #separatorTint ]
		source: [ :aTheme | aTheme surfaces separatorTint ]
]

{ #category : #accessing }
CgtSurfacesSubTheme >> separatorTint [ ^ separatorTint ]
