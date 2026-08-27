Class {
	#name : #CgtGlamorousControlsTheme,
	#superclass : #BlSubTheme,
	#category : #'BVC-Theme-GT'
}

{ #category : #private }
CgtGlamorousControlsTheme >> contrastTintColor [
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
CgtGlamorousControlsTheme >> sliderTrackTint [ ^ self contrastTintColor alpha: 0.14 ]
{ #category : #accessing }
CgtGlamorousControlsTheme >> sliderThumbBackground [ ^ self theme default contentBackground ]
{ #category : #accessing }
CgtGlamorousControlsTheme >> sliderThumbBorderTint [ ^ self contrastTintColor alpha: 0.16 ]
{ #category : #accessing }
CgtGlamorousControlsTheme >> sliderTickTint [ ^ self contrastTintColor alpha: 0.22 ]
{ #category : #accessing }
CgtGlamorousControlsTheme >> switchInactiveTrackTint [ ^ self contrastTintColor alpha: 35.0 / 255.0 ]
{ #category : #accessing }
CgtGlamorousControlsTheme >> switchThumbBackground [ ^ self theme default contentBackground ]

{ #category : #accessing }
CgtGlamorousControlsTheme >> inactiveIconForeground [ ^ self contrastTintColor alpha: 0.68 ]
{ #category : #accessing }
CgtGlamorousControlsTheme >> controlIndicatorForeground [ ^ self contrastTintColor alpha: 0.72 ]
{ #category : #accessing }
CgtGlamorousControlsTheme >> tagBackgroundTint [ ^ self contrastTintColor alpha: 0.06 ]
{ #category : #accessing }
CgtGlamorousControlsTheme >> tagEditorBackground [ ^ self theme default contentBackground ]
