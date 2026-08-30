Class {
	#name : #CgtTooltipSubTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'borderColor'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtTooltipSubTheme >> borderColor [
	^ borderColor
]

{ #category : #accessing }
CgtTooltipSubTheme >> cornerRadius [
	^ self theme menu cornerRadius
]

{ #category : #accessing }
CgtTooltipSubTheme >> foreground [
	^ self theme typography primaryForeground
]

{ #category : #accessing }
CgtTooltipSubTheme >> fontSize [
	^ self theme typography bodyFontSize
]

{ #category : #initialization }
CgtTooltipSubTheme >> initializeThemeable [
	borderColor := self
		color: [ :aTheme |
			aTheme interaction pressedBackgroundTint
				blocResolveColorForTheme: aTheme ]
		source: [ :aTheme | aTheme tooltip borderColor ]
]
