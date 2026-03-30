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
	| ruleNodes startNode ordered visited |
	ruleNodes := aCgtMatcherProjection nodes select: [ :each |
		each isInCurrentRule and: [ each kind ~= #compactedSection ] ].
	ruleNodes isEmpty ifTrue: [ ^ #() ].
	startNode := self startingCurrentRuleNodeIn: ruleNodes projection: aCgtMatcherProjection.
	ordered := OrderedCollection new.
	visited := IdentitySet new.
	self appendCurrentRulePathFrom: startNode into: ordered visited: visited projection: aCgtMatcherProjection.
	ruleNodes do: [ :each |
		(visited includes: each) ifFalse: [ ordered add: each ] ].
	^ ordered
]

{ #category : 'composing' }
CgtMatcherProjectionSelectorComposer >> startingCurrentRuleNodeIn: aCollection projection: aCgtMatcherProjection [
	^ aCollection
		detect: [ :each |
			(aCgtMatcherProjection relationsToNode: each)
				noneSatisfy: [ :aRelation | aRelation fromNode isInCurrentRule ] ]
		ifNone: [ aCollection first ]
]

{ #category : 'composing' }
CgtMatcherProjectionSelectorComposer >> appendCurrentRulePathFrom: aNode into: anOrderedCollection visited: aVisitedSet projection: aCgtMatcherProjection [
	| nextRelation nextNode |
	aNode ifNil: [ ^ self ].
	(aVisitedSet includes: aNode) ifTrue: [ ^ self ].
	aVisitedSet add: aNode.
	anOrderedCollection add: aNode.
	nextRelation := (aCgtMatcherProjection relationsFromNode: aNode)
		detect: [ :each |
			each toNode isInCurrentRule
				or: [ self pathFrom: each toNode reachesCurrentRuleNodeIn: aCgtMatcherProjection avoiding: aVisitedSet ] ]
		ifNone: [ nil ].
	nextRelation ifNil: [ ^ self ].
	nextNode := self nextCurrentRuleNodeFrom: nextRelation toNode inProjection: aCgtMatcherProjection avoiding: aVisitedSet.
	self appendCurrentRulePathFrom: nextNode into: anOrderedCollection visited: aVisitedSet projection: aCgtMatcherProjection
]

{ #category : 'composing' }
CgtMatcherProjectionSelectorComposer >> nextCurrentRuleNodeFrom: aNode inProjection: aCgtMatcherProjection avoiding: aVisitedSet [
	aNode ifNil: [ ^ nil ].
	aNode isInCurrentRule ifTrue: [ ^ aNode ].
	^ (aCgtMatcherProjection relationsFromNode: aNode)
		inject: nil
		into: [ :found :each |
			found ifNotNil: [ found ] ifNil: [ self nextCurrentRuleNodeFrom: each toNode inProjection: aCgtMatcherProjection avoiding: aVisitedSet ] ]
]

{ #category : 'composing' }
CgtMatcherProjectionSelectorComposer >> pathFrom: aNode reachesCurrentRuleNodeIn: aCgtMatcherProjection avoiding: aVisitedSet [
	| localVisited queue |
	aNode ifNil: [ ^ false ].
	localVisited := aVisitedSet copy.
	queue := OrderedCollection with: aNode.
	[ queue isEmpty ] whileFalse: [
		| current |
		current := queue removeFirst.
		(localVisited includes: current) ifFalse: [
			current isInCurrentRule ifTrue: [ ^ true ].
			localVisited add: current.
			(aCgtMatcherProjection relationsFromNode: current) do: [ :each | queue addLast: each toNode ] ] ].
	^ false
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
	| fromNode toNode |
	anIndex = aCollection size ifTrue: [ ^ nil ].
	fromNode := aCollection at: anIndex.
	toNode := aCollection at: anIndex + 1.
	^ self combinatorFrom: fromNode toNextCurrentRuleNode: toNode inProjection: aCgtMatcherProjection
]

{ #category : 'composing' }
CgtMatcherProjectionSelectorComposer >> combinatorFrom: aFromNode toNextCurrentRuleNode: aToNode inProjection: aCgtMatcherProjection [
	| queue visited |
	queue := OrderedCollection with: aFromNode.
	visited := IdentitySet with: aFromNode.
	[ queue isEmpty ] whileFalse: [
		| current outgoing |
		current := queue removeFirst.
		outgoing := aCgtMatcherProjection relationsFromNode: current.
		outgoing do: [ :eachRelation |
			| nextNode |
			nextNode := eachRelation toNode.
			nextNode == aToNode ifTrue: [
				^ eachRelation combinator ifNil: [ #child ] ifNotNil: [ eachRelation combinator ] ].
			(visited includes: nextNode) ifFalse: [
				visited add: nextNode.
				queue addLast: nextNode ] ] ].
	^ #child
]
