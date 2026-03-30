Class {
	#name : 'CgtMatcherNodeExcludedFromRuleEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'projectionNode'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtMatcherNodeExcludedFromRuleEvent >> projectionNode [
	^ projectionNode
]

{ #category : 'accessing' }
CgtMatcherNodeExcludedFromRuleEvent >> projectionNode: aCgtMatcherProjectionNode [
	projectionNode := aCgtMatcherProjectionNode.
	^ self
]
