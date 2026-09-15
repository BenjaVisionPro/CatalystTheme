Class {
	#name : #CgtGlamorousTagSubTheme, #superclass : #BlSubTheme, #category : #'BVC-Theme-GT'
}
{ #category : #accessing }
CgtGlamorousTagSubTheme >> background [ ^ self theme item defaultColor ]
{ #category : #accessing }
CgtGlamorousTagSubTheme >> hoveredBackground [ ^ self theme item hoveredColor ]
{ #category : #accessing }
CgtGlamorousTagSubTheme >> editorBackground [ ^ self theme default contentBackground ]
