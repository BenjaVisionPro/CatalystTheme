Class {
	#name : #CgtDiagramSubTheme,
	#superclass : #BlSubTheme,
	#instVars : [ 'workspaceBackground', 'shapeBackground', 'shapeBorderColor', 'poolBorderColor', 'iconForeground', 'paletteBorderColor', 'popupBackground', 'handleBackground', 'startEventColor', 'endEventColor' ],
	#category : #'BVC-Theme-GT'
}

{ #category : #initialization }
CgtDiagramSubTheme >> initializeThemeable [
	workspaceBackground := self color: [ :aTheme | aTheme default contentBackground ] source: [ :aTheme | aTheme diagram workspaceBackground ].
	shapeBackground := self color: [ :aTheme | self contrastColorFor: aTheme alpha: 7.0 / 255.0 ] source: [ :aTheme | aTheme diagram shapeBackground ].
	shapeBorderColor := self color: [ :aTheme | aTheme label defaultTextForeground ] source: [ :aTheme | aTheme diagram shapeBorderColor ].
	poolBorderColor := self color: [ :aTheme | aTheme label defaultTextForeground ] source: [ :aTheme | aTheme diagram poolBorderColor ].
	iconForeground := self color: [ :aTheme | aTheme label defaultTextForeground ] source: [ :aTheme | aTheme diagram iconForeground ].
	paletteBorderColor := self color: [ :aTheme | aTheme label defaultTextForeground ] source: [ :aTheme | aTheme diagram paletteBorderColor ].
	popupBackground := self color: [ :aTheme | aTheme default contentBackground ] source: [ :aTheme | aTheme diagram popupBackground ].
	handleBackground := self color: [ :aTheme | aTheme default contentBackground ] source: [ :aTheme | aTheme diagram handleBackground ].
	startEventColor := self color: [ :aTheme | Color r: 0.03 g: 0.38 b: 0.08 ] source: [ :aTheme | aTheme diagram startEventColor ].
	endEventColor := self color: [ :aTheme | Color r: 0.48 g: 0.025 b: 0.025 ] source: [ :aTheme | aTheme diagram endEventColor ]
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

{ #category : #accessing }
CgtDiagramSubTheme >> iconForeground [ ^ iconForeground ]
{ #category : #accessing }
CgtDiagramSubTheme >> paletteBorderColor [ ^ paletteBorderColor ]
{ #category : #accessing }
CgtDiagramSubTheme >> popupBackground [ ^ popupBackground ]
{ #category : #accessing }
CgtDiagramSubTheme >> handleBackground [ ^ handleBackground ]
{ #category : #accessing }
CgtDiagramSubTheme >> startEventColor [ ^ startEventColor ]
{ #category : #accessing }
CgtDiagramSubTheme >> endEventColor [ ^ endEventColor ]

{ #category : #'class initialization' }
CgtDiagramSubTheme class >> initialize [
	"Tonel can reshape this class while live CgtTheme instances still retain their existing
	diagram subtheme. Rebuild those existing subthemes after a load so newly introduced
	semantic properties are populated just as they are for newly-created themes."
	self allInstancesDo: [ :aDiagramTheme | aDiagramTheme initializeThemeable ]
]
