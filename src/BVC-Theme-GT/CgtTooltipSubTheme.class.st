Class {
	#name : #CgtTooltipSubTheme,
	#superclass : #BlSubTheme,
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtTooltipSubTheme >> borderColor [
	^ self theme interaction pressedBackgroundTint
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
