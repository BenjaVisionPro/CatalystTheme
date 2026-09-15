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
