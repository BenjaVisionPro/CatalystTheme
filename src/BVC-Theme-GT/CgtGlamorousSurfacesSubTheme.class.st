Class {
	#name : #CgtGlamorousSurfacesSubTheme,
	#superclass : #BlSubTheme,
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtGlamorousSurfacesSubTheme >> baseBackground [
	^ self theme default contentBackground
]

{ #category : #accessing }
CgtGlamorousSurfacesSubTheme >> cardTint [
	^ self contrastTintColor alpha: 7.0 / 255.0
]

{ #category : #private }
CgtGlamorousSurfacesSubTheme >> contrastTintColor [
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
CgtGlamorousSurfacesSubTheme >> separatorTint [
	^ self contrastTintColor alpha: 19.0 / 248.0
]
