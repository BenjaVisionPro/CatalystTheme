Class {
	#name : #CgtTheme,
	#superclass : #BrGlamorousTheme,
	#instVars : [
		'appearanceState',
		'surfaces',
		'typography',
		'interaction',
		'controls',
		'menu'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #'instance creation' }
CgtTheme class >> appearanceState: anAppearanceState [ ^ self new appearanceState: anAppearanceState; yourself ]
{ #category : #'class defaults' }
CgtTheme class >> buttonThemeClass [ self subclassResponsibility ]
{ #category : #'class defaults' }
CgtTheme class >> controlsThemeClass [ ^ CgtGlamorousControlsSubTheme ]
{ #category : #'class defaults' }
CgtTheme class >> colorsClass [ self subclassResponsibility ]
{ #category : #'class defaults' }
CgtTheme class >> defaultThemeClass [ self subclassResponsibility ]
{ #category : #'class defaults' }
CgtTheme class >> editorThemeClass [ self subclassResponsibility ]
{ #category : #'class defaults' }
CgtTheme class >> headerThemeClass [ self subclassResponsibility ]
{ #category : #'class defaults' }
CgtTheme class >> interactionThemeClass [ ^ CgtGlamorousInteractionSubTheme ]
{ #category : #'class defaults' }
CgtTheme class >> itemThemeClass [ ^ CgtItemSubTheme ]
{ #category : #'class defaults' }
CgtTheme class >> menuThemeClass [ ^ CgtMenuSubTheme ]
{ #category : #'class defaults' }
CgtTheme class >> surfacesThemeClass [ self subclassResponsibility ]
{ #category : #'class defaults' }
CgtTheme class >> typographyThemeClass [ self subclassResponsibility ]

{ #category : #accessing }
CgtTheme >> controls [ ^ controls ]


{ #category : #initialization }
CgtTheme >> initialize [
	super initialize.
	appearanceState := CgtAppearanceState default.
	self subscribeToAppearanceState.
	self initializeSubthemes
]

{ #category : #initialization }
CgtTheme >> initializeSubthemes [
	colors := self class colorsClass theme: self.
	default := self class defaultThemeClass theme: self. default initializeThemeable.

	"Initialize Catalyst semantic providers before GT subthemes that consume them."
	surfaces := self class surfacesThemeClass theme: self. surfaces initializeThemeable.
	typography := self class typographyThemeClass theme: self. typography initializeThemeable.
	interaction := self class interactionThemeClass theme: self. interaction initializeThemeable.
	controls := self class controlsThemeClass theme: self. controls initializeThemeable.
	menu := self class menuThemeClass theme: self. menu initializeThemeable.

	link := BrGlamorousLinkTheme new.
	status := BrGlamorousStatusTheme new.
	editor := self class editorThemeClass theme: self. editor initializeThemeable.
	button := self class buttonThemeClass theme: self. button initializeThemeable.
	item := self class itemThemeClass theme: self.
	header := self class headerThemeClass theme: self. header initializeThemeable.
	label := BrGlamorousLabelTheme theme: self. label initializeThemeable
]

{ #category : #accessing }
CgtTheme >> interaction [ ^ interaction ]


{ #category : #accessing }
CgtTheme >> menu [ ^ menu ]

{ #category : #'theme lifecycle' }
CgtTheme >> onThemeModified [
	super onThemeModified.
	surfaces ifNotNil: [ surfaces initializeThemeable ].
	typography ifNotNil: [ typography initializeThemeable ].
	interaction ifNotNil: [ interaction initializeThemeable ].
	controls ifNotNil: [ controls initializeThemeable ].
	menu ifNotNil: [ menu initializeThemeable ]
]

{ #category : #'theme lifecycle' }
CgtTheme >> onAppearanceStateChanged: anAnnouncement [
	anAnnouncement appearanceState == appearanceState ifFalse: [ ^ self ].
	self themeModified
]

{ #category : #private }
CgtTheme >> subscribeToAppearanceState [
	appearanceState announcer weak when: CgtAppearanceStateChanged send: #onAppearanceStateChanged: to: self
]

{ #category : #accessing }
CgtTheme >> surfaces [ ^ surfaces ]
{ #category : #accessing }
CgtTheme >> appearanceState [ ^ appearanceState ]
{ #category : #accessing }
CgtTheme >> appearanceState: anAppearanceState [
	appearanceState == anAppearanceState ifTrue: [ ^ self ].
	appearanceState := anAppearanceState.
	self subscribeToAppearanceState.
	self themeModified
]
{ #category : #accessing }
CgtTheme >> typography [ ^ typography ]
