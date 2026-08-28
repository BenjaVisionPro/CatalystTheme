Class {
	#name : #CFThemeChoice,
	#superclass : #Object,
	#instVars : [
		'theme',
		'configuration'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #'instance creation' }
CFThemeChoice class >> theme: aTheme configuration: aConfiguration [
	^ self new
		theme: aTheme;
		configuration: aConfiguration;
		yourself
]

{ #category : #accessing }
CFThemeChoice >> configuration [
	^ configuration
]

{ #category : #accessing }
CFThemeChoice >> configuration: aConfiguration [
	configuration := aConfiguration
]

{ #category : #accessing }
CFThemeChoice >> label [
	^ theme class name
]

{ #category : #accessing }
CFThemeChoice >> theme [
	^ theme
]

{ #category : #accessing }
CFThemeChoice >> theme: aTheme [
	theme := aTheme
]
