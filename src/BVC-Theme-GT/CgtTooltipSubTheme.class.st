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

{ #category : #initialization }
CgtTooltipSubTheme >> initializeThemeable [
	borderColor := self
		color: [ :aTheme |
			aTheme interaction pressedBackgroundTint
				blocResolveColorForTheme: aTheme ]
		source: [ :aTheme | aTheme tooltip borderColor ]
]
