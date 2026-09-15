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


{ #category : #private }
CgtItemSubTheme >> contrastTintColor [
	| aBackground aLuminance |
	aBackground := theme default contentBackground blocResolveColorForTheme: theme.
	aLuminance := (aBackground red * 0.2126)
		+ (aBackground green * 0.7152)
		+ (aBackground blue * 0.0722).
	^ aLuminance < 0.5 ifTrue: [ Color white ] ifFalse: [ Color black ]
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
	^ theme appearanceState themeColour alpha: 0.3
]

{ #category : #accessing }
CgtItemSubTheme >> hoveredColor [
	^ self contrastTintColor alpha: 0.12
]

{ #category : #accessing }
CgtItemSubTheme >> pressedColor [
	^ self contrastTintColor alpha: 0.16
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
