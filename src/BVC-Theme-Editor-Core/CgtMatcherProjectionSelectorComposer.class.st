"
#Matcher Projection Selector Composer
I compose a pure theme selector from the current-rule nodes and matcher relations in a matcher projection. I am responsible for turning editor-facing matcher projection state back into a selector without introducing editor knowledge into the selector model.
"
Class {
	#name : 'CgtMatcherProjectionSelectorComposer',
	#superclass : 'Object',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'instance creation' }
CgtMatcherProjectionSelectorComposer class >> selectorForProjection: aCgtMatcherProjection [
	^ self new selectorForProjection: aCgtMatcherProjection
]

{ #category : 'composing' }
CgtMatcherProjectionSelectorComposer >> selectorForProjection: aCgtMatcherProjection [
	| currentRuleNodes steps |
	aCgtMatcherProjection ifNil: [ ^ nil ].
	currentRuleNodes := self orderedCurrentRuleNodesForProjection: aCgtMatcherProjection.
	currentRuleNodes ifEmpty: [ ^ nil ].
	steps := OrderedCollection new.
	currentRuleNodes doWithIndex: [ :eachNode :anIndex |
		steps add: (CgtThemeSelectorStep
			simpleSelector: (self simpleSelectorForProjectionNode: eachNode)
			combinatorToNext: (self combinatorAfterNodeAtIndex: anIndex inNodes: currentRuleNodes projection: aCgtMatcherProjection)) ].
	^ CgtThemeSelectorComposer selectorFromSteps: steps
]

{ #category : 'composing' }
CgtMatcherProjectionSelectorComposer >> orderedCurrentRuleNodesForProjection: aCgtMatcherProjection [
	^ aCgtMatcherProjection nodes select: [ :each |
		each isInCurrentRule and: [ each kind ~= #compactedSection ] ]
]

{ #category : 'composing' }
CgtMatcherProjectionSelectorComposer >> simpleSelectorForProjectionNode: aCgtMatcherProjectionNode [
	| selector element |
	selector := CgtThemeSimpleSelector new.
	element := aCgtMatcherProjectionNode representedElement.
	(aCgtMatcherProjectionNode matchByClass and: [ element notNil ]) ifTrue: [
		selector addPredicate: (CgtThemeClassPredicate elementClass: element class) ].
	(aCgtMatcherProjectionNode matchById
		and: [ element notNil and: [ element id ~= BlElementId noId ] ]) ifTrue: [
		selector addPredicate: (CgtThemeIdPredicate elementId: element id) ].
	^ selector
]

{ #category : 'composing' }
CgtMatcherProjectionSelectorComposer >> combinatorAfterNodeAtIndex: anIndex inNodes: aCollection projection: aCgtMatcherProjection [
	| fromNode toNode relation |
	anIndex = aCollection size ifTrue: [ ^ nil ].
	fromNode := aCollection at: anIndex.
	toNode := aCollection at: anIndex + 1.
	relation := aCgtMatcherProjection relations
		detect: [ :each |
			each kind = #matcher
				and: [ each fromNode == fromNode and: [ each toNode == toNode ] ] ]
		ifNone: [ nil ].
	^ relation
		ifNil: [ #child ]
		ifNotNil: [ relation combinator ifNil: [ #child ] ifNotNil: [ relation combinator ] ]
]
