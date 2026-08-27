Class {
	#name : #CgtGlamorousSurfacesTheme,
	#superclass : #BlSubTheme,
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtGlamorousSurfacesTheme >> cardBackground [
	^ self theme default contentBackground
]

{ #category : #accessing }
CgtGlamorousSurfacesTheme >> formBackground [
	^ self theme default contentBackground
]

{ #category : #accessing }
CgtGlamorousSurfacesTheme >> separatorColor [
	^ self theme colors tertiaryTextColor
]
