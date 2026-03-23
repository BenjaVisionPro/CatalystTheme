Class {
	#name : #CgtThemeEditorShortcutEventHandler,
	#superclass : #BlCustomEventHandler,
	#classVars : [
		'ToggleCombination'
	],
	#category : #'BVC-Theme-Editor-Core'
}

{ #category : #'class initialization' }
CgtThemeEditorShortcutEventHandler class >> initialize [
	ToggleCombination := BlKeyCombination builder
		control;
		alt;
		shift;
		key: BlKeyboardKey t;
		build
]

{ #category : #'api - accessing' }
CgtThemeEditorShortcutEventHandler >> eventsToHandle [
	^ { BlKeyDownEvent. BlKeyUpEvent }
]

{ #category : #'private - testing' }
CgtThemeEditorShortcutEventHandler >> toggleCombinationMatchesIn: aRootElement [
	aRootElement isAttachedToSceneGraph ifFalse: [ ^ false ].
	^ ToggleCombination matchesKeyBuffer: aRootElement space keyboardProcessor buffer
]

{ #category : #'event handling' }
CgtThemeEditorShortcutEventHandler >> keyDownEvent: anEvent [
	(self toggleCombinationMatchesIn: anEvent currentTarget)
		ifTrue: [
			anEvent consumed: true.
			anEvent currentTarget cgtToggleThemeEditorSupport ]
]

{ #category : #'event handling' }
CgtThemeEditorShortcutEventHandler >> keyUpEvent: anEvent [
	(self toggleCombinationMatchesIn: anEvent currentTarget)
		ifTrue: [ anEvent consumed: true ]
]
