Class {
	#name : #CgtGlamorousPaletteSubTheme,
	#superclass : #Object,
	#instVars : [ 'theme' ],
	#category : #'BVC-Theme-GT'
}
{ #category : #'instance creation' }
CgtGlamorousPaletteSubTheme class >> theme: aTheme [ ^ self new theme: aTheme; yourself ]
{ #category : #accessing }
CgtGlamorousPaletteSubTheme >> theme: aTheme [ theme := aTheme ]
{ #category : #accessing }
CgtGlamorousPaletteSubTheme >> background [ ^ theme button disabledBackgroundColor ]
