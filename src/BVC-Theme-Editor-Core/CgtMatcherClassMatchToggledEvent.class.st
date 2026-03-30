"
#Matcher Class Match Toggled Event
I announce that the class-match toggle for a matcher projection node was changed in the matcher widget. I carry the projection node and the requested boolean state.
"
Class {
	#name : 'CgtMatcherClassMatchToggledEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'projectionNode',
		'shouldMatch'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtMatcherClassMatchToggledEvent >> projectionNode [
	^ projectionNode
]

{ #category : 'accessing' }
CgtMatcherClassMatchToggledEvent >> projectionNode: aCgtMatcherProjectionNode [
	projectionNode := aCgtMatcherProjectionNode
]

{ #category : 'accessing' }
CgtMatcherClassMatchToggledEvent >> shouldMatch [
	^ shouldMatch
]

{ #category : 'accessing' }
CgtMatcherClassMatchToggledEvent >> shouldMatch: aBoolean [
	shouldMatch := aBoolean
]

{ #category : 'sending' }
CgtMatcherClassMatchToggledEvent >> sendTo: anObject [
	anObject matcherClassMatchToggledEvent: self
]
