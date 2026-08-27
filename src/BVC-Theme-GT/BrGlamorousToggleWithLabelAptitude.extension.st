Extension { #name : #BrGlamorousToggleWithLabelAptitude }

{ #category : #'*BVC-Theme-GT' }
BrGlamorousToggleWithLabelAptitude >> initialize [
	| aLabelAptitude |
	super initialize.

	aLabelAptitude := BrGlamorousTextLabelAptitude new.
	self add: aLabelAptitude.
	self add: (BrGlamorousToggleRectangularAptitude new cornerRadius: 0).
	self add: BrGlamorousToggleBackgroundAptitude new.

	self add: (BrToggleAptitude new
		@ aLabelAptitude label;
		default: [ :aStyle |
			aStyle foreground: self theme label defaultTextForeground ];
		activated: [ :aStyle |
			aStyle foreground: self theme highlight foregroundColor ])
]
