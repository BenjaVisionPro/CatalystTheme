Class {
	#name : #CgtControlsSubTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'sliderTrackTint',
		'sliderThumbBackground',
		'sliderThumbBorderTint',
		'sliderTickTint',
		'switchInactiveTrackTint',
		'switchThumbBackground',
		'inactiveIconForeground',
		'controlIndicatorForeground',
		'tagBackgroundTint',
		'tagEditorBackground'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #initialization }
CgtControlsSubTheme >> initializeThemeable [
	sliderTrackTint := self
		color: [ :aTheme | aTheme controls constantAt: #sliderTrackTint ]
		source: [ :aTheme | aTheme controls sliderTrackTint ].
	sliderThumbBackground := self
		color: [ :aTheme | aTheme controls constantAt: #sliderThumbBackground ]
		source: [ :aTheme | aTheme controls sliderThumbBackground ].
	sliderThumbBorderTint := self
		color: [ :aTheme | aTheme controls constantAt: #sliderThumbBorderTint ]
		source: [ :aTheme | aTheme controls sliderThumbBorderTint ].
	sliderTickTint := self
		color: [ :aTheme | aTheme controls constantAt: #sliderTickTint ]
		source: [ :aTheme | aTheme controls sliderTickTint ].
	switchInactiveTrackTint := self
		color: [ :aTheme | aTheme controls constantAt: #switchInactiveTrackTint ]
		source: [ :aTheme | aTheme controls switchInactiveTrackTint ].
	switchThumbBackground := self
		color: [ :aTheme | aTheme controls constantAt: #switchThumbBackground ]
		source: [ :aTheme | aTheme controls switchThumbBackground ].
	inactiveIconForeground := self
		color: [ :aTheme | aTheme controls constantAt: #inactiveIconForeground ]
		source: [ :aTheme | aTheme controls inactiveIconForeground ].
	controlIndicatorForeground := self
		color: [ :aTheme | aTheme controls constantAt: #controlIndicatorForeground ]
		source: [ :aTheme | aTheme controls controlIndicatorForeground ].
	tagBackgroundTint := self
		color: [ :aTheme | aTheme controls constantAt: #tagBackgroundTint ]
		source: [ :aTheme | aTheme controls tagBackgroundTint ].
	tagEditorBackground := self
		color: [ :aTheme | aTheme controls constantAt: #tagEditorBackground ]
		source: [ :aTheme | aTheme controls tagEditorBackground ]
]

{ #category : #accessing }
CgtControlsSubTheme >> sliderThumbBackground [ ^ sliderThumbBackground ]
{ #category : #accessing }
CgtControlsSubTheme >> sliderThumbBorderTint [ ^ sliderThumbBorderTint ]
{ #category : #accessing }
CgtControlsSubTheme >> sliderTickTint [ ^ sliderTickTint ]
{ #category : #accessing }
CgtControlsSubTheme >> sliderTrackTint [ ^ sliderTrackTint ]
{ #category : #accessing }
CgtControlsSubTheme >> switchInactiveTrackTint [ ^ switchInactiveTrackTint ]
{ #category : #accessing }
CgtControlsSubTheme >> switchThumbBackground [ ^ switchThumbBackground ]

{ #category : #accessing }
CgtControlsSubTheme >> inactiveIconForeground [ ^ inactiveIconForeground ]
{ #category : #accessing }
CgtControlsSubTheme >> controlIndicatorForeground [ ^ controlIndicatorForeground ]
{ #category : #accessing }
CgtControlsSubTheme >> tagBackgroundTint [ ^ tagBackgroundTint ]
{ #category : #accessing }
CgtControlsSubTheme >> tagEditorBackground [ ^ tagEditorBackground ]
