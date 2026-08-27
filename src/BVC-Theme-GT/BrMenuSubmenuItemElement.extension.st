Extension { #name : #BrMenuSubmenuItemElement }

{ #category : #'*BVC-Theme-GT' }
BrMenuSubmenuItemElement >> initializeStyling [
	self addAptitude:
		(BrStyleCommonAptitude new
			default: [ :aStyle |
				aStyle background: self theme item defaultColor ];
			when: BlElementState hovered & BlElementState selected
				style: [ :aStyle |
					aStyle background: self theme item selectedColor ];
			when: BlElementState hovered not & BlElementState selected
				style: [ :aStyle |
					aStyle background: self theme item hoveredColor ];
			pressed: [ :aStyle |
				aStyle background: self theme item pressedColor ])
]
