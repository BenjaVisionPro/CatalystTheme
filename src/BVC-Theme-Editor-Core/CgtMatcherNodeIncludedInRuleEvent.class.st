Class {
	#name : 'CgtMatcherNodeIncludedInRuleEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'projectionNode'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtMatcherNodeIncludedInRuleEvent >> projectionNode [
	^ projectionNode
]

{ #category : 'accessing' }
CgtMatcherNodeIncludedInRuleEvent >> projectionNode: aCgtMatcherProjectionNode [
	projectionNode := aCgtMatcherProjectionNode.
	^ self
]
