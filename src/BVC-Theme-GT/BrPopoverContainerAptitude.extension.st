Extension { #name : #BrPopoverContainerAptitude }

{ #category : #'*BVC-Theme-GT' }
BrPopoverContainerAptitude >> applyMenuTheme [
	| aMenuTheme |
	aMenuTheme := self theme menu.
	self widgetDo: [ :aWidget |
		aWidget
		geometry:
			(BlChildrenWrappingGeometry
				cornerRadius: aMenuTheme containerCornerRadius
				enlargedBy: 1);
		border:
			(BlBorder
				paint: (aMenuTheme containerBorderColor
					blocResolveColorForTheme: self theme)
				width: 1);
		background:
			(aMenuTheme containerBackground
				blocResolveColorForTheme: self theme);
		effect:
			(BlGaussianShadowEffect
				color: (aMenuTheme containerShadowColor
					blocResolveColorForTheme: self theme)
				width: aMenuTheme containerShadowWidth
				offset: aMenuTheme containerShadowOffset) ]
]

{ #category : #'*BVC-Theme-GT' }
BrPopoverContainerAptitude >> initialize [
	super initialize.
	self
		addChangeProperty: #(widget outskirts)
		with: [ BlOutskirts outside ].
	self applyMenuTheme
]

{ #category : #'*BVC-Theme-GT' }
BrPopoverContainerAptitude >> initializeListeners [
	super initializeListeners.
	self when: BlElementThemeChanged do: [ self applyMenuTheme ]
]
