Extension { #name : #BrPopoverCommonAptitude }

{ #category : #'*BVC-Theme-GT' }
BrPopoverCommonAptitude >> initialize [
	super initialize.

	self
		addChangeProperty: #(widget geometry)
		with: [
			BlRoundedRectangleGeometry
				cornerRadius: self theme menu cornerRadius ]
]
