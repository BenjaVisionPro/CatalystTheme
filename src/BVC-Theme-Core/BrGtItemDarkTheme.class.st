Class {
	#name : #BrGtItemDarkTheme,
	#superclass : #BrGlamorousItemTheme,
	#instVars : [
		'theme'
	],
	#category : #'BVC-Theme-Core'
}

{ #category : #'instance creation' }
BrGtItemDarkTheme class >> theme: aTheme [
	^ self basicNew
		theme: aTheme;
		initializeFromTheme;
		yourself
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
BrGtItemDarkTheme >> initializeFromTheme [
	selectedColor := theme colors sourceSelectionColor.
	deselectedColor := theme colors sidebarBackgroundColor.
	hoveredColor := theme colors sourceCurrentLineHighlightColor.
	defaultColor := theme colors sidebarBackgroundColor.
	focusedBorderColor := theme colors focusedEditorBorderColor.
	pressedColor := theme colors sourceSelectionColor
]
