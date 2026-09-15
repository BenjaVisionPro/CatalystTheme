Extension { #name : #BrGlamorousTabGroupSwitcherHeaderAptitude }

{ #category : #'*BVC-Theme-GT' }
BrGlamorousTabGroupSwitcherHeaderAptitude >> initialize [
	super initialize.

	self header addAptitude: BrGlamorousFocusableShadowAptitude.

	self addChangeProperty: #(header geometry) with: [ BlStadiumGeometry new ].
	self addChangeProperty: #(header background) with: [ self theme tabSwitcher headerBackground ].
	self addChangeProperty: #(header layout) with: [ BlLinearLayout horizontal alignCenter ].

	self addChangeProperty: #(tabbar layout) with: [
		BlLinearLayout horizontal alignCenter cellSpacing: 0 ].

	self add: (BrLayoutResizerAptitude new
		anyToFitContent: self header).

	self header addAptitude: (BrLayoutResizerAptitude new
		anyToFitContent: self scrollTabbar).

	self scrollTabbar addAptitude: (BrLayoutResizerAptitude new
		anyToFitContent: self tabbar)
]
