Class {
	#name : #CgtLightEditorTheme,
	#superclass : #BrGlamorousEditorLightTheme,
	#category : #'BVC-Theme-Light'
}

{ #category : #accessing }
CgtLightEditorTheme >> defaultBackground [
	^ self theme interaction controlBackgroundTint
]

{ #category : #initialization }
CgtLightEditorTheme >> initializeThemeable [
	super initializeThemeable.

	defaultTextForeground := self
		color: [ :aTheme | aTheme typography primaryForeground ]
		source: [ :aTheme | aTheme editor defaultTextForeground ].
	borderColor := Color transparent.
	focusedBorderColor := self
		color: [ :aTheme | aTheme themeState highlightColor alpha: 0.3 ]
		source: [ :aTheme | aTheme editor focusedBorderColor ]
]
