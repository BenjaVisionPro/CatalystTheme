"
#Theme Selector Node Unhovered Event
I announce that selector renderer node hover ended. I carry the projection node that was previously hovered.
"
Class {
	#name : 'CgtThemeSelectorNodeUnhoveredEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'projectionNode'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtThemeSelectorNodeUnhoveredEvent >> projectionNode [
	^ projectionNode
]

{ #category : 'accessing' }
CgtThemeSelectorNodeUnhoveredEvent >> projectionNode: aCgtMatcherProjectionNode [
	projectionNode := aCgtMatcherProjectionNode
]

{ #category : 'sending' }
CgtThemeSelectorNodeUnhoveredEvent >> sendTo: anObject [
	anObject selectorNodeUnhoveredEvent: self
]
