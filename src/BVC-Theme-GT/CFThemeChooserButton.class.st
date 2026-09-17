Class {
	#name : #CFThemeChooserButton,
	#superclass : #BrButton,
	#instVars : [
		'dropdownAptitude',
		'themeElement',
		'tab'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #'instance creation' }
CFThemeChooserButton class >> forElement: anElement [
	^ self new
		themeElement: anElement;
		yourself
]

{ #category : #'instance creation' }
CFThemeChooserButton class >> forTab: aTab [
	^ self new
		tab: aTab;
		yourself
]

{ #category : #initialization }
CFThemeChooserButton >> initialize [
	super initialize.

	dropdownAptitude := BrGlamorousWithExplicitDropdownAptitude
		handle: [ self newDropdownHandleElement ]
		content: [ self newThemeChooserElement ].
	dropdownAptitude withGainFocusOnShow.

	self
		aptitude: BrGlamorousButtonWithIconAptitude
			- BrGlamorousButtonExteriorAptitude
			+ dropdownAptitude;
		label: 'Choose Foundation theme';
		icon: ([
			(FontAwesomeIcons icon: #window styleName: #light)
				size: 16 @ 16 ] asStencil)
]


{ #category : #private }
CFThemeChooserButton >> iconColor [
	| targetTheme |
	targetTheme := self themeElement theme.
	^ targetTheme button defaultTextForeground
]

{ #category : #private }
CFThemeChooserButton >> updateIcon [
	self icon: ([
		(FontAwesomeIcons icon: #window styleName: #light)
			color: self iconColor;
			size: 16 @ 16 ] asStencil)
]

{ #category : #private }
CFThemeChooserButton >> newDropdownHandleElement [
	^ BrButton new
		fitContent;
		aptitude: BrGlamorousButtonWithIconAptitude
			- BrGlamorousButtonWithLabelTooltipAptitude2
			- BrGlamorousButtonExteriorAptitude;
		label: 'Choose Foundation theme';
		icon: ([
			(FontAwesomeIcons icon: #window styleName: #light)
				color: self iconColor;
				size: 16 @ 16 ] asStencil);
		yourself
]

{ #category : #private }
CFThemeChooserButton >> newThemeChooserElement [
	| aChooser anElement |
	aChooser := CFThemeChooser forElement: self themeElement.
	anElement := aChooser asElement.
	aChooser chooserElement: anElement.
	anElement theme: aChooser selectedTheme theme.
	^ anElement
]

{ #category : #'hooks - children' }
CFThemeChooserButton >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	self themeElement.
	self updateIcon
]

{ #category : #accessing }
CFThemeChooserButton >> tab [
	^ tab
]

{ #category : #accessing }
CFThemeChooserButton >> tab: aTab [
	tab := aTab
]

{ #category : #accessing }
CFThemeChooserButton >> themeElement: anElement [
	themeElement := anElement.
	themeElement
		when: BlElementThemeChanged
		do: [ self updateIcon ]
]

{ #category : #accessing }
CFThemeChooserButton >> themeElement [
	themeElement ifNil: [
		self themeElement: tab viewContentElement ].
	^ themeElement
]
