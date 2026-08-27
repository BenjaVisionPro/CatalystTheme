Extension { #name : #BrMenuSubmenuItemElement }

{ #category : #'*BVC-Theme-GT' }
BrMenuSubmenuItemElement >> initializeStyling [
	self
		geometry: (BlRoundedRectangleGeometry cornerRadius: self theme menu itemCornerRadius);
		padding: self theme menu itemPadding.
	self addAptitude:
		(BrStyleCommonAptitude new
			default: [ :aStyle |
				aStyle background: self theme item defaultColor ];
			when: BlElementState hovered & BlElementState selected
				style: [ :aStyle |
					aStyle background: self theme item selectedColor ];
			when: BlElementState hovered not & BlElementState selected
				style: [ :aStyle |
					aStyle background: self theme item selectedColor ];
			pressed: [ :aStyle |
				aStyle background: self theme item pressedColor ])
]
