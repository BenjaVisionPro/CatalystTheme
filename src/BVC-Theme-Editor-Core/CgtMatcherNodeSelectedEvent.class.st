"
#Matcher Node Selected Event
I announce that a matcher projection node was selected in the matcher widget. I carry the projection node so the editor can apply selection semantics explicitly.
"
Class {
	#name : 'CgtMatcherNodeSelectedEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'projectionNode'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtMatcherNodeSelectedEvent >> projectionNode [
	^ projectionNode
]

{ #category : 'accessing' }
CgtMatcherNodeSelectedEvent >> projectionNode: aCgtMatcherProjectionNode [
	projectionNode := aCgtMatcherProjectionNode
]

{ #category : 'sending' }
CgtMatcherNodeSelectedEvent >> sendTo: anObject [
	anObject matcherNodeSelectedEvent: self
]
