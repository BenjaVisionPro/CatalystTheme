Class {
	#name : #BrGtItemLightTheme,
	#superclass : #BrGlamorousItemTheme,
	#instVars : [
		'theme'
	],
	#category : #'BVC-Theme-Core'
}

{ #category : #'instance creation' }
BrGtItemLightTheme class >> theme: aTheme [
	^ self basicNew
		theme: aTheme;
		initializeFromTheme;
		yourself
]

{ #category : #accessing }
BrGtItemLightTheme >> theme [
	^ theme
]

{ #category : #accessing }
BrGtItemLightTheme >> theme: aTheme [
	theme := aTheme
]

{ #category : #initialization }
BrGtItemLightTheme >> initializeFromTheme [
	selectedColor := theme colors sourceSelectionColor.
	deselectedColor := theme colors sidebarBackgroundColor.
	hoveredColor := theme colors sourceCurrentLineHighlightColor.
	defaultColor := theme colors sidebarBackgroundColor.
	focusedBorderColor := theme colors focusedEditorBorderColor.
	pressedColor := theme colors sourceSelectionColor
]
