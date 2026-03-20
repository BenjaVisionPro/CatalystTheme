Class {
	#name : #BrGtLabelLightTheme,
	#superclass : #BrGlamorousLabelTheme,
	#category : #'BVC-Theme-Core'
}

{ #category : #initialization }
BrGtLabelLightTheme >> initializeThemeable [
	super initializeThemeable.

	defaultTextForeground := self
			color: [ :aTheme | aTheme colors primaryTextColor ]
			source: [ :aTheme | aTheme label defaultTextForeground ].

	metadataTextForeground := self
			color: [ :aTheme | aTheme colors secondaryTextColor ]
			source: [ :aTheme | aTheme label metadataTextForeground ].

	summaryTextForeground := self
			color: [ :aTheme | aTheme colors tertiaryTextColor ]
			source: [ :aTheme | aTheme label summaryTextForeground ].

	navigationTextForeground := self
			color: [ :aTheme | aTheme colors tabTextColor ]
			source: [ :aTheme | aTheme label navigationTextForeground ]
]
