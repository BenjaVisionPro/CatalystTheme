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
	^ self theme typography tertiaryForeground
]

{ #category : #accessing }
CgtTooltipSubTheme >> fontSize [
	^ self theme typography supportingFontSize
]

{ #category : #initialization }
CgtTooltipSubTheme >> initializeThemeable [
	borderColor := self
		color: [ :aTheme |
			aTheme interaction pressedBackgroundTint
				blocResolveColorForTheme: aTheme ]
		source: [ :aTheme | aTheme tooltip borderColor ]
]

{ #category : #accessing }
CgtTooltipSubTheme >> shadowColor [
	^ self theme menu shadowColor
]

{ #category : #accessing }
CgtTooltipSubTheme >> shadowOffset [
	^ self theme menu shadowOffset
]

{ #category : #accessing }
CgtTooltipSubTheme >> shadowWidth [
	^ self theme menu shadowWidth
]
