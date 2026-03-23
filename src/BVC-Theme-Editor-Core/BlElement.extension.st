Extension { #name : #BlElement }

{ #category : #'*BVC-Theme-Editor-Core' }
BlElement >> cgtCloseThemeEditor [
	(self valueOfProperty: #cgtThemeEditor ifAbsent: [ nil ])
		ifNotNil: [ :anEditor |
			anEditor close.
			self removeProperty: #cgtThemeEditor ifAbsent: [ ] ]
]

{ #category : #'*BVC-Theme-Editor-Core' }
BlElement >> cgtOpenThemeEditor [
	| anEditor |
	anEditor := self valueOfProperty: #cgtThemeEditor ifAbsent: [ nil ].
	anEditor ifNotNil: [ ^ anEditor ].
	anEditor := CgtThemeEditor on: self.
	self propertyAt: #cgtThemeEditor put: anEditor.
	^ anEditor
]

{ #category : #'*BVC-Theme-Editor-Core' }
BlElement >> cgtToggleThemeEditor [
	| anEditor |
	anEditor := self valueOfProperty: #cgtThemeEditor ifAbsent: [ nil ].
	anEditor
		ifNil: [ ^ self cgtOpenThemeEditor ]
		ifNotNil: [ anEditor toggle. ^ anEditor ]
]
