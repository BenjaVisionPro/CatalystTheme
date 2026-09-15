Class {
	#name : #CgtTabSwitcherSubTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'background',
		'hoveredBackground',
		'pressedBackground',
		'selectedBackground',
		'foreground',
		'headerBackground'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #initialization }
CgtTabSwitcherSubTheme >> initializeThemeable [
	background := self color: [ :aTheme | aTheme default contentBackground ] source: [ :aTheme | aTheme tabSwitcher background ].
	hoveredBackground := self color: [ :aTheme | aTheme tabSwitcher constantAt: #hoveredBackground ] source: [ :aTheme | aTheme tabSwitcher hoveredBackground ].
	pressedBackground := self color: [ :aTheme | aTheme tabSwitcher constantAt: #pressedBackground ] source: [ :aTheme | aTheme tabSwitcher pressedBackground ].
	selectedBackground := self color: [ :aTheme | aTheme item selectedColor ] source: [ :aTheme | aTheme tabSwitcher selectedBackground ].
	foreground := self color: [ :aTheme | aTheme label defaultTextForeground ] source: [ :aTheme | aTheme tabSwitcher foreground ].
	headerBackground := self color: [ :aTheme | aTheme default contentBackground ] source: [ :aTheme | aTheme tabSwitcher headerBackground ]
]

{ #category : #accessing }
CgtTabSwitcherSubTheme >> background [ ^ background ]
{ #category : #accessing }
CgtTabSwitcherSubTheme >> hoveredBackground [ ^ hoveredBackground ]
{ #category : #accessing }
CgtTabSwitcherSubTheme >> pressedBackground [ ^ pressedBackground ]
{ #category : #accessing }
CgtTabSwitcherSubTheme >> selectedBackground [ ^ selectedBackground ]
{ #category : #accessing }
CgtTabSwitcherSubTheme >> foreground [ ^ foreground ]
{ #category : #accessing }
CgtTabSwitcherSubTheme >> headerBackground [ ^ headerBackground ]
