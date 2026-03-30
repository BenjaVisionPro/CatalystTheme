"
#Matcher Combinator Changed Event
I announce that the matcher combinator relation for a projection edge was changed in the matcher widget. I carry the relation and the requested combinator.
"
Class {
	#name : 'CgtMatcherCombinatorChangedEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'relation',
		'combinator'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtMatcherCombinatorChangedEvent >> relation [
	^ relation
]

{ #category : 'accessing' }
CgtMatcherCombinatorChangedEvent >> relation: aCgtMatcherProjectionRelation [
	relation := aCgtMatcherProjectionRelation
]

{ #category : 'accessing' }
CgtMatcherCombinatorChangedEvent >> combinator [
	^ combinator
]

{ #category : 'accessing' }
CgtMatcherCombinatorChangedEvent >> combinator: aSymbol [
	combinator := aSymbol
]

{ #category : 'sending' }
CgtMatcherCombinatorChangedEvent >> sendTo: anObject [
	anObject matcherCombinatorChangedEvent: self
]
