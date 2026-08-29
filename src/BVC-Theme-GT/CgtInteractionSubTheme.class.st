Class {
	#name : #CgtInteractionSubTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'subtleBackgroundTint',
		'controlBackgroundTint',
		'popupBackgroundTint',
		'hoveredBackgroundTint',
		'pressedBackgroundTint',
		'focusedBorderColor'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtInteractionSubTheme >> controlBackgroundTint [ ^ controlBackgroundTint ]

{ #category : #accessing }
CgtInteractionSubTheme >> hoveredBackgroundTint [ ^ hoveredBackgroundTint ]

{ #category : #accessing }
CgtInteractionSubTheme >> focusedBorderColor [ ^ focusedBorderColor ]

{ #category : #initialization }
CgtInteractionSubTheme >> initializeThemeable [
	subtleBackgroundTint := self
		color: [ :aTheme | aTheme interaction constantAt: #subtleBackgroundTint ]
		source: [ :aTheme | aTheme interaction subtleBackgroundTint ].
	controlBackgroundTint := self
		color: [ :aTheme | aTheme interaction constantAt: #controlBackgroundTint ]
		source: [ :aTheme | aTheme interaction controlBackgroundTint ].
	popupBackgroundTint := self
		color: [ :aTheme | aTheme interaction constantAt: #popupBackgroundTint ]
		source: [ :aTheme | aTheme interaction popupBackgroundTint ].
	hoveredBackgroundTint := self
		color: [ :aTheme | aTheme interaction constantAt: #hoveredBackgroundTint ]
		source: [ :aTheme | aTheme interaction hoveredBackgroundTint ].
	pressedBackgroundTint := self
		color: [ :aTheme | aTheme interaction constantAt: #pressedBackgroundTint ]
		source: [ :aTheme | aTheme interaction pressedBackgroundTint ].
	focusedBorderColor := self
		color: [ :aTheme | aTheme appearanceState themeColour alpha: 0.3 ]
		source: [ :aTheme | aTheme interaction focusedBorderColor ]
]

{ #category : #accessing }
CgtInteractionSubTheme >> popupBackgroundTint [ ^ popupBackgroundTint ]

{ #category : #accessing }
CgtInteractionSubTheme >> pressedBackgroundTint [ ^ pressedBackgroundTint ]

{ #category : #accessing }
CgtInteractionSubTheme >> subtleBackgroundTint [ ^ subtleBackgroundTint ]
