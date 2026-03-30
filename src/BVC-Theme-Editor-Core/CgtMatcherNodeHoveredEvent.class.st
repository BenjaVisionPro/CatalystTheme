"
#Matcher Node Hovered Event
I announce that a matcher node is being hovered. I carry the projection node so the editor can synchronize live preview highlight explicitly.
"
Class {
	#name : 'CgtMatcherNodeHoveredEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'projectionNode'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtMatcherNodeHoveredEvent >> projectionNode [
	^ projectionNode
]

{ #category : 'accessing' }
CgtMatcherNodeHoveredEvent >> projectionNode: aCgtMatcherProjectionNode [
	projectionNode := aCgtMatcherProjectionNode
]

{ #category : 'sending' }
CgtMatcherNodeHoveredEvent >> sendTo: anObject [
	anObject matcherNodeHoveredEvent: self
]
