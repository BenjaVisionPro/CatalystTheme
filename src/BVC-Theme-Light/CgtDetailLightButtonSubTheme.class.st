Class {
	#name : #CgtDetailLightButtonSubTheme,
	#superclass : #BrGlamorousButtonLightTheme,
	#category : #'BVC-Theme-Light'
}

{ #category : #initialization }
CgtDetailLightButtonSubTheme >> initializeThemeable [
	super initializeThemeable.

	defaultBackground := self
		color: [ :aTheme | Color black alpha: 0.08 ]
		source: [ :aTheme | aTheme button defaultBackground ].
	disabledBackgroundColor := self
		color: [ :aTheme | Color black alpha: 0.06 ]
		source: [ :aTheme | aTheme button disabledBackgroundColor ].
	defaultTextForeground := self
		color: [ :aTheme | Color black ]
		source: [ :aTheme | aTheme button defaultTextForeground ].
	disabledTextColor := self
		color: [ :aTheme | (Color black alpha: 0.22) ]
		source: [ :aTheme | aTheme button disabledTextColor ].
	hoveredTextColor := self
		color: [ :aTheme | Color black ]
		source: [ :aTheme | aTheme button hoveredTextColor ].
	pressedTextColor := self
		color: [ :aTheme | Color black ]
		source: [ :aTheme | aTheme button pressedTextColor ].

	defaultBorderColor := Color transparent.
	disabledBorderColor := Color transparent.
	hoveredBorderColor := self
		color: [ :aTheme | Color black alpha: 0.12 ]
		source: [ :aTheme | aTheme button hoveredBorderColor ].
	pressedBorderColor := self
		color: [ :aTheme | Color black alpha: 0.16 ]
		source: [ :aTheme | aTheme button pressedBorderColor ]
]
