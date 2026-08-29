Class {
	#name : #CgtGlamorousInteractionSubTheme,
	#superclass : #BlSubTheme,
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtGlamorousInteractionSubTheme >> controlBackgroundTint [
	^ self contrastTintColor alpha: 0.08
]

{ #category : #private }
CgtGlamorousInteractionSubTheme >> contrastTintColor [
	| aBackground aLuminance |
	aBackground := self theme default contentBackground.
	aLuminance := (aBackground red * 0.2126)
		+ (aBackground green * 0.7152)
		+ (aBackground blue * 0.0722).
	^ aLuminance < 0.5
		ifTrue: [ Color white ]
		ifFalse: [ Color black ]
]


{ #category : #accessing }
CgtGlamorousInteractionSubTheme >> focusedBorderColor [
	^ self theme editor focusedBorderColor
]

{ #category : #accessing }
CgtGlamorousInteractionSubTheme >> hoveredBackgroundTint [
	^ self contrastTintColor alpha: 0.12
]

{ #category : #accessing }
CgtGlamorousInteractionSubTheme >> popupBackgroundTint [
	^ self contrastTintColor alpha: 0.10
]

{ #category : #accessing }
CgtGlamorousInteractionSubTheme >> pressedBackgroundTint [
	^ self contrastTintColor alpha: 0.16
]

{ #category : #accessing }
CgtGlamorousInteractionSubTheme >> subtleBackgroundTint [
	^ self contrastTintColor alpha: 0.06
]
