Class {
	#name : #CgtSurfacesTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'formBackground',
		'cardBackground',
		'separatorColor'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtSurfacesTheme >> cardBackground [ ^ cardBackground ]

{ #category : #accessing }
CgtSurfacesTheme >> formBackground [ ^ formBackground ]

{ #category : #initialization }
CgtSurfacesTheme >> initializeThemeable [
	formBackground := self
		color: [ :aTheme | aTheme surfaces constantAt: #formBackground ]
		source: [ :aTheme | aTheme surfaces formBackground ].
	cardBackground := self
		color: [ :aTheme | aTheme surfaces constantAt: #cardBackground ]
		source: [ :aTheme | aTheme surfaces cardBackground ].
	separatorColor := self
		color: [ :aTheme | aTheme surfaces constantAt: #separatorColor ]
		source: [ :aTheme | aTheme surfaces separatorColor ]
]

{ #category : #accessing }
CgtSurfacesTheme >> separatorColor [ ^ separatorColor ]
