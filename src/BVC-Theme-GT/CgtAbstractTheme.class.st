Class {
	#name : #CgtAbstractTheme,
	#superclass : #BrGlamorousTheme,
	#instVars : [
		'themeState',
		'highlight',
		'surfaces',
		'typography',
		'lighting',
		'interaction',
		'controls'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #'instance creation' }
CgtAbstractTheme class >> state: aThemeState [ ^ self new themeState: aThemeState; yourself ]
{ #category : #'class defaults' }
CgtAbstractTheme class >> buttonThemeClass [ self subclassResponsibility ]
{ #category : #'class defaults' }
CgtAbstractTheme class >> controlsThemeClass [ ^ CgtGlamorousControlsTheme ]
{ #category : #'class defaults' }
CgtAbstractTheme class >> colorsClass [ self subclassResponsibility ]
{ #category : #'class defaults' }
CgtAbstractTheme class >> defaultThemeClass [ self subclassResponsibility ]
{ #category : #'class defaults' }
CgtAbstractTheme class >> editorThemeClass [ self subclassResponsibility ]
{ #category : #'class defaults' }
CgtAbstractTheme class >> headerThemeClass [ self subclassResponsibility ]
{ #category : #'class defaults' }
CgtAbstractTheme class >> interactionThemeClass [ ^ CgtGlamorousInteractionTheme ]
{ #category : #'class defaults' }
CgtAbstractTheme class >> itemThemeClass [ ^ BrGlamorousItemTheme ]
{ #category : #'class defaults' }
CgtAbstractTheme class >> surfacesThemeClass [ self subclassResponsibility ]
{ #category : #'class defaults' }
CgtAbstractTheme class >> typographyThemeClass [ self subclassResponsibility ]

{ #category : #accessing }
CgtAbstractTheme >> controls [ ^ controls ]

{ #category : #accessing }
CgtAbstractTheme >> highlight [ ^ highlight ]

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
	default := self class defaultThemeClass theme: self. default initializeThemeable.
	editor := self class editorThemeClass theme: self. editor initializeThemeable.
	button := self class buttonThemeClass theme: self. button initializeThemeable.
	item := self class itemThemeClass new.
	header := self class headerThemeClass theme: self. header initializeThemeable.
	label := BrGlamorousLabelTheme theme: self. label initializeThemeable.
	highlight := CgtHighlightTheme theme: self. highlight initializeThemeable.
	surfaces := self class surfacesThemeClass theme: self. surfaces initializeThemeable.
	typography := self class typographyThemeClass theme: self. typography initializeThemeable.
	lighting := CgtLightingTheme theme: self.
	interaction := self class interactionThemeClass theme: self. interaction initializeThemeable.
	controls := self class controlsThemeClass theme: self. controls initializeThemeable
]

{ #category : #accessing }
CgtAbstractTheme >> interaction [ ^ interaction ]

{ #category : #accessing }
CgtAbstractTheme >> lighting [ ^ lighting ]

{ #category : #'theme lifecycle' }
CgtAbstractTheme >> onThemeModified [
	super onThemeModified.
	highlight ifNotNil: [ highlight initializeThemeable ].
	surfaces ifNotNil: [ surfaces initializeThemeable ].
	typography ifNotNil: [ typography initializeThemeable ].
	interaction ifNotNil: [ interaction initializeThemeable ].
	controls ifNotNil: [ controls initializeThemeable ]
]

{ #category : #'theme lifecycle' }
CgtAbstractTheme >> onThemeStateChanged: anAnnouncement [
	anAnnouncement state == themeState ifFalse: [ ^ self ].
	self themeModified
]

{ #category : #private }
CgtAbstractTheme >> subscribeToThemeState [
	themeState announcer weak when: CgtThemeStateChanged send: #onThemeStateChanged: to: self
]

{ #category : #accessing }
CgtAbstractTheme >> surfaces [ ^ surfaces ]
{ #category : #accessing }
CgtAbstractTheme >> themeState [ ^ themeState ]
{ #category : #accessing }
CgtAbstractTheme >> themeState: aThemeState [
	themeState == aThemeState ifTrue: [ ^ self ].
	themeState := aThemeState.
	self subscribeToThemeState.
	self themeModified
]
{ #category : #accessing }
CgtAbstractTheme >> typography [ ^ typography ]
