Class {
	#name : #CgtSwitchSubTheme,
	#superclass : #BlSubTheme,
	#instVars : [ 'inactiveTrackBackground', 'activeTrackBackground', 'thumbBackground' ],
	#category : #'BVC-Theme-GT'
}

{ #category : #initialization }
CgtSwitchSubTheme >> initializeThemeable [
	inactiveTrackBackground := self color: [ :aTheme | aTheme switch constantAt: #inactiveTrackBackground ] source: [ :aTheme | aTheme switch inactiveTrackBackground ].
	activeTrackBackground := self color: [ :aTheme | aTheme appearanceState themeColour ] source: [ :aTheme | aTheme switch activeTrackBackground ].
	thumbBackground := self color: [ :aTheme | aTheme switch constantAt: #thumbBackground ] source: [ :aTheme | aTheme switch thumbBackground ]
]

{ #category : #accessing }
CgtSwitchSubTheme >> inactiveTrackBackground [ ^ inactiveTrackBackground ]
{ #category : #accessing }
CgtSwitchSubTheme >> activeTrackBackground [ ^ activeTrackBackground ]
{ #category : #accessing }
CgtSwitchSubTheme >> thumbBackground [ ^ thumbBackground ]
