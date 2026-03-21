Class {
	#name : #CgtAbstractItemTheme,
	#superclass : #Object,
	#instVars : [
		'theme'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #'instance creation' }
CgtAbstractItemTheme class >> theme: aTheme [
	^ self new
		theme: aTheme;
		yourself
]

{ #category : #accessing }
CgtAbstractItemTheme >> defaultColor [
	^ self uiColorRoleNamed: #itemBackground
		fallback: [ Color transparent ]
]

{ #category : #accessing }
CgtAbstractItemTheme >> deselectedColor [
	^ self defaultColor
]

{ #category : #accessing }
CgtAbstractItemTheme >> focusedBorderColor [
	^ self uiColorRoleNamed: #borderFocus
		fallback: [ Color transparent ]
]

{ #category : #accessing }
CgtAbstractItemTheme >> hoveredColor [
	^ self uiColorRoleNamed: #itemBackgroundHovered
		fallback: [ self defaultColor ]
]

{ #category : #initialization }
CgtAbstractItemTheme >> initialize [
	super initialize
]

{ #category : #initialization }
CgtAbstractItemTheme >> initializeThemeable [
	"Phase 1/2 hook. Kept explicit so item participates in theme refresh."
]

{ #category : #accessing }
CgtAbstractItemTheme >> pressedColor [
	^ self uiColorRoleNamed: #itemBackgroundSelected
		fallback: [ self selectedColor ]
]

{ #category : #accessing }
CgtAbstractItemTheme >> selectedColor [
	^ self uiColorRoleNamed: #itemBackgroundSelected
		fallback: [ self defaultColor ]
]

{ #category : #accessing }
CgtAbstractItemTheme >> theme [
	^ theme
]

{ #category : #accessing }
CgtAbstractItemTheme >> theme: aTheme [
	theme := aTheme
]

{ #category : #private }
CgtAbstractItemTheme >> uiColorRoleNamed: aRoleName fallback: aBlock [
	(theme notNil and: [ theme uiPalette notNil and: [ theme uiPalette hasValueForRoleNamed: aRoleName ] ])
		ifTrue: [ ^ theme uiPalette valueForRoleNamed: aRoleName ].
	^ aBlock value
]
