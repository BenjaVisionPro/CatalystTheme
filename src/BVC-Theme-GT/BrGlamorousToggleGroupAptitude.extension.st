Extension { #name : #BrGlamorousToggleGroupAptitude }

{ #category : #'*BVC-Theme-GT' }
BrGlamorousToggleGroupAptitude >> applyThemeBorder [
	self widget border:
		(BlBorder
			paint: (self theme interaction hoveredBackgroundTint
				blocResolveColorForTheme: self theme)
			width: 1)
]

{ #category : #'*BVC-Theme-GT' }
BrGlamorousToggleGroupAptitude >> initialize [
	super initialize.
	self
		addChangeProperty: #(widget layout)
		with: [ BlLinearLayout horizontal cellSpacing: 0 ].
	self
		addChangeProperty: #(widget geometry)
		with: [ BlRoundedRectangleGeometry cornerRadius: 3 ].
	self
		addChangeProperty: #(widget border)
		with: [
			BlBorder
				paint: (self theme interaction hoveredBackgroundTint
					blocResolveColorForTheme: self theme)
				width: 1 ]
]

{ #category : #'*BVC-Theme-GT' }
BrGlamorousToggleGroupAptitude >> initializeListeners [
	super initializeListeners.
	self when: BlElementThemeChanged do: [ self applyThemeBorder ]
]
