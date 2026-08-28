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
	| aThemeButton updateIcon applyTheme |

	applyTheme := [ :aTheme |
		BlTheme default: aTheme.
		BlSpace allOpenSpacesDo: [ :aSpace | aSpace theme: aTheme ] ].

	aThemeButton := BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonExteriorAptitude
			+ ((BrGlamorousWithExplicitDropdownAptitude
				handle: [ BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude
						- BrGlamorousButtonWithLabelTooltipAptitude2
						- BrGlamorousButtonExteriorAptitude
						+ BrGlamorousButtonIconDropdownAptitude new;
					icon: BrGlamorousVectorIcons downwards;
					label: 'Choose theme';
					yourself ]
				content: [ CFThemeChooser new asElement ])
				withGainFocusOnShow);
		label: 'Toggle light / dark theme';
		action: [
			applyTheme value: BlTheme default toggledAppearanceTheme ];
		yourself.

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
