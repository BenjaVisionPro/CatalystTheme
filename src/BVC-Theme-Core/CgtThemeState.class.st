Class {
	#name : #CgtThemeState,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'highlightColor',
		'textHighlightColor',
		'lightDirection'
	],
	#classVars : [
		'Default'
	],
	#category : #'BVC-Theme-Core'
}

{ #category : #accessing }
CgtThemeState class >> default [
	^ Default ifNil: [ Default := self new ]
]

{ #category : #'class initialization' }
CgtThemeState class >> resetDefault [
	Default := nil
]

{ #category : #defaults }
CgtThemeState class >> defaultHighlightColor [
	^ CgtPalette highlightBlue
]

{ #category : #defaults }
CgtThemeState class >> defaultTextHighlightColor [
	^ CgtPalette textHighlightBlue
]

{ #category : #defaults }
CgtThemeState class >> defaultLightDirection [
	| now secondsInDay phase angle |
	now := DateAndTime now.
	secondsInDay := (now hour * 3600) + (now minute * 60) + now second.
	phase := secondsInDay / 86400.0.
	angle := (Float pi / 2.0) + (phase * 2.0 * Float pi).
	^ (angle cos @ angle sin) asBlocVector normalized
]

{ #category : #accessing }
CgtThemeState >> announcer [
	^ announcer
]

{ #category : #private }
CgtThemeState >> announceChanged [
	self announcer announce: (CgtThemeStateChanged new state: self)
]

{ #category : #accessing }
CgtThemeState >> highlightColor [
	^ highlightColor
]

{ #category : #accessing }
CgtThemeState >> highlightColor: aColor [
	highlightColor = aColor ifTrue: [ ^ self ].
	highlightColor := aColor.
	self announceChanged
]

{ #category : #initialization }
CgtThemeState >> initialize [
	super initialize.
	announcer := Announcer new.
	highlightColor := self class defaultHighlightColor.
	textHighlightColor := self class defaultTextHighlightColor.
	lightDirection := self class defaultLightDirection
]

{ #category : #accessing }
CgtThemeState >> lightDirection [
	^ lightDirection
]

{ #category : #accessing }
CgtThemeState >> lightDirection: aPointOrVector [
	| aVector |
	aVector := aPointOrVector asBlocVector normalized.
	lightDirection = aVector ifTrue: [ ^ self ].
	lightDirection := aVector.
	self announceChanged
]

{ #category : #accessing }
CgtThemeState >> textHighlightColor [
	^ textHighlightColor
]

{ #category : #accessing }
CgtThemeState >> textHighlightColor: aColor [
	textHighlightColor = aColor ifTrue: [ ^ self ].
	textHighlightColor := aColor.
	self announceChanged
]
