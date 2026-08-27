Class {
	#name : #CgtInteractionTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'subtleBackgroundTint',
		'controlBackgroundTint',
		'popupBackgroundTint',
		'hoveredBackgroundTint',
		'pressedBackgroundTint'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtInteractionTheme >> controlBackgroundTint [ ^ controlBackgroundTint ]

{ #category : #accessing }
CgtInteractionTheme >> hoveredBackgroundTint [ ^ hoveredBackgroundTint ]

{ #category : #initialization }
CgtInteractionTheme >> initializeThemeable [
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
		source: [ :aTheme | aTheme interaction pressedBackgroundTint ]
]

{ #category : #accessing }
CgtInteractionTheme >> popupBackgroundTint [ ^ popupBackgroundTint ]

{ #category : #accessing }
CgtInteractionTheme >> pressedBackgroundTint [ ^ pressedBackgroundTint ]

{ #category : #accessing }
CgtInteractionTheme >> subtleBackgroundTint [ ^ subtleBackgroundTint ]
