"
#Theme Selector Node Selected Event
I announce that a selector renderer node was selected. I carry the projection node so the editor can synchronize live selection explicitly.
"
Class {
	#name : 'CgtThemeSelectorNodeSelectedEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'projectionNode'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtThemeSelectorNodeSelectedEvent >> projectionNode [
	^ projectionNode
]

{ #category : 'accessing' }
CgtThemeSelectorNodeSelectedEvent >> projectionNode: aCgtMatcherProjectionNode [
	projectionNode := aCgtMatcherProjectionNode
]

{ #category : 'sending' }
CgtThemeSelectorNodeSelectedEvent >> sendTo: anObject [
	anObject selectorNodeSelectedEvent: self
]
