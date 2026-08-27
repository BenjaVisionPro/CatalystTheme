Class {
	#name : #CgtInteractionTheme,
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
CgtInteractionTheme >> controlBackgroundTint [ ^ controlBackgroundTint ]

{ #category : #accessing }
CgtInteractionTheme >> hoveredBackgroundTint [ ^ hoveredBackgroundTint ]

{ #category : #accessing }
CgtInteractionTheme >> focusedBorderColor [ ^ focusedBorderColor ]

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
		source: [ :aTheme | aTheme interaction pressedBackgroundTint ].
	focusedBorderColor := self
		color: [ :aTheme | aTheme themeState highlightColor alpha: 0.3 ]
		source: [ :aTheme | aTheme interaction focusedBorderColor ]
]

{ #category : #accessing }
CgtInteractionTheme >> popupBackgroundTint [ ^ popupBackgroundTint ]

{ #category : #accessing }
CgtInteractionTheme >> pressedBackgroundTint [ ^ pressedBackgroundTint ]

{ #category : #accessing }
CgtInteractionTheme >> subtleBackgroundTint [ ^ subtleBackgroundTint ]
