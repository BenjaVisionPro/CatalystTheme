Extension { #name : 'BlSpace' }

{ #category : '*BVC-Theme-Editor-Core' }
BlSpace >> withThemeEditor [
	<spaceCommonSettings>
	self root addEventFilter: CgtEditorEventHandler new
]
