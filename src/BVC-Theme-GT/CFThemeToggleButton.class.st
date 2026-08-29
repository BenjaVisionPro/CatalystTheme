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
CFThemeToggleButton >> themeElement [
	themeElement ifNil: [
		themeElement := tab viewContentElement scrolledElement.
		themeElement
			when: BlElementThemeChanged
			do: [ self updateIcon ] ].
	^ themeElement
]

{ #category : #private }
CFThemeToggleButton >> toggleTheme [
	self themeElement theme: self themeElement theme toggledAppearanceTheme.
	self updateIcon
]

{ #category : #private }
CFThemeToggleButton >> updateIcon [
	self icon: ([
		(FontAwesomeIcons
			icon: self themeElement theme themeAppearanceIconName
			styleName: #light)
			size: 16 @ 16 ] asStencil)
]
