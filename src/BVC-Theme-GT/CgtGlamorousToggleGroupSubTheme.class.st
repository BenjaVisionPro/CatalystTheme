Class {
	#name : #CgtGlamorousToggleGroupSubTheme,
	#superclass : #BlSubTheme,
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtGlamorousToggleGroupSubTheme >> borderColor [
	^ self theme button defaultBorderColor
]

{ #category : #accessing }
CgtGlamorousToggleGroupSubTheme >> cornerRadius [
	^ 3
]

{ #category : #accessing }
CgtGlamorousToggleGroupSubTheme >> background [
	^ self contrastTintColorWithAlpha: 0.08
]

{ #category : #accessing }
CgtGlamorousToggleGroupSubTheme >> hoveredBackground [
	^ self contrastTintColorWithAlpha: 0.06
]

{ #category : #accessing }
CgtGlamorousToggleGroupSubTheme >> inactiveForeground [
	^ self contrastTintColorWithAlpha: 0.68
]

{ #category : #accessing }
CgtGlamorousToggleGroupSubTheme >> activeForeground [
	^ Color white
]

{ #category : #private }
CgtGlamorousToggleGroupSubTheme >> contrastTintColorWithAlpha: anAlpha [
	| aBackground aLuminance |
	aBackground := self theme default contentBackground blocResolveColorForTheme: self theme.
	aLuminance := (aBackground red * 0.2126)
		+ (aBackground green * 0.7152)
		+ (aBackground blue * 0.0722).
	^ (aLuminance < 0.5 ifTrue: [ Color white ] ifFalse: [ Color black ]) alpha: anAlpha
]
