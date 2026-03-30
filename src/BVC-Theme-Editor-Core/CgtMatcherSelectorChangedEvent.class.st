"
#Matcher Selector Changed Event
I announce that the matcher widget produced an updated selector from the current matcher projection state. I carry the projection and the recomposed selector.
"
Class {
	#name : 'CgtMatcherSelectorChangedEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'projection',
		'selector'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtMatcherSelectorChangedEvent >> projection [
	^ projection
]

{ #category : 'accessing' }
CgtMatcherSelectorChangedEvent >> projection: aCgtMatcherProjection [
	projection := aCgtMatcherProjection
]

{ #category : 'accessing' }
CgtMatcherSelectorChangedEvent >> selector [
	^ selector
]

{ #category : 'accessing' }
CgtMatcherSelectorChangedEvent >> selector: aCgtThemeSelector [
	selector := aCgtThemeSelector
]

{ #category : 'sending' }
CgtMatcherSelectorChangedEvent >> sendTo: anObject [
	anObject matcherSelectorChangedEvent: self
]
