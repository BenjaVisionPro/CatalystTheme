Class {
	#name : #CgtGlamorousSliderSubTheme, #superclass : #BlSubTheme, #category : #'BVC-Theme-GT'
}
{ #category : #accessing }
CgtGlamorousSliderSubTheme >> trackBackground [ ^ self theme button defaultBorderColor ]
{ #category : #accessing }
CgtGlamorousSliderSubTheme >> activeTrackBackground [ ^ self theme item selectedColor ]
{ #category : #accessing }
CgtGlamorousSliderSubTheme >> thumbBackground [ ^ self theme default contentBackground ]
{ #category : #accessing }
CgtGlamorousSliderSubTheme >> thumbBorderColor [ ^ self theme button defaultBorderColor ]
{ #category : #accessing }
CgtGlamorousSliderSubTheme >> tickColor [ ^ self theme button defaultBorderColor ]
