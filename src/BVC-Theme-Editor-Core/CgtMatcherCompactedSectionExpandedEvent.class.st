"
#Matcher Compacted Section Expanded Event
I announce that a compacted matcher section was explicitly expanded in the matcher widget. I carry the compacted projection node so the widget/editor can reveal the hidden contextual nodes explicitly.
"
Class {
	#name : 'CgtMatcherCompactedSectionExpandedEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'projectionNode'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtMatcherCompactedSectionExpandedEvent >> projectionNode [
	^ projectionNode
]

{ #category : 'accessing' }
CgtMatcherCompactedSectionExpandedEvent >> projectionNode: aCgtMatcherProjectionNode [
	projectionNode := aCgtMatcherProjectionNode
]

{ #category : 'sending' }
CgtMatcherCompactedSectionExpandedEvent >> sendTo: anObject [
	anObject matcherCompactedSectionExpandedEvent: self
]
