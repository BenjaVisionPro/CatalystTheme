Extension { #name : #BrGlamorousCheckboxAptitude }

{ #category : #'*BVC-Theme-GT' }
BrGlamorousCheckboxAptitude >> initialize [
	| iconLook |
	super initialize.

	self add: BrLayoutAlignmentAptitude new.
	self
		addChangeProperty: #(widget layout)
		with: [ BlLinearLayout horizontal ].

	self
		add:
			(iconLook := BrIconAptitude new
				icon:
					(BlElement new
						size: 8 @ 8;
						background:
							(self theme highlight foregroundColor
								blocResolveColorForTheme: self theme))).

	self
		add:
			(BrCheckboxAptitude new
				default: [ :aStyle |
					aStyle
						geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
						background:
							(self theme interaction controlBackgroundTint
								blocResolveColorForTheme: self theme);
						border:
							(BlBorder
								paint: (self theme controls sliderThumbBorderTint
									blocResolveColorForTheme: self theme)
								width: 1) ];
				hovered: [ :aStyle |
					aStyle border:
						(BlBorder
							paint: (self theme interaction hoveredBackgroundTint
								blocResolveColorForTheme: self theme)
							width: 1) ];
				checked: [ :aStyle |
					aStyle
						background:
							(self theme highlight color
								blocResolveColorForTheme: self theme);
						border:
							(BlBorder
								paint: (self theme highlight color
									blocResolveColorForTheme: self theme)
								width: 1) ]).

	self
		add:
			(BrCheckboxAptitude new
				@ [ iconLook icon ];
				checked: [ :aStyle |
					aStyle geometry: BrGlamorousVectorIcons checkedCheckboxGeometry ];
				unchecked: [ :aStyle |
					aStyle geometry: BrGlamorousVectorIcons uncheckedCheckboxGeometry ];
				indeterminate: [ :aStyle |
					aStyle geometry: BrGlamorousVectorIcons indeterminateCheckboxGeometry ]).

	self
		add:
			(BrSizeAdjustmentAptitude new
				normal: [ :aStyle |
					aStyle
						vExact: 16;
						hExact: 16 ];
				small: [ :aStyle |
					aStyle
						vExact: 14;
						hExact: 14 ])
]
