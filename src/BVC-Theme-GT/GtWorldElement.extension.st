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
	^ BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude
			- BrGlamorousButtonExteriorAptitude
			+ (BrGlamorousWithExplicitDropdownAptitude new
				withGainFocusOnShow;
				content: [
					CFThemeChooser new
						worldElement: self;
						asElement ]);
		icon: ((FontAwesomeIcons
			icon: #sunBright
			styleName: #light)
			size: 16 @ 16);
		label: 'Theme';
		yourself
]
