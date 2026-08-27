Class {
	#name : #CgtGlamorousSurfacesTheme,
	#superclass : #BlSubTheme,
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtGlamorousSurfacesTheme >> baseBackground [
	^ self theme default contentBackground
]

{ #category : #accessing }
CgtGlamorousSurfacesTheme >> cardTint [
	^ self contrastTintColor alpha: 7.0 / 255.0
]

{ #category : #private }
CgtGlamorousSurfacesTheme >> contrastTintColor [
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
CgtGlamorousSurfacesTheme >> separatorTint [
	^ self contrastTintColor alpha: 19.0 / 248.0
]
