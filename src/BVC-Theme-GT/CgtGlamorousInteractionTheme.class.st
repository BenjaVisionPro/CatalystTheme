Class {
	#name : #CgtGlamorousInteractionTheme,
	#superclass : #CgtInteractionTheme,
	#category : #'BVC-Theme-GT'
}

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

{ #category : #initialization }
CgtGlamorousInteractionTheme >> initializeConstants [
	| aTint |
	super initializeConstants.
	aTint := self contrastTintColor.
	self
		constantAt: #subtleBackgroundTint put: (aTint alpha: 0.06);
		constantAt: #controlBackgroundTint put: (aTint alpha: 0.08);
		constantAt: #popupBackgroundTint put: (aTint alpha: 0.10);
		constantAt: #hoveredBackgroundTint put: (aTint alpha: 0.12);
		constantAt: #pressedBackgroundTint put: (aTint alpha: 0.16)
]
