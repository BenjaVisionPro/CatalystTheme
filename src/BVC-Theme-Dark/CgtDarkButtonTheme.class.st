Class {
	#name : #CgtDarkButtonTheme,
	#superclass : #BrGlamorousButtonDarkTheme,
	#category : #'BVC-Theme-Dark'
}

{ #category : #initialization }
CgtDarkButtonTheme >> initializeThemeable [
	super initializeThemeable.

	defaultBackground := self
		color: [ :aTheme | aTheme interaction controlBackgroundTint ]
		source: [ :aTheme | aTheme button defaultBackground ].
	disabledBackgroundColor := self
		color: [ :aTheme | aTheme interaction subtleBackgroundTint ]
		source: [ :aTheme | aTheme button disabledBackgroundColor ].
	defaultTextForeground := self
		color: [ :aTheme | aTheme typography primaryForeground ]
		source: [ :aTheme | aTheme button defaultTextForeground ].
	disabledTextColor := self
		color: [ :aTheme | aTheme typography disabledForeground ]
		source: [ :aTheme | aTheme button disabledTextColor ].
	hoveredTextColor := self
		color: [ :aTheme | aTheme typography primaryForeground ]
		source: [ :aTheme | aTheme button hoveredTextColor ].
	pressedTextColor := self
		color: [ :aTheme | aTheme typography primaryForeground ]
		source: [ :aTheme | aTheme button pressedTextColor ].

	defaultBorderColor := Color transparent.
	disabledBorderColor := Color transparent.
	hoveredBorderColor := self
		color: [ :aTheme | aTheme interaction hoveredBackgroundTint ]
		source: [ :aTheme | aTheme button hoveredBorderColor ].
	pressedBorderColor := self
		color: [ :aTheme | aTheme interaction pressedBackgroundTint ]
		source: [ :aTheme | aTheme button pressedBorderColor ]
]
