Extension { #name : #BrMenuItemAptitude }

{ #category : #'*BVC-Theme-GT' }
BrMenuItemAptitude >> initialize [
	super initialize.

	self
		addChangeProperty: #(widget geometry)
		with: [
			BlRoundedRectangleGeometry
				cornerRadius: self theme menu itemCornerRadius ];
		add:
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
