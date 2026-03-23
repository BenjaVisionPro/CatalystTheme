Extension { #name : #GtWorldElement }

{ #category : #'*BVC-Theme-Editor-Core' }
GtWorldElement >> cgtCloseThemeEditor [
	^ CgtThemeEditor closeOn: self
]

{ #category : #'*BVC-Theme-Editor-Core' }
GtWorldElement >> cgtHasThemeEditor [
	^ (CgtThemeEditor editorOn: self) isNotNil
]

{ #category : #'*BVC-Theme-Editor-Core' }
GtWorldElement >> cgtOpenThemeEditor [
	^ CgtThemeEditor openOn: self
]

{ #category : #'*BVC-Theme-Editor-Core' }
GtWorldElement >> cgtThemeEditor [
	^ CgtThemeEditor editorOn: self
]

{ #category : #'*BVC-Theme-Editor-Core' }
GtWorldElement >> cgtToggleThemeEditor [
	^ CgtThemeEditor toggleOn: self
]

{ #category : #'*BVC-Theme-Editor-Core' }
GtWorldElement >> gtWorldThemeEditorActionFor: anAction [
	<gtWorldAction>

	^ anAction explicit
		priority: 36;
		stencil: [
			BrButton new
				label: 'Theme Editor';
				action: [ self cgtToggleThemeEditor ];
				yourself ]
]
