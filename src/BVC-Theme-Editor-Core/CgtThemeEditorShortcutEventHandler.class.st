Class {
	#name : 'CgtThemeEditorShortcutEventHandler',
	#superclass : 'BlCustomEventHandler',
	#classVars : [
		'KeyCombination'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'class initialization' }
CgtThemeEditorShortcutEventHandler class >> initialize [
	KeyCombination := BlKeyCombination builder
		control;
		alt;
		key: BlKeyboardKey tab;
		build
]

{ #category : 'api - accessing' }
CgtThemeEditorShortcutEventHandler >> eventsToHandle [
	^ { BlKeyDownEvent. BlKeyUpEvent }
]

{ #category : 'event handling' }
CgtThemeEditorShortcutEventHandler >> keyDownEvent: anEvent [
	(self toggleCombinationMatchesIn: anEvent currentTarget)
		ifTrue: [
			CgtThemeEditor toggleOn: anEvent currentTarget.
			anEvent consumed: true ]
]

{ #category : 'event handling' }
CgtThemeEditorShortcutEventHandler >> keyUpEvent: anEvent [
	"no-op"
]

{ #category : 'private - testing' }
CgtThemeEditorShortcutEventHandler >> toggleCombinationMatchesIn: aRootElement [
	aRootElement isAttachedToSceneGraph ifFalse: [ ^ false ].
	^ KeyCombination matchesKeyBuffer: aRootElement space keyboardProcessor buffer
]
