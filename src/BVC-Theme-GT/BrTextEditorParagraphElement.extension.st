Extension { #name : #BrTextEditorParagraphElement }

{ #category : #'*BVC-Theme-GT' }
BrTextEditorParagraphElement >> drawChildrenOnSpartaCanvas: aCanvas [
	aCanvas clip
		when: [ self clipChildren ]
		by: [ self geometry pathOnSpartaCanvas: aCanvas of: self ]
		during: [
			paragraph
				valueDo: [ :aParagraph |
					aParagraph paintOn: aCanvas at: self padding topLeft ]
				ifNone: [ self requestLayout ].

			self drawSelectionOnSpartaCanvas: aCanvas.

			self children sortedByElevation
				do: [ :anElement |
					(self canAddTextToParagraph: anElement)
						ifFalse: [ anElement fullDrawOnSpartaCanvas: aCanvas ] ] ]
]

{ #category : #'*BVC-Theme-GT' }
BrTextEditorParagraphElement >> paintSelectionOn: aCompositorPainter offset: anOffset [
	selection isEmpty
		ifTrue: [ ^ self ].

	aCompositorPainter canvas transform
		by: [ :t | t translateBy: anOffset ]
		during: [ self drawSelectionOnSpartaCanvas: aCompositorPainter canvas ]
]
