"
#Theme Selector Class Match Changed Event
I announce that the selector renderer requested a class-match change for a selector projection node.
"
Class {
	#name : 'CgtThemeSelectorClassMatchChangedEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'projectionNode',
		'shouldMatch'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtThemeSelectorClassMatchChangedEvent >> projectionNode [
	^ projectionNode
]

{ #category : 'accessing' }
CgtThemeSelectorClassMatchChangedEvent >> projectionNode: aCgtMatcherProjectionNode [
	projectionNode := aCgtMatcherProjectionNode
]

{ #category : 'accessing' }
CgtThemeSelectorClassMatchChangedEvent >> shouldMatch [
	^ shouldMatch
]

{ #category : 'accessing' }
CgtThemeSelectorClassMatchChangedEvent >> shouldMatch: aBoolean [
	shouldMatch := aBoolean
]

{ #category : 'sending' }
CgtThemeSelectorClassMatchChangedEvent >> sendTo: anObject [
	anObject selectorClassMatchChangedEvent: self
]
