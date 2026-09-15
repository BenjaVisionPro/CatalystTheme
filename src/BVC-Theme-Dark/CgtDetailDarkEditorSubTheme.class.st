Class {
	#name : #CgtDetailDarkEditorSubTheme,
	#superclass : #BrGlamorousEditorDarkTheme,
	#category : #'BVC-Theme-Dark'
}

{ #category : #accessing }
CgtDetailDarkEditorSubTheme >> defaultBackground [
	^ Color white alpha: 0.08
]

{ #category : #initialization }
CgtDetailDarkEditorSubTheme >> initializeThemeable [
	super initializeThemeable.

	defaultTextForeground := self
		color: [ :aTheme | Color white ]
		source: [ :aTheme | aTheme editor defaultTextForeground ].
	borderColor := Color transparent.
	focusedBorderColor := self
		color: [ :aTheme | aTheme appearanceState themeColour alpha: 0.3 ]
		source: [ :aTheme | aTheme editor focusedBorderColor ]
]

{ #category : #accessing }
CgtDetailDarkEditorSubTheme >> textSelectionColor [
	^ self theme appearanceState effectiveTextSelectionColour
]
