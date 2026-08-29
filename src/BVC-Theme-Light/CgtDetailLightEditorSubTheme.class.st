Class {
	#name : #CgtDetailLightEditorSubTheme,
	#superclass : #BrGlamorousEditorLightTheme,
	#category : #'BVC-Theme-Light'
}

{ #category : #accessing }
CgtDetailLightEditorSubTheme >> defaultBackground [
	^ self theme interaction controlBackgroundTint
]

{ #category : #initialization }
CgtDetailLightEditorSubTheme >> initializeThemeable [
	super initializeThemeable.

	defaultTextForeground := self
		color: [ :aTheme | aTheme typography primaryForeground ]
		source: [ :aTheme | aTheme editor defaultTextForeground ].
	borderColor := Color transparent.
	focusedBorderColor := self
		color: [ :aTheme | aTheme appearanceState themeColour alpha: 0.3 ]
		source: [ :aTheme | aTheme editor focusedBorderColor ]
]

{ #category : #accessing }
CgtDetailLightEditorSubTheme >> textSelectionColor [
	^ self theme appearanceState textSelectionColour
]
