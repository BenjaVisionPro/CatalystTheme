Extension { #name : #BrGlamorousTabSwitcherWithLabelAptitude }

{ #category : #'*BVC-Theme-GT' }
BrGlamorousTabSwitcherWithLabelAptitude >> initialize [
	super initialize.

	self add: (BrGlamorousTextLabelAptitude new
		foreground: self theme tabSwitcher foreground).

	self addChangeProperty: #(widget geometry) with: [
		BlStadiumGeometry new ]
]
