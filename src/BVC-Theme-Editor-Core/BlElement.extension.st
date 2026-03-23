Extension { #name : #BlElement }

{ #category : #'*BVC-Theme-Editor-Core' }
BlElement >> cgtCloseThemeEditor [
	(self valueOfProperty: #cgtThemeEditor ifAbsent: [ nil ])
		ifNotNil: [ :anEditor |
			anEditor close.
			self removeProperty: #cgtThemeEditor ifAbsent: [ ] ]
]

{ #category : #'*BVC-Theme-Editor-Core' }
BlElement >> cgtDisableThemeEditorSupport [
	| aHandler |
	self cgtCloseThemeEditor.
	aHandler := self valueOfProperty: #cgtThemeEditorEventHandler ifAbsent: [ nil ].
	aHandler ifNotNil: [
		self removeEventHandler: aHandler ifAbsent: [ ].
		self removeProperty: #cgtThemeEditorEventHandler ifAbsent: [ ] ]
]

{ #category : #'*BVC-Theme-Editor-Core' }
BlElement >> cgtEnableThemeEditorSupport [
	| aHandler anEditor |
	(self valueOfProperty: #cgtThemeEditorEventHandler ifAbsent: [ nil ]) ifNotNil: [
		^ self cgtOpenThemeEditor ].
	anEditor := self cgtOpenThemeEditor.
	aHandler := CgtThemeEditorEventHandler new.
	aHandler editor: anEditor.
	self addEventHandler: aHandler.
	self propertyAt: #cgtThemeEditorEventHandler put: aHandler.
	^ anEditor
]

{ #category : #'*BVC-Theme-Editor-Core' }
BlElement >> cgtHasThemeEditorShortcut [
	^ (self valueOfProperty: #cgtThemeEditorShortcutHandler ifAbsent: [ nil ]) isNotNil
]

{ #category : #'*BVC-Theme-Editor-Core' }
BlElement >> cgtInstallThemeEditorShortcut [
	| aHandler |
	(self valueOfProperty: #cgtThemeEditorShortcutHandler ifAbsent: [ nil ]) ifNotNil: [
		^ self ].
	aHandler := CgtThemeEditorShortcutEventHandler new.
	self addEventHandler: aHandler.
	self propertyAt: #cgtThemeEditorShortcutHandler put: aHandler.
	^ self
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
BlElement >> cgtThemeEditorEventHandler [
	^ self valueOfProperty: #cgtThemeEditorEventHandler ifAbsent: [ nil ]
]

{ #category : #'*BVC-Theme-Editor-Core' }
BlElement >> cgtToggleThemeEditor [
	| anEditor |
	anEditor := self valueOfProperty: #cgtThemeEditor ifAbsent: [ nil ].
	anEditor
		ifNil: [ ^ self cgtOpenThemeEditor ]
		ifNotNil: [ anEditor toggle. ^ anEditor ]
]

{ #category : #'*BVC-Theme-Editor-Core' }
BlElement >> cgtToggleThemeEditorSupport [
	self cgtThemeEditorEventHandler
		ifNil: [ ^ self cgtEnableThemeEditorSupport ]
		ifNotNil: [ ^ self cgtDisableThemeEditorSupport ]
]

{ #category : #'*BVC-Theme-Editor-Core' }
BlElement >> cgtUninstallThemeEditorShortcut [
	| aHandler |
	aHandler := self valueOfProperty: #cgtThemeEditorShortcutHandler ifAbsent: [ nil ].
	aHandler ifNotNil: [
		self removeEventHandler: aHandler ifAbsent: [ ].
		self removeProperty: #cgtThemeEditorShortcutHandler ifAbsent: [ ] ].
	^ self
]
