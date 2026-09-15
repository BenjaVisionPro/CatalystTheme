Class {
	#name : #CgtTheme,
	#superclass : #BrGlamorousTheme,
	#instVars : [
		'appearanceState',
		'typography',
		'slider',
		'switch',
		'tag',
		'toggleGroup',
		'menu',
		'tooltip',
		'tabSwitcher'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #'instance creation' }
CgtTheme class >> appearanceState: anAppearanceState [ ^ self new appearanceState: anAppearanceState; yourself ]
{ #category : #'class defaults' }
CgtTheme class >> buttonThemeClass [ self subclassResponsibility ]
{ #category : #'class defaults' }
CgtTheme class >> colorsClass [ self subclassResponsibility ]
{ #category : #'class defaults' }
CgtTheme class >> defaultThemeClass [ self subclassResponsibility ]
{ #category : #'class defaults' }
CgtTheme class >> editorThemeClass [ self subclassResponsibility ]
{ #category : #'class defaults' }
CgtTheme class >> headerThemeClass [ self subclassResponsibility ]
{ #category : #'class defaults' }
CgtTheme class >> sliderThemeClass [ self subclassResponsibility ]
{ #category : #'class defaults' }
CgtTheme class >> switchThemeClass [ self subclassResponsibility ]
{ #category : #'class defaults' }
CgtTheme class >> tagThemeClass [ self subclassResponsibility ]
{ #category : #'class defaults' }
CgtTheme class >> tabSwitcherThemeClass [ self subclassResponsibility ]
{ #category : #'class defaults' }
CgtTheme class >> toggleGroupThemeClass [ ^ CgtToggleGroupSubTheme ]
{ #category : #'class defaults' }
CgtTheme class >> itemThemeClass [ ^ CgtItemSubTheme ]
{ #category : #'class defaults' }
CgtTheme class >> menuThemeClass [ ^ CgtMenuSubTheme ]
{ #category : #'class defaults' }
CgtTheme class >> tooltipThemeClass [ ^ CgtTooltipSubTheme ]
{ #category : #'class defaults' }
CgtTheme class >> typographyThemeClass [ self subclassResponsibility ]

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
	typography := self class typographyThemeClass theme: self. typography initializeThemeable.
	slider := self class sliderThemeClass theme: self. slider initializeThemeable.
	switch := self class switchThemeClass theme: self. switch initializeThemeable.
	tag := self class tagThemeClass theme: self. tag initializeThemeable.
	toggleGroup := self class toggleGroupThemeClass theme: self. toggleGroup initializeThemeable.
	menu := self class menuThemeClass theme: self. menu initializeThemeable.
	tooltip := self class tooltipThemeClass theme: self. tooltip initializeThemeable.
	tabSwitcher := self class tabSwitcherThemeClass theme: self. tabSwitcher initializeThemeable.

	link := BrGlamorousLinkTheme new.
	status := BrGlamorousStatusTheme new.
	editor := self class editorThemeClass theme: self. editor initializeThemeable.
	button := self class buttonThemeClass theme: self. button initializeThemeable.
	item := self class itemThemeClass theme: self.
	header := self class headerThemeClass theme: self. header initializeThemeable.
	label := BrGlamorousLabelTheme theme: self. label initializeThemeable
]

{ #category : #accessing }
CgtTheme >> slider [ ^ slider ]
{ #category : #accessing }
CgtTheme >> switch [ ^ switch ]
{ #category : #accessing }
CgtTheme >> tag [ ^ tag ]
{ #category : #accessing }
CgtTheme >> toggleGroup [ ^ toggleGroup ]

{ #category : #accessing }
CgtTheme >> menu [ ^ menu ]

{ #category : #'theme lifecycle' }
CgtTheme >> onThemeModified [
	super onThemeModified.
	typography ifNotNil: [ typography initializeThemeable ].
	slider ifNotNil: [ slider initializeThemeable ].
	switch ifNotNil: [ switch initializeThemeable ].
	tag ifNotNil: [ tag initializeThemeable ].
	toggleGroup ifNotNil: [ toggleGroup initializeThemeable ].
	menu ifNotNil: [ menu initializeThemeable ].
	tooltip ifNotNil: [ tooltip initializeThemeable ].
	tabSwitcher ifNotNil: [ tabSwitcher initializeThemeable ]
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
CgtTheme >> tooltip [ ^ tooltip ]

{ #category : #accessing }
CgtTheme >> tabSwitcher [ ^ tabSwitcher ]

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
