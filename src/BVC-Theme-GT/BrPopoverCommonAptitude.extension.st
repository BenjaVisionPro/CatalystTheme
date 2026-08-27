Extension { #name : #BrPopoverCommonAptitude }

{ #category : #'*BVC-Theme-GT' }
BrPopoverCommonAptitude >> applyMenuTheme [
	| aMenuTheme |
	aMenuTheme := self theme menu.
	self widgetDo: [ :aWidget |
		aWidget
		geometry:
			(BlRoundedRectangleGeometry
				cornerRadius: aMenuTheme menuCornerRadius);
		padding: aMenuTheme menuContentPadding;
		background:
			(aMenuTheme menuBackground
				blocResolveColorForTheme: self theme);
		border:
			(BlBorder
				paint: (aMenuTheme menuBorderColor
					blocResolveColorForTheme: self theme)
				width: 1);
		effect:
			(BlGaussianShadowEffect
				color: (aMenuTheme menuShadowColor
					blocResolveColorForTheme: self theme)
				width: aMenuTheme menuShadowWidth
				offset: aMenuTheme menuShadowOffset) ]
]

{ #category : #'*BVC-Theme-GT' }
BrPopoverCommonAptitude >> initialize [
	super initialize.
	self applyMenuTheme
]

{ #category : #'*BVC-Theme-GT' }
BrPopoverCommonAptitude >> initializeListeners [
	super initializeListeners.
	self when: BlElementThemeChanged do: [ self applyMenuTheme ]
]
