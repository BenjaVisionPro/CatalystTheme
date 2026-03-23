Extension { #name : #BlElement }

{ #category : #'*BVC-Theme-Editor-Core' }
BlElement >> cgtCloseThemeEditor [
	self cgtThemeEditor ifNotNil: [ :anEditor |
		anEditor close.
		self userData removeKey: #cgtThemeEditor ifAbsent: [ ] ]
]

{ #category : #'*BVC-Theme-Editor-Core' }
BlElement >> cgtDisableThemeEditorSupport [
	^ self cgtCloseThemeEditor
]

{ #category : #'*BVC-Theme-Editor-Core' }
BlElement >> cgtEnableThemeEditorSupport [
	^ self cgtOpenThemeEditor
]

{ #category : #'*BVC-Theme-Editor-Core' }
BlElement >> cgtInstallThemeEditorShortcut [
	self addEventHandler: CgtThemeEditorShortcutEventHandler new.
	^ self
]

{ #category : #'*BVC-Theme-Editor-Core' }
BlElement >> cgtOpenThemeEditor [
	| anEditor |
	anEditor := self cgtThemeEditor.
	anEditor ifNotNil: [ ^ anEditor ].
	anEditor := CgtThemeEditor on: self.
	self userData at: #cgtThemeEditor put: anEditor.
	^ anEditor
]

{ #category : #'*BVC-Theme-Editor-Core' }
BlElement >> cgtThemeEditor [
	^ self userData at: #cgtThemeEditor ifAbsent: [ nil ]
]

{ #category : #'*BVC-Theme-Editor-Core' }
BlElement >> cgtToggleThemeEditor [
	| anEditor |
	anEditor := self cgtThemeEditor.
	anEditor
		ifNil: [ ^ self cgtOpenThemeEditor ]
		ifNotNil: [ anEditor toggle. ^ anEditor ]
]

{ #category : #'*BVC-Theme-Editor-Core' }
BlElement >> cgtToggleThemeEditorSupport [
	self cgtThemeEditor
		ifNil: [ ^ self cgtEnableThemeEditorSupport ]
		ifNotNil: [ ^ self cgtDisableThemeEditorSupport ]
]

{ #category : #'*BVC-Theme-Editor-Core' }
BlElement >> cgtUninstallThemeEditorShortcut [
	self error: 'Shortcut removal is not supported in this shell build'
]
