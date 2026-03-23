Extension { #name : 'GtWorldElement' }

{ #category : '*BVC-Theme-Editor-Core' }
GtWorldElement >> cgtCloseThemeEditor [
	^ CgtThemeEditor closeOn: self
]

{ #category : '*BVC-Theme-Editor-Core' }
GtWorldElement >> cgtHasThemeEditor [
	^ (CgtThemeEditor editorOn: self) isNotNil
]

{ #category : '*BVC-Theme-Editor-Core' }
GtWorldElement >> cgtOpenThemeEditor [
	^ CgtThemeEditor openOn: self
]

{ #category : '*BVC-Theme-Editor-Core' }
GtWorldElement >> cgtThemeEditor [
	^ CgtThemeEditor editorOn: self
]

{ #category : '*BVC-Theme-Editor-Core' }
GtWorldElement >> cgtToggleThemeEditor [
	^ CgtThemeEditor toggleOn: self
]

{ #category : '*BVC-Theme-Editor-Core' }
GtWorldElement >> gtWorldThemeEditorActionFor: anAction [
	<gtWorldAction>

	^ anAction explicit
		priority: 10;
		stencil: [
			| isActive button |
			isActive := self cgtHasThemeEditor.

			button := BrButton new
				id: CgtThemeEditorToggleElementId uniqueInstance;
				aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonExteriorAptitude;
				label: 'Theme Editor';
				icon: BrGlamorousVectorIcons edit;
				action: [ self cgtToggleThemeEditor ];
				yourself.

			isActive ifTrue: [
				button background: (BlPaintBackground paint: (Color blue alpha: 0.2)).
				button border: (BlBorder paint: Color blue width: 1) ].

			button ]
]
