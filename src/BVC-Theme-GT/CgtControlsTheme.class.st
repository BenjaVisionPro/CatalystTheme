Class {
	#name : #CgtControlsTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'sliderTrackTint',
		'sliderThumbBackground',
		'sliderThumbBorderTint',
		'sliderTickTint',
		'switchInactiveTrackTint',
		'switchThumbBackground'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #initialization }
CgtControlsTheme >> initializeThemeable [
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
		source: [ :aTheme | aTheme controls switchThumbBackground ]
]

{ #category : #accessing }
CgtControlsTheme >> sliderThumbBackground [ ^ sliderThumbBackground ]
{ #category : #accessing }
CgtControlsTheme >> sliderThumbBorderTint [ ^ sliderThumbBorderTint ]
{ #category : #accessing }
CgtControlsTheme >> sliderTickTint [ ^ sliderTickTint ]
{ #category : #accessing }
CgtControlsTheme >> sliderTrackTint [ ^ sliderTrackTint ]
{ #category : #accessing }
CgtControlsTheme >> switchInactiveTrackTint [ ^ switchInactiveTrackTint ]
{ #category : #accessing }
CgtControlsTheme >> switchThumbBackground [ ^ switchThumbBackground ]
