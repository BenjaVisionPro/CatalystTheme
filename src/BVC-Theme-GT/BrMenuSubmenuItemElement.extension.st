Extension { #name : #BrMenuSubmenuItemElement }

{ #category : #'*BVC-Theme-GT' }
BrMenuSubmenuItemElement >> applyMenuGeometry [
	self geometry:
		(BlRoundedRectangleGeometry
			cornerRadius: self theme menu itemCornerRadius)
]

{ #category : #'*BVC-Theme-GT' }
BrMenuSubmenuItemElement >> initializeStyling [
	self applyMenuGeometry.
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

{ #category : #'*BVC-Theme-GT' }
BrMenuSubmenuItemElement >> onThemeChanged [
	super onThemeChanged.
	self applyMenuGeometry
]
