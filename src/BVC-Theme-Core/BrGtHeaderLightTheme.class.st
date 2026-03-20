Class {
	#name : #BrGtHeaderLightTheme,
	#superclass : #BrGlamorousHeaderLightTheme,
	#category : #'BVC-Theme-Core'
}

{ #category : #initialization }
BrGtHeaderLightTheme >> initializeThemeable [
	super initializeThemeable.
	textMarkupColor := self
			color: [ :aTheme | aTheme colors headerTextMarkupColor ]
			source: [ :aTheme | aTheme header textMarkupColor ].
	defaultBackgroundColor := self
			color: [ :aTheme | aTheme colors headerBackgroundColor ]
			source: [ :aTheme | aTheme header defaultBackgroundColor ].
	disabledTextColor := self
			color: [ :aTheme | aTheme colors headerDisabledTextColor ]
			source: [ :aTheme | aTheme header disabledTextColor ].
	defaultTextColor := self
			color: [ :aTheme | aTheme colors headerTextColor ]
			source: [ :aTheme | aTheme header defaultTextColor ].
	secondaryBackgroundColor := self
			color: [ :aTheme | aTheme colors headerSecondaryBackgroundColor ]
			source: [ :aTheme | aTheme header secondaryBackgroundColor ].
	defaultBackground := self
			background: [ :aTheme | aTheme colors headerBackgroundColor ]
			source: [ :aTheme | aTheme header defaultBackground ]
]
