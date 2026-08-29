Class {
	#name : #CFThemeChooserButton,
	#superclass : #BrButton,
	#instVars : [
		'dropdownAptitude',
		'themeElement',
		'mouseDownTimestamp',
		'longPress'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #'instance creation' }
CFThemeChooserButton class >> forViewContentElement: aViewContentElement [
	^ self new
		themeElement: aViewContentElement scrolledElement;
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
	aChooser := CFThemeChooser forElement: themeElement.
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
			themeElement theme: themeElement theme toggledAppearanceTheme.
			self updateIcon ]
]

{ #category : #accessing }
CFThemeChooserButton >> themeElement [
	^ themeElement
]

{ #category : #accessing }
CFThemeChooserButton >> themeElement: anElement [
	themeElement := anElement.
	themeElement
		when: BlElementThemeChanged
		do: [ self updateIcon ].
	self updateIcon
]

{ #category : #private }
CFThemeChooserButton >> updateIcon [
	self icon: ([
		(FontAwesomeIcons
			icon: themeElement theme themeAppearanceIconName
			styleName: #light)
			size: 16 @ 16 ] asStencil)
]
