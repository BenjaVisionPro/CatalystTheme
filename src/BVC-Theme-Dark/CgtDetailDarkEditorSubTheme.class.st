Class {
	#name : #CgtDetailDarkEditorSubTheme,
	#superclass : #BrGlamorousEditorDarkTheme,
	#category : #'BVC-Theme-Dark'
}

{ #category : #accessing }
CgtDetailDarkEditorSubTheme >> defaultBackground [
	^ self theme interaction controlBackgroundTint
]

{ #category : #initialization }
CgtDetailDarkEditorSubTheme >> initializeThemeable [
	super initializeThemeable.

	defaultTextForeground := self
		color: [ :aTheme | aTheme typography primaryForeground ]
		source: [ :aTheme | aTheme editor defaultTextForeground ].
	borderColor := Color transparent.
	focusedBorderColor := self
		color: [ :aTheme | aTheme appearanceState themeColour alpha: 0.3 ]
		source: [ :aTheme | aTheme editor focusedBorderColor ]
]
