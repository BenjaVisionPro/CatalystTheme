Extension { #name : 'CgtAppearanceState' }

{ #category : '*BVC-Theme-GT' }
CgtAppearanceState >> descriptionContainerDetail: aDescription [
	<magritteContainer>
	^ aDescription
		blocPresentationStencil: [ :aMemento | CFMaDetailPresentation new ];
		yourself
]
