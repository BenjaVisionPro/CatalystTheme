Class {
	#name : #CgtMenuTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'background',
		'borderColor',
		'shadowColor'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtMenuTheme >> background [
	^ background
]

{ #category : #accessing }
CgtMenuTheme >> borderColor [
	^ borderColor
]

{ #category : #accessing }
CgtMenuTheme >> cornerRadius [
	^ 12
]

{ #category : #accessing }
CgtMenuTheme >> contentInset [
	^ 5
]

{ #category : #accessing }
CgtMenuTheme >> itemCornerRadius [
	^ self cornerRadius - self contentInset
]

{ #category : #initialization }
CgtMenuTheme >> initializeThemeable [
	background := self
		color: [ :aTheme |
			aTheme surfaces baseBackground
				blocResolveColorForTheme: aTheme ]
		source: [ :aTheme | aTheme menu background ].
	borderColor := self
		color: [ :aTheme |
			aTheme interaction pressedBackgroundTint
				blocResolveColorForTheme: aTheme ]
		source: [ :aTheme | aTheme menu borderColor ].
	shadowColor := self
		color: [ :aTheme | Color black alpha: 0.3 ]
		source: [ :aTheme | aTheme menu shadowColor ]
]

{ #category : #accessing }
CgtMenuTheme >> shadowColor [
	^ shadowColor
]

{ #category : #accessing }
CgtMenuTheme >> shadowOffset [
	^ 0 @ 1
]

{ #category : #accessing }
CgtMenuTheme >> shadowWidth [
	^ 2
]
