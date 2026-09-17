Class {
	#name : #CFThemeToggleButton,
	#superclass : #BrButton,
	#instVars : [
		'themeElement',
		'tab'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #'instance creation' }
CFThemeToggleButton class >> forElement: anElement [
	^ self new
		themeElement: anElement;
		yourself
]

{ #category : #'instance creation' }
CFThemeToggleButton class >> forTab: aTab [
	^ self new
		tab: aTab;
		yourself
]

{ #category : #initialization }
CFThemeToggleButton >> initialize [
	super initialize.
	self
		aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonExteriorAptitude;
		label: 'Toggle light / dark Foundation theme';
		icon: ([
			(FontAwesomeIcons icon: #sunBright styleName: #light)
				size: 16 @ 16 ] asStencil);
		action: [ self toggleTheme ]
]

{ #category : #'hooks - children' }
CFThemeToggleButton >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	self themeElement.
	self updateIcon
]

{ #category : #accessing }
CFThemeToggleButton >> tab [
	^ tab
]

{ #category : #accessing }
CFThemeToggleButton >> tab: aTab [
	tab := aTab
]

{ #category : #accessing }
CFThemeToggleButton >> themeElement: anElement [
	themeElement := anElement.
	themeElement
		when: BlElementThemeChanged
		do: [ self updateIcon ]
]

{ #category : #accessing }
CFThemeToggleButton >> themeElement [
	themeElement ifNil: [
		self themeElement: tab viewContentElement ].
	^ themeElement
]

{ #category : #private }
CFThemeToggleButton >> toggleTheme [
	self themeElement theme: (self alternateThemeFor: self themeElement theme).
	self updateIcon
]

{ #category : #private }
CFThemeToggleButton >> alternateThemeFor: aTheme [
	aTheme class = BrGlamorousLightTheme ifTrue: [ ^ BrGlamorousDarkTheme new ].
	aTheme class = BrGlamorousDarkTheme ifTrue: [ ^ BrGlamorousLightTheme new ].
	^ aTheme toggledAppearanceTheme
]

{ #category : #private }
CFThemeToggleButton >> appearanceIconNameFor: aTheme [
	aTheme class = BrGlamorousLightTheme ifTrue: [ ^ #sunBright ].
	aTheme class = BrGlamorousDarkTheme ifTrue: [ ^ #moon ].
	^ aTheme themeAppearanceIconName
]

{ #category : #private }
CFThemeToggleButton >> updateIcon [
	| targetTheme |
	targetTheme := self themeElement theme.
	self icon: ([
		(FontAwesomeIcons
			icon: (self appearanceIconNameFor: targetTheme)
			styleName: #light)
			color: targetTheme button defaultTextForeground;
			size: 16 @ 16 ] asStencil)
]
