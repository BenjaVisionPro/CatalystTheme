Class {
	#name : #CgtGlamorousControlsSubTheme,
	#superclass : #BlSubTheme,
	#category : #'BVC-Theme-GT'
}

{ #category : #private }
CgtGlamorousControlsSubTheme >> contrastTintColor [
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
CgtGlamorousControlsSubTheme >> sliderTrackTint [ ^ self contrastTintColor alpha: 0.14 ]
{ #category : #accessing }
CgtGlamorousControlsSubTheme >> sliderActiveTrackTint [ ^ self theme item selectedColor ]
{ #category : #accessing }
CgtGlamorousControlsSubTheme >> sliderThumbBackground [ ^ self theme default contentBackground ]
{ #category : #accessing }
CgtGlamorousControlsSubTheme >> sliderThumbBorderTint [ ^ self contrastTintColor alpha: 0.16 ]
{ #category : #accessing }
CgtGlamorousControlsSubTheme >> sliderTickTint [ ^ self contrastTintColor alpha: 0.22 ]
{ #category : #accessing }
CgtGlamorousControlsSubTheme >> switchInactiveTrackTint [ ^ self contrastTintColor alpha: 35.0 / 255.0 ]
{ #category : #accessing }
CgtGlamorousControlsSubTheme >> switchActiveTrackTint [ ^ self theme item selectedColor ]
{ #category : #accessing }
CgtGlamorousControlsSubTheme >> switchThumbBackground [ ^ self theme default contentBackground ]

{ #category : #accessing }
CgtGlamorousControlsSubTheme >> inactiveIconForeground [ ^ self contrastTintColor alpha: 0.68 ]
{ #category : #accessing }
CgtGlamorousControlsSubTheme >> controlIndicatorForeground [ ^ self contrastTintColor alpha: 0.72 ]
{ #category : #accessing }
CgtGlamorousControlsSubTheme >> tagBackgroundTint [ ^ self contrastTintColor alpha: 0.06 ]
{ #category : #accessing }
CgtGlamorousControlsSubTheme >> tagEditorBackground [ ^ self theme default contentBackground ]
