"
#Theme Selector Node Hovered Event
I announce that a selector renderer node is being hovered. I carry the projection node so the editor can synchronize live preview highlight explicitly.
"
Class {
	#name : 'CgtThemeSelectorNodeHoveredEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'projectionNode'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtThemeSelectorNodeHoveredEvent >> projectionNode [
	^ projectionNode
]

{ #category : 'accessing' }
CgtThemeSelectorNodeHoveredEvent >> projectionNode: aCgtMatcherProjectionNode [
	projectionNode := aCgtMatcherProjectionNode
]

{ #category : 'sending' }
CgtThemeSelectorNodeHoveredEvent >> sendTo: anObject [
	anObject selectorNodeHoveredEvent: self
]
