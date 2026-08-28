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
	| aThemeButton aDropdownAptitude mouseDownTimestamp popupDelay updateIcon |

	popupDelay := 250 milliSeconds.

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
		action: [ :aButton :aButtonModel :aClickEvent |
			| aPressDuration |
			aPressDuration := mouseDownTimestamp
				ifNil: [ Duration zero ]
				ifNotNil: [ aClickEvent timestamp - mouseDownTimestamp ].
			aPressDuration >= popupDelay
				ifTrue: [
					aThemeButton dispatchEvent: (BrDropdownShowWish new
						anchor: aThemeButton;
						yourself) ]
				ifFalse: [
					| aTheme |
					aTheme := BlTheme default toggledAppearanceTheme.
					BlTheme default: aTheme.
					self theme: aTheme ] ];
		yourself.

	aThemeButton
		when: BlMouseDownEvent
		do: [ :anEvent | mouseDownTimestamp := anEvent timestamp ].

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
