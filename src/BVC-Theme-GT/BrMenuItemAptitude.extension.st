Extension { #name : #BrMenuItemAptitude }

{ #category : #'*BVC-Theme-GT' }
BrMenuItemAptitude >> applyMenuMetrics [
	self widgetDo: [ :aWidget |
		aWidget
		geometry:
			(BlRoundedRectangleGeometry
				cornerRadius: self theme menu itemCornerRadius);
		padding: self theme menu itemPadding ]
]

{ #category : #'*BVC-Theme-GT' }
BrMenuItemAptitude >> initialize [
	super initialize.

	self add:
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
				aStyle background: self theme item pressedColor ]).
	self applyMenuMetrics
]

{ #category : #'*BVC-Theme-GT' }
BrMenuItemAptitude >> initializeListeners [
	super initializeListeners.
	self when: BlElementThemeChanged do: [ self applyMenuMetrics ]
]
