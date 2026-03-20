Class {
	#name : #BrGtButtonLightTheme,
	#superclass : #BrGlamorousButtonTheme,
	#category : #'BVC-Theme-Core'
}

{ #category : #initialization }
BrGtButtonLightTheme >> initialize [
	super initialize.
	disabledBackgroundColor := Color transparent.
	disabledTextColor := Color transparent.
	disabledBorderColor := Color transparent.
	defaultBorderColor := Color transparent.
	defaultTextColor := Color transparent.
	pressedBorderColor := Color transparent.
	hoveredBorderColor := Color transparent.
	pressedTextColor := Color transparent.
	hoveredTextColor := Color transparent.
	textHighlightColor := Color transparent.
	fadedBackgroundColor := Color transparent.
	focusedFadedBackgroundColor := Color transparent
]

{ #category : #initialization }
BrGtButtonLightTheme >> initializeThemeable [
	super initializeThemeable.

	disabledBackgroundColor := self
			color: [ :aTheme | aTheme colors buttonDisabledBackgroundColor ]
			source: [ :aTheme | aTheme button disabledBackgroundColor ].
	disabledTextColor := self
			color: [ :aTheme | aTheme colors buttonDisabledTextColor ]
			source: [ :aTheme | aTheme button disabledTextColor ].
	disabledBorderColor := self
			color: [ :aTheme | aTheme colors buttonDisabledBorderColor ]
			source: [ :aTheme | aTheme button disabledBorderColor ].
	defaultBorderColor := self
			color: [ :aTheme | aTheme colors buttonDefaultBorderColor ]
			source: [ :aTheme | aTheme button defaultBorderColor ].
	defaultTextColor := self
			color: [ :aTheme | aTheme colors buttonDefaultTextColor ]
			source: [ :aTheme | aTheme button defaultTextColor ].
	pressedBorderColor := self
			color: [ :aTheme | aTheme colors buttonPressedBorderColor ]
			source: [ :aTheme | aTheme button pressedBorderColor ].
	hoveredBorderColor := self
			color: [ :aTheme | aTheme colors buttonHoveredBorderColor ]
			source: [ :aTheme | aTheme button hoveredBorderColor ].
	pressedTextColor := self
			color: [ :aTheme | aTheme colors buttonPressedTextColor ]
			source: [ :aTheme | aTheme button pressedTextColor ].
	hoveredTextColor := self
			color: [ :aTheme | aTheme colors buttonHoveredTextColor ]
			source: [ :aTheme | aTheme button hoveredTextColor ].
	textHighlightColor := self
			color: [ :aTheme | aTheme colors buttonTextHighlightColor ]
			source: [ :aTheme | aTheme button textHighlightColor ].
	fadedBackgroundColor := self
			color: [ :aTheme | aTheme colors buttonFadedBackgroundColor ]
			source: [ :aTheme | aTheme button fadedBackgroundColor ].
	focusedFadedBackgroundColor := self
			color: [ :aTheme | aTheme colors buttonFocusedFadedBackgroundColor ]
			source: [ :aTheme | aTheme button focusedFadedBackgroundColor ].
	defaultBackground := self
			color: [ :aTheme | aTheme colors buttonDefaultBackgroundColor ]
			source: [ :aTheme | aTheme button defaultBackground ].
	defaultTextForeground := self
			color: [ :aTheme | aTheme colors buttonDefaultTextColor ]
			source: [ :aTheme | aTheme button defaultTextForeground ]
]
