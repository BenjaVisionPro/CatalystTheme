Class {
	#name : #CgtGlamorousInteractionTheme,
	#superclass : #BlSubTheme,
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtGlamorousInteractionTheme >> controlBackgroundTint [
	^ self contrastTintColor alpha: 0.08
]

{ #category : #private }
CgtGlamorousInteractionTheme >> contrastTintColor [
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
CgtGlamorousInteractionTheme >> hoveredBackgroundTint [
	^ self contrastTintColor alpha: 0.12
]

{ #category : #accessing }
CgtGlamorousInteractionTheme >> popupBackgroundTint [
	^ self contrastTintColor alpha: 0.10
]

{ #category : #accessing }
CgtGlamorousInteractionTheme >> pressedBackgroundTint [
	^ self contrastTintColor alpha: 0.16
]

{ #category : #accessing }
CgtGlamorousInteractionTheme >> subtleBackgroundTint [
	^ self contrastTintColor alpha: 0.06
]
