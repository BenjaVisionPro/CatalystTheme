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
	| aThemeDropdown |

	aThemeDropdown := BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonExteriorAptitude
			+ ((BrGlamorousWithExplicitDropdownAptitude
				handle: [ BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude
						- BrGlamorousButtonWithLabelTooltipAptitude2
						- BrGlamorousButtonExteriorAptitude;
					icon: ([ (FontAwesomeIcons icon: #anglesUpDown styleName: 'light') size: 16 @ 16 ] asStencil);
					label: 'Theme';
					yourself ]
				content: [ CFThemeChooser new asElement ])
				withGainFocusOnShow);
		icon: ([ (FontAwesomeIcons icon: #anglesUpDown styleName: 'light') size: 16 @ 16 ] asStencil);
		label: 'Theme';
		yourself.

	^ aThemeDropdown
]
