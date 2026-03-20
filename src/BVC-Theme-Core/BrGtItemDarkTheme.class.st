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
	selectedColor := colors sourceSelectionColor.
	deselectedColor := colors sidebarBackgroundColor.
	hoveredColor := colors sourceCurrentLineHighlightColor.
	defaultColor := colors sidebarBackgroundColor.
	focusedBorderColor := colors focusedEditorBorderColor.
	pressedColor := colors sourceSelectionColor
]
