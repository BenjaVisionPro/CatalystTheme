Class {
	#name : #CgtSliderSubTheme,
	#superclass : #BlSubTheme,
	#instVars : [ 'trackBackground', 'activeTrackBackground', 'thumbBackground', 'thumbBorderColor', 'tickColor' ],
	#category : #'BVC-Theme-GT'
}

{ #category : #initialization }
CgtSliderSubTheme >> initializeThemeable [
	trackBackground := self color: [ :aTheme | aTheme slider constantAt: #trackBackground ] source: [ :aTheme | aTheme slider trackBackground ].
	activeTrackBackground := self color: [ :aTheme | aTheme appearanceState themeColour ] source: [ :aTheme | aTheme slider activeTrackBackground ].
	thumbBackground := self color: [ :aTheme | aTheme slider constantAt: #thumbBackground ] source: [ :aTheme | aTheme slider thumbBackground ].
	thumbBorderColor := self color: [ :aTheme | aTheme slider constantAt: #thumbBorderColor ] source: [ :aTheme | aTheme slider thumbBorderColor ].
	tickColor := self color: [ :aTheme | aTheme slider constantAt: #tickColor ] source: [ :aTheme | aTheme slider tickColor ]
]

{ #category : #accessing }
CgtSliderSubTheme >> trackBackground [ ^ trackBackground ]
{ #category : #accessing }
CgtSliderSubTheme >> activeTrackBackground [ ^ activeTrackBackground ]
{ #category : #accessing }
CgtSliderSubTheme >> thumbBackground [ ^ thumbBackground ]
{ #category : #accessing }
CgtSliderSubTheme >> thumbBorderColor [ ^ thumbBorderColor ]
{ #category : #accessing }
CgtSliderSubTheme >> tickColor [ ^ tickColor ]
