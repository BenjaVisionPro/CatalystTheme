Extension { #name : #BrGlamorousTabSwitcherWithLabelAndIconAptitude }

{ #category : #'*BVC-Theme-GT' }
BrGlamorousTabSwitcherWithLabelAndIconAptitude >> initialize [
	super initialize.

	self add: (BrGlamorousButtonLabelAndIconAptitude new
		defaultColor: self theme tabSwitcher foreground;
		hoveredColor: self theme tabSwitcher foreground;
		pressedColor: self theme tabSwitcher foreground;
		selectedColor: self theme tabSwitcher foreground).

	self addChangeProperty: #(widget geometry) with: [
		BlStadiumGeometry new ]
]
