Class {
	#name : #CgtAppearanceStateChanged,
	#superclass : #Announcement,
	#instVars : [
		'appearanceState'
	],
	#category : #'BVC-Theme-Core'
}

{ #category : #accessing }
CgtAppearanceStateChanged >> appearanceState [
	^ appearanceState
]

{ #category : #accessing }
CgtAppearanceStateChanged >> appearanceState: anAppearanceState [
	appearanceState := anAppearanceState
]
