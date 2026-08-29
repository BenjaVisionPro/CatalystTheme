Class {
	#name : #CgtItemSubTheme,
	#superclass : #BrGlamorousItemTheme,
	#instVars : [
		'theme'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #'instance creation' }
CgtItemSubTheme class >> theme: aTheme [
	^ self new
		theme: aTheme;
		yourself
]

{ #category : #accessing }
CgtItemSubTheme >> defaultColor [
	^ Color transparent
]

{ #category : #accessing }
CgtItemSubTheme >> deselectedColor [
	^ Color transparent
]

{ #category : #accessing }
CgtItemSubTheme >> focusedBorderColor [
	^ theme interaction focusedBorderColor
		blocResolveColorForTheme: theme
]

{ #category : #accessing }
CgtItemSubTheme >> hoveredColor [
	^ theme interaction hoveredBackgroundTint
		blocResolveColorForTheme: theme
]

{ #category : #accessing }
CgtItemSubTheme >> pressedColor [
	^ theme interaction pressedBackgroundTint
		blocResolveColorForTheme: theme
]

{ #category : #accessing }
CgtItemSubTheme >> selectedColor [
	^ theme appearanceState themeColour
]

{ #category : #accessing }
CgtItemSubTheme >> theme [
	^ theme
]

{ #category : #accessing }
CgtItemSubTheme >> theme: aTheme [
	theme := aTheme
]
