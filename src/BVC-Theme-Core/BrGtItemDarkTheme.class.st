Class {
	#name : #BrGtItemDarkTheme,
	#superclass : #BrGlamorousItemTheme,
	#instVars : [
		'theme',
		'colors'
	],
	#category : #'BVC-Theme-Core'
}

{ #category : #'instance creation' }
BrGtItemDarkTheme class >> colors: aColors theme: aTheme [
	^ self basicNew
		colors: aColors;
		theme: aTheme;
		initializeFromColors;
		yourself
]

{ #category : #accessing }
BrGtItemDarkTheme >> colors [
	^ colors
]

{ #category : #accessing }
BrGtItemDarkTheme >> colors: aColors [
	colors := aColors
]

{ #category : #accessing }
BrGtItemDarkTheme >> theme [
	^ theme
]

{ #category : #accessing }
BrGtItemDarkTheme >> theme: aTheme [
	theme := aTheme
]

{ #category : #initialization }
BrGtItemDarkTheme >> initializeFromColors [
	selectedColor := colors itemSelectedBackgroundColor.
	deselectedColor := colors itemDeselectedBackgroundColor.
	hoveredColor := colors itemHoveredBackgroundColor.
	defaultColor := colors itemBackgroundColor.
	focusedBorderColor := colors itemFocusedBorderColor.
	pressedColor := colors itemPressedBackgroundColor
]
