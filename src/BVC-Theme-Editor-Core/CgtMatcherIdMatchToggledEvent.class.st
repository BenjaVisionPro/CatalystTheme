"
#Matcher Id Match Toggled Event
I announce that the id-match toggle for a matcher projection node was changed in the matcher widget. I carry the projection node and the requested boolean state.
"
Class {
	#name : 'CgtMatcherIdMatchToggledEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'projectionNode',
		'shouldMatch'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtMatcherIdMatchToggledEvent >> projectionNode [
	^ projectionNode
]

{ #category : 'accessing' }
CgtMatcherIdMatchToggledEvent >> projectionNode: aCgtMatcherProjectionNode [
	projectionNode := aCgtMatcherProjectionNode
]

{ #category : 'accessing' }
CgtMatcherIdMatchToggledEvent >> shouldMatch [
	^ shouldMatch
]

{ #category : 'accessing' }
CgtMatcherIdMatchToggledEvent >> shouldMatch: aBoolean [
	shouldMatch := aBoolean
]

{ #category : 'sending' }
CgtMatcherIdMatchToggledEvent >> sendTo: anObject [
	anObject matcherIdMatchToggledEvent: self
]
