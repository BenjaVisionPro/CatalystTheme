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
