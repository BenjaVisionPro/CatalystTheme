Extension { #name : #BrGlamorousButtonIconAptitude }

{ #category : #'*BVC-Theme-GT' }
BrGlamorousButtonIconAptitude >> initialize [
	super initialize.

	self add: (BrSizeAdjustmentAptitude new
		@ [ self icon ];
		huge: [ :aStyle | aStyle scaleBy: 2 ];
		large: [ :aStyle | aStyle scaleBy: 1.5 ];
		normal: [ :aStyle | aStyle scaleBy: 1 ];
		small: [ :aStyle | aStyle scaleBy: 0.75 ];
		tiny: [ :aStyle | aStyle scaleBy: 0.75 ];
		mini: [ :aStyle | aStyle scaleBy: 0.5 ]).

	self add: (BrLazyStyleCommonAptitude new
		@ [ self icon ];
		default: [ :aStyle |
			aStyle background: (self theme button defaultTextForeground
				blocResolveColorForTheme: self theme) ];
		hovered: [ :aStyle |
			aStyle background: (self theme button hoveredTextColor
				blocResolveColorForTheme: self theme) ];
		pressed: [ :aStyle |
			aStyle background: (self theme button pressedTextColor
				blocResolveColorForTheme: self theme) ];
		disabled: [ :aStyle |
			aStyle background: (self theme button disabledTextColor
				blocResolveColorForTheme: self theme) ];
		selected: [ :aStyle |
			aStyle background: (self theme button hoveredTextColor
				blocResolveColorForTheme: self theme) ])
]
