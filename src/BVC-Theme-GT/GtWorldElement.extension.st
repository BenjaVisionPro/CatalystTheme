Extension { #name : #GtWorldElement }

{ #category : #'*BVC-Theme-GT' }
GtWorldElement >> gtWorldThemeActionFor: anAction [
	<gtWorldAction>

	^ anAction explicit
		priority: 45;
		stencil: [ self newThemeButton ]
]

{ #category : #'*BVC-Theme-GT' }
GtWorldElement >> newThemeButton [
	| aThemeButton aDropdownAptitude mouseDownTimestamp popupDelay longPress updateIcon |

	popupDelay := 250 milliSeconds.
	longPress := false.

	aDropdownAptitude := BrGlamorousWithExplicitDropdownAptitude new
		withoutHandle;
		withoutMouseEventHandler;
		withGainFocusOnShow;
		content: [
			CFThemeChooser new
				worldElement: self;
				asElement ];
		yourself.

	aThemeButton := BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude
			- BrGlamorousButtonExteriorAptitude
			+ aDropdownAptitude;
		label: 'Toggle light / dark theme';
		action: [
			longPress
				ifTrue: [ longPress := false ]
				ifFalse: [
					| aTheme |
					aTheme := BlTheme default toggledAppearanceTheme.
					BlTheme default: aTheme.
					self theme: aTheme ] ];
		yourself.

	aThemeButton
		when: BlMouseDownEvent
		do: [ :anEvent |
			mouseDownTimestamp := anEvent timestamp.
			longPress := false ].

	aThemeButton
		when: BlMouseUpEvent
		do: [ :anEvent |
			mouseDownTimestamp ifNotNil: [
				(anEvent timestamp - mouseDownTimestamp) >= popupDelay ifTrue: [
					longPress := true.
					aDropdownAptitude showDueTo: anEvent ] ] ].

	updateIcon := [
		aThemeButton icon: ([
			(FontAwesomeIcons
				icon: BlTheme default themeAppearanceIconName
				styleName: #light)
				size: 16 @ 16 ] asStencil) ].
	updateIcon value.
	aThemeButton when: BlElementThemeChanged do: [ updateIcon value ].

	^ aThemeButton
]
