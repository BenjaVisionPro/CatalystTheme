Class {
	#name : #CgtDarkEditorTheme,
	#superclass : #BrGlamorousEditorDarkTheme,
	#category : #'BVC-Theme-Dark'
}

{ #category : #accessing }
CgtDarkEditorTheme >> defaultBackground [
	^ self theme interaction controlBackgroundTint
]

{ #category : #initialization }
CgtDarkEditorTheme >> initializeThemeable [
	super initializeThemeable.

	defaultTextForeground := self
		color: [ :aTheme | aTheme typography primaryForeground ]
		source: [ :aTheme | aTheme editor defaultTextForeground ].
	borderColor := Color transparent.
	focusedBorderColor := self
		color: [ :aTheme | aTheme themeState highlightColor alpha: 0.3 ]
		source: [ :aTheme | aTheme editor focusedBorderColor ]
]
