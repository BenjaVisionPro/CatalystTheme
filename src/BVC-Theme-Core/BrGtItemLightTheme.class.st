Class {
	#name : #BrGtItemLightTheme,
	#superclass : #BrGlamorousItemTheme,
	#instVars : [
		'theme',
		'colors'
	],
	#category : #'BVC-Theme-Core'
}

{ #category : #'instance creation' }
#BrGtItemLightTheme class >> colors: aColors theme: aTheme [
	^ self basicNew
		colors: aColors;
		theme: aTheme;
		initializeFromColors;
		yourself
]

{ #category : #accessing }
#BrGtItemLightTheme >> colors [
	^ colors
]

{ #category : #accessing }
#BrGtItemLightTheme >> colors: aColors [
	colors := aColors
]

{ #category : #accessing }
#BrGtItemLightTheme >> theme [
	^ theme
]

{ #category : #accessing }
#BrGtItemLightTheme >> theme: aTheme [
	theme := aTheme
]

{ #category : #initialization }
#BrGtItemLightTheme >> initializeFromColors [
	selectedColor := colors itemSelectedBackgroundColor.
	deselectedColor := colors itemDeselectedBackgroundColor.
	hoveredColor := colors itemHoveredBackgroundColor.
	defaultColor := colors itemBackgroundColor.
	focusedBorderColor := colors itemFocusedBorderColor.
	pressedColor := colors itemPressedBackgroundColor
]
