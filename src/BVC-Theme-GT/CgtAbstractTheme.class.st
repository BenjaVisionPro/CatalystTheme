Class {
	#name : #CgtAbstractTheme,
	#superclass : #BrGlamorousTheme,
	#instVars : [
		'themeState',
		'foundation',
		'typography'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #'instance creation' }
CgtAbstractTheme class >> state: aThemeState [
	^ self new
		themeState: aThemeState;
		yourself
]

{ #category : #'class defaults' }
CgtAbstractTheme class >> buttonThemeClass [
	self subclassResponsibility
]

{ #category : #'class defaults' }
CgtAbstractTheme class >> colorsClass [
	self subclassResponsibility
]

{ #category : #'class defaults' }
CgtAbstractTheme class >> defaultThemeClass [
	self subclassResponsibility
]

{ #category : #'class defaults' }
CgtAbstractTheme class >> editorThemeClass [
	self subclassResponsibility
]


{ #category : #'class defaults' }
CgtAbstractTheme class >> foundationThemeClass [
	self subclassResponsibility
]

{ #category : #'class defaults' }
CgtAbstractTheme class >> headerThemeClass [
	self subclassResponsibility
]

{ #category : #'class defaults' }
CgtAbstractTheme class >> itemThemeClass [
	^ BrGlamorousItemTheme
]

{ #category : #accessing }
CgtAbstractTheme >> foundation [
	^ foundation
]

{ #category : #initialization }
CgtAbstractTheme >> initialize [
	super initialize.
	themeState := CgtThemeState default.
	self subscribeToThemeState.
	self initializeSubthemes
]

{ #category : #initialization }
CgtAbstractTheme >> initializeSubthemes [
	colors := self class colorsClass theme: self.
	link := BrGlamorousLinkTheme new.
	status := BrGlamorousStatusTheme new.
	default := self class defaultThemeClass theme: self.
	default initializeThemeable.
	editor := self class editorThemeClass theme: self.
	editor initializeThemeable.
	button := self class buttonThemeClass theme: self.
	button initializeThemeable.
	item := self class itemThemeClass new.
	header := self class headerThemeClass theme: self.
	header initializeThemeable.
	label := BrGlamorousLabelTheme theme: self.
	label initializeThemeable.
	foundation := self class foundationThemeClass theme: self.
	foundation initializeThemeable.
	typography := CgtTypographyTheme theme: self
]

{ #category : #'theme lifecycle' }
CgtAbstractTheme >> onThemeModified [
	super onThemeModified.
	foundation ifNotNil: [ foundation initializeThemeable ]
]

{ #category : #'theme lifecycle' }
CgtAbstractTheme >> onThemeStateChanged: anAnnouncement [
	anAnnouncement state == themeState ifFalse: [ ^ self ].
	self themeModified
]

{ #category : #private }
CgtAbstractTheme >> subscribeToThemeState [
	themeState announcer weak
		when: CgtThemeStateChanged
		send: #onThemeStateChanged:
		to: self
]

{ #category : #accessing }
CgtAbstractTheme >> themeState [
	^ themeState
]

{ #category : #accessing }
CgtAbstractTheme >> themeState: aThemeState [
	themeState == aThemeState ifTrue: [ ^ self ].
	themeState := aThemeState.
	self subscribeToThemeState.
	self themeModified
]

{ #category : #accessing }
CgtAbstractTheme >> typography [
	^ typography
]
