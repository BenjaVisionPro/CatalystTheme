Class {
	#name : #CgtDiagramSubTheme,
	#superclass : #BlSubTheme,
	#instVars : [ 'workspaceBackground', 'shapeBackground', 'shapeBorderColor', 'poolBorderColor' ],
	#category : #'BVC-Theme-GT'
}

{ #category : #initialization }
CgtDiagramSubTheme >> initializeThemeable [
	workspaceBackground := self color: [ :aTheme | aTheme default contentBackground ] source: [ :aTheme | aTheme diagram workspaceBackground ].
	shapeBackground := self color: [ :aTheme | self contrastColorFor: aTheme alpha: 7.0 / 255.0 ] source: [ :aTheme | aTheme diagram shapeBackground ].
	shapeBorderColor := self color: [ :aTheme | aTheme label defaultTextForeground ] source: [ :aTheme | aTheme diagram shapeBorderColor ].
	poolBorderColor := self color: [ :aTheme | aTheme label defaultTextForeground ] source: [ :aTheme | aTheme diagram poolBorderColor ]
]

{ #category : #private }
CgtDiagramSubTheme >> contrastColorFor: aTheme alpha: anAlpha [
	| aBackground aLuminance |
	aBackground := aTheme default contentBackground blocResolveColorForTheme: aTheme.
	aLuminance := (aBackground red * 0.2126) + (aBackground green * 0.7152) + (aBackground blue * 0.0722).
	^ (aLuminance < 0.5 ifTrue: [ Color white ] ifFalse: [ Color black ]) alpha: anAlpha
]

{ #category : #accessing }
CgtDiagramSubTheme >> workspaceBackground [ ^ workspaceBackground ]
{ #category : #accessing }
CgtDiagramSubTheme >> shapeBackground [ ^ shapeBackground ]
{ #category : #accessing }
CgtDiagramSubTheme >> shapeBorderColor [ ^ shapeBorderColor ]
{ #category : #accessing }
CgtDiagramSubTheme >> poolBorderColor [ ^ poolBorderColor ]
