Class {
	#name : #CgtSurfacesTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'baseBackground',
		'cardTint',
		'separatorTint'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtSurfacesTheme >> baseBackground [ ^ baseBackground ]

{ #category : #accessing }
CgtSurfacesTheme >> cardTint [ ^ cardTint ]

{ #category : #initialization }
CgtSurfacesTheme >> initializeThemeable [
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
CgtSurfacesTheme >> separatorTint [ ^ separatorTint ]
