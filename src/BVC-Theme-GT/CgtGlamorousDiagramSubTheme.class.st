Class {
	#name : #CgtGlamorousDiagramSubTheme,
	#superclass : #Object,
	#instVars : [ 'theme' ],
	#category : #'BVC-Theme-GT'
}
{ #category : #'instance creation' }
CgtGlamorousDiagramSubTheme class >> theme: aTheme [ ^ self new theme: aTheme; yourself ]
{ #category : #accessing }
CgtGlamorousDiagramSubTheme >> theme: aTheme [ theme := aTheme ]
{ #category : #accessing }
CgtGlamorousDiagramSubTheme >> workspaceBackground [ ^ theme default contentBackground ]
{ #category : #accessing }
CgtGlamorousDiagramSubTheme >> shapeBackground [ ^ theme groupCard background ]
{ #category : #accessing }
CgtGlamorousDiagramSubTheme >> shapeBorderColor [ ^ theme label defaultTextForeground ]
{ #category : #accessing }
CgtGlamorousDiagramSubTheme >> poolBorderColor [ ^ theme label defaultTextForeground ]

{ #category : #accessing }
CgtGlamorousDiagramSubTheme >> iconForeground [ ^ theme label defaultTextForeground ]
{ #category : #accessing }
CgtGlamorousDiagramSubTheme >> paletteBorderColor [ ^ theme label defaultTextForeground ]
{ #category : #accessing }
CgtGlamorousDiagramSubTheme >> popupBackground [ ^ theme default contentBackground ]
{ #category : #accessing }
CgtGlamorousDiagramSubTheme >> handleBackground [ ^ theme default contentBackground ]
{ #category : #accessing }
CgtGlamorousDiagramSubTheme >> startEventColor [ ^ Color r: 0.03 g: 0.38 b: 0.08 ]
{ #category : #accessing }
CgtGlamorousDiagramSubTheme >> endEventColor [ ^ Color r: 0.48 g: 0.025 b: 0.025 ]
