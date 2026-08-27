Class {
	#name : #CgtItemTheme,
	#superclass : #BrGlamorousItemTheme,
	#instVars : [
		'theme'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #'instance creation' }
CgtItemTheme class >> theme: aTheme [
	^ self new
		theme: aTheme;
		yourself
]

{ #category : #accessing }
CgtItemTheme >> defaultColor [
	^ Color transparent
]

{ #category : #accessing }
CgtItemTheme >> deselectedColor [
	^ Color transparent
]

{ #category : #accessing }
CgtItemTheme >> focusedBorderColor [
	^ theme interaction focusedBorderColor
		blocResolveColorForTheme: theme
]

{ #category : #accessing }
CgtItemTheme >> hoveredColor [
	^ theme interaction hoveredBackgroundTint
		blocResolveColorForTheme: theme
]

{ #category : #accessing }
CgtItemTheme >> pressedColor [
	^ theme interaction pressedBackgroundTint
		blocResolveColorForTheme: theme
]

{ #category : #accessing }
CgtItemTheme >> selectedColor [
	^ theme highlight color
		blocResolveColorForTheme: theme
]

{ #category : #accessing }
CgtItemTheme >> theme [
	^ theme
]

{ #category : #accessing }
CgtItemTheme >> theme: aTheme [
	theme := aTheme
]
