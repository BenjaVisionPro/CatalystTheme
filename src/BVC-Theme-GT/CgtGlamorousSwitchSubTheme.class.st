Class {
	#name : #CgtGlamorousSwitchSubTheme, #superclass : #BlSubTheme, #category : #'BVC-Theme-GT'
}
{ #category : #accessing }
CgtGlamorousSwitchSubTheme >> inactiveTrackBackground [ ^ self theme button defaultBorderColor ]
{ #category : #accessing }
CgtGlamorousSwitchSubTheme >> activeTrackBackground [ ^ self theme item selectedColor ]
{ #category : #accessing }
CgtGlamorousSwitchSubTheme >> thumbBackground [ ^ self theme default contentBackground ]
