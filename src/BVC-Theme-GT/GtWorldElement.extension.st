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
	| aContainer aToggleButton aDropdownButton updateToggleIcon applyTheme |

	applyTheme := [ :aTheme |
		BlTheme default: aTheme.
		BlSpace allOpenSpacesDo: [ :aSpace | aSpace theme: aTheme ] ].

	aToggleButton := BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonExteriorAptitude;
		label: 'Toggle light / dark theme';
		action: [
			applyTheme value: BlTheme default toggledAppearanceTheme ];
		yourself.

	updateToggleIcon := [
		aToggleButton icon: ([
			(FontAwesomeIcons
				icon: BlTheme default themeAppearanceIconName
				styleName: #light)
				size: 16 @ 16 ] asStencil) ].
	updateToggleIcon value.
	aToggleButton when: BlElementThemeChanged do: [ updateToggleIcon value ].

	aDropdownButton := BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonExteriorAptitude
			+ ((BrGlamorousWithExplicitDropdownAptitude
				handle: [ BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude
						- BrGlamorousButtonWithLabelTooltipAptitude2
						- BrGlamorousButtonExteriorAptitude;
					icon: BrGlamorousVectorIcons downwards;
					label: 'Theme';
					yourself ]
				content: [ CFThemeChooser new asElement ])
				withGainFocusOnShow);
		icon: BrGlamorousVectorIcons downwards;
		label: 'Theme';
		yourself.

	aContainer := BrHorizontalPane new
		fitContent;
		cellSpacing: 0;
		addChildren: { aToggleButton. aDropdownButton };
		yourself.

	^ aContainer
]
