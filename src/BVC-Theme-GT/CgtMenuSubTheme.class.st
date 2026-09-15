Class {
	#name : #CgtMenuSubTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'background',
		'borderColor',
		'shadowColor'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtMenuSubTheme >> background [
	^ background
]

{ #category : #accessing }
CgtMenuSubTheme >> borderColor [
	^ borderColor
]

{ #category : #accessing }
CgtMenuSubTheme >> cornerRadius [
	^ 12
]

{ #category : #accessing }
CgtMenuSubTheme >> contentInset [
	^ 5
]

{ #category : #accessing }
CgtMenuSubTheme >> itemCornerRadius [
	^ self cornerRadius - self contentInset
]

{ #category : #initialization }
CgtMenuSubTheme >> initializeThemeable [
	background := self
		color: [ :aTheme | aTheme default contentBackground ]
		source: [ :aTheme | aTheme menu background ].
	borderColor := self
		color: [ :aTheme |
			self contrastTintColorFor: aTheme alpha: 0.16 ]
		source: [ :aTheme | aTheme menu borderColor ].
	shadowColor := self
		color: [ :aTheme | Color black alpha: 0.3 ]
		source: [ :aTheme | aTheme menu shadowColor ]
]


{ #category : #private }
CgtMenuSubTheme >> contrastTintColorFor: aTheme alpha: anAlpha [
	| aBackground aLuminance |
	aBackground := aTheme default contentBackground blocResolveColorForTheme: aTheme.
	aLuminance := (aBackground red * 0.2126)
		+ (aBackground green * 0.7152)
		+ (aBackground blue * 0.0722).
	^ (aLuminance < 0.5 ifTrue: [ Color white ] ifFalse: [ Color black ]) alpha: anAlpha
]

{ #category : #accessing }
CgtMenuSubTheme >> shadowColor [
	^ shadowColor
]

{ #category : #accessing }
CgtMenuSubTheme >> shadowOffset [
	^ 0 @ 1
]

{ #category : #accessing }
CgtMenuSubTheme >> shadowWidth [
	^ 2
]
