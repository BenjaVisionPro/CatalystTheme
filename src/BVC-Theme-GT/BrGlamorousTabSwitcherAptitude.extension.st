Extension { #name : #BrGlamorousTabSwitcherAptitude }

{ #category : #'*BVC-Theme-GT' }
BrGlamorousTabSwitcherAptitude >> createCommonStyleAptitude [
	^ (BrStyleCommonAptitude new
		default: [ :aStyle | aStyle background: self theme tabSwitcher background ];
		hovered: [ :aStyle | aStyle background: self theme tabSwitcher hoveredBackground ];
		pressed: [ :aStyle | aStyle background: self theme tabSwitcher pressedBackground ];
		selected: [ :aStyle | aStyle background: self theme tabSwitcher selectedBackground ])
]
