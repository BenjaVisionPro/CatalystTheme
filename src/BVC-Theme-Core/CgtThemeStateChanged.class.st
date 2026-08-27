Class {
	#name : #CgtThemeStateChanged,
	#superclass : #Announcement,
	#instVars : [
		'state'
	],
	#category : #'BVC-Theme-Core'
}

{ #category : #accessing }
CgtThemeStateChanged >> state [
	^ state
]

{ #category : #accessing }
CgtThemeStateChanged >> state: aThemeState [
	state := aThemeState
]
