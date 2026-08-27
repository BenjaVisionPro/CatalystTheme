Extension { #name : #BrPopoverContainerAptitude }

{ #category : #'*BVC-Theme-GT' }
BrPopoverContainerAptitude >> applyMenuTheme [
	| aMenuTheme |
	aMenuTheme := self theme menu.
	self widgetDo: [ :aWidget |
		aWidget
			geometry:
				(BlChildrenWrappingGeometry
					cornerRadius: aMenuTheme cornerRadius
					enlargedBy: 1);
			border:
				(BlBorder
					paint: (aMenuTheme borderColor
						blocResolveColorForTheme: self theme)
					width: 1);
			outskirts: BlOutskirts outside;
			background:
				(aMenuTheme background
					blocResolveColorForTheme: self theme);
			effect:
				(BlGaussianShadowEffect
					color: (aMenuTheme shadowColor
						blocResolveColorForTheme: self theme)
					width: aMenuTheme shadowWidth
					offset: aMenuTheme shadowOffset) ]
]

{ #category : #'*BVC-Theme-GT' }
BrPopoverContainerAptitude >> initialize [
	super initialize.

	self
		addChangeProperty: #(widget geometry)
		with: [
			BlChildrenWrappingGeometry
				cornerRadius: self theme menu cornerRadius
				enlargedBy: 1 ];
		addChangeProperty: #(widget border)
		with: [
			BlBorder
				paint: (self theme menu borderColor
					blocResolveColorForTheme: self theme)
				width: 1 ];
		addChangeProperty: #(widget outskirts)
		with: [ BlOutskirts outside ];
		addChangeProperty: #(widget background)
		with: [
			self theme menu background
				blocResolveColorForTheme: self theme ];
		addChangeProperty: #(widget effect)
		with: [
			BlGaussianShadowEffect
				color: (self theme menu shadowColor
					blocResolveColorForTheme: self theme)
				width: self theme menu shadowWidth
				offset: self theme menu shadowOffset ]
]

{ #category : #'*BVC-Theme-GT' }
BrPopoverContainerAptitude >> initializeListeners [
	super initializeListeners.
	self when: BlElementThemeChanged do: [ self applyMenuTheme ]
]
