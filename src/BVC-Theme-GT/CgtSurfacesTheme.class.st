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
		source: [ :aTheme | (aTheme respondsTo: #surfaces) ifTrue: [ aTheme surfaces formBackground ] ifFalse: [ aTheme colors contentBackgroundColor ] ].
	cardBackground := self
		color: [ :aTheme | aTheme surfaces constantAt: #cardBackground ]
		source: [ :aTheme | (aTheme respondsTo: #surfaces) ifTrue: [ aTheme surfaces cardBackground ] ifFalse: [ aTheme colors contentBackgroundColor ] ].
	separatorColor := self
		color: [ :aTheme | aTheme surfaces constantAt: #separatorColor ]
		source: [ :aTheme | (aTheme respondsTo: #surfaces) ifTrue: [ aTheme surfaces separatorColor ] ifFalse: [ aTheme colors tertiaryTextColor ] ]
]

{ #category : #accessing }
CgtSurfacesTheme >> separatorColor [ ^ separatorColor ]
