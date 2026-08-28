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
	| aThemeButton aDropdownAptitude popupTask popupDelay openChooser updateIcon applyTheme |

	popupDelay := 250 milliSeconds.
	openChooser := false.

	applyTheme := [ :aTheme |
		BlTheme default: aTheme.
		BlSpace allOpenSpacesDo: [ :aSpace | aSpace theme: aTheme ] ].

	aDropdownAptitude := BrGlamorousWithExplicitDropdownAptitude new
		content: [ CFThemeChooser new asElement ];
		doNotShowOnClick;
		withGainFocusOnShow;
		yourself.

	aThemeButton := BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude
			- BrGlamorousButtonExteriorAptitude
			+ aDropdownAptitude;
		label: 'Toggle light / dark theme';
		action: [
			openChooser
				ifTrue: [
					openChooser := false.
					aDropdownAptitude show ]
				ifFalse: [
					applyTheme value: BlTheme default toggledAppearanceTheme ] ];
		yourself.

	popupTask := BlDelayedTaskAction new
		delay: popupDelay;
		element: aThemeButton;
		action: [ openChooser := true ];
		yourself.

	aThemeButton
		when: BlMouseDownEvent
		do: [
			openChooser := false.
			popupTask startOrRestart ].
	aThemeButton
		when: BlMouseUpEvent
		do: [ popupTask stop ].

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
