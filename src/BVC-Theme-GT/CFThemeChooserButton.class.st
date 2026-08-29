Class {
	#name : #CFThemeChooserButton,
	#superclass : #BrButton,
	#instVars : [
		'dropdownAptitude',
		'themeElement',
		'tab',
		'mouseDownTimestamp',
		'longPress'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #'instance creation' }
CFThemeChooserButton class >> forTab: aTab [
	^ self new
		tab: aTab;
		yourself
]

{ #category : #initialization }
CFThemeChooserButton >> initialize [
	super initialize.
	longPress := false.

	dropdownAptitude := BrGlamorousWithExplicitDropdownAptitude new
		withoutHandle;
		withoutMouseEventHandler;
		withGainFocusOnShow;
		content: [ self newThemeChooserElement ];
		yourself.

	self
		aptitude: BrGlamorousButtonWithIconAptitude
			- BrGlamorousButtonExteriorAptitude
			+ dropdownAptitude;
		label: 'Toggle light / dark Foundation theme';
		icon: ([
			(FontAwesomeIcons icon: #sunBright styleName: #light)
				size: 16 @ 16 ] asStencil);
		action: [ self onActivated ].

	self
		when: BlMouseDownEvent
		do: [ :anEvent |
			mouseDownTimestamp := anEvent timestamp.
			longPress := false ].

	self
		when: BlMouseUpEvent
		do: [ :anEvent |
			mouseDownTimestamp ifNotNil: [
				(anEvent timestamp - mouseDownTimestamp) >= 250 milliSeconds ifTrue: [
					longPress := true.
					dropdownAptitude showDueTo: anEvent ] ] ]
]

{ #category : #private }
CFThemeChooserButton >> newThemeChooserElement [
	| aChooser |
	aChooser := CFThemeChooser forElement: self themeElement.
	aChooser announcer weak
		when: CFThemeChooserChanged
		send: #updateIcon
		to: self.
	^ aChooser asElement
]

{ #category : #private }
CFThemeChooserButton >> onActivated [
	longPress
		ifTrue: [ longPress := false ]
		ifFalse: [
			self themeElement theme: self themeElement theme toggledAppearanceTheme.
			self updateIcon ]
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
CFThemeChooserButton >> themeElement [
	themeElement ifNil: [
		themeElement := tab viewContentElement scrolledElement.
		themeElement
			when: BlElementThemeChanged
			do: [ self updateIcon ] ].
	^ themeElement
]

{ #category : #private }
CFThemeChooserButton >> updateIcon [
	self icon: ([
		(FontAwesomeIcons
			icon: self themeElement theme themeAppearanceIconName
			styleName: #light)
			size: 16 @ 16 ] asStencil)
]
