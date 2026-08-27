Extension { #name : #BrGlamorousToggleBackgroundAptitude }

{ #category : #'*BVC-Theme-GT' }
BrGlamorousToggleBackgroundAptitude >> initialize [
	super initialize.
	self
		activated: [ :aStyle |
			aStyle background:
				(self theme highlight color
					blocResolveColorForTheme: self theme) ]
]
