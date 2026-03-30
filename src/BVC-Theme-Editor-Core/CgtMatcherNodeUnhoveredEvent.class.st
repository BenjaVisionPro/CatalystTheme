"
#Matcher Node Unhovered Event
I announce that a matcher node is no longer hovered. I carry the projection node so the editor can clear matcher-driven hover explicitly.
"
Class {
	#name : 'CgtMatcherNodeUnhoveredEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'projectionNode'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtMatcherNodeUnhoveredEvent >> projectionNode [
	^ projectionNode
]

{ #category : 'accessing' }
CgtMatcherNodeUnhoveredEvent >> projectionNode: aCgtMatcherProjectionNode [
	projectionNode := aCgtMatcherProjectionNode
]

{ #category : 'sending' }
CgtMatcherNodeUnhoveredEvent >> sendTo: anObject [
	anObject matcherNodeUnhoveredEvent: self
]
