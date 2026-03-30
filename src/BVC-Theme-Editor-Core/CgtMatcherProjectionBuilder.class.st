"
#Matcher Projection Builder
I build editor-facing matcher projections from a pure style rule, the current hierarchy, and a selected element. I am responsible for deriving a passive projection without pushing editor or rendering behavior into the selector domain.
"
Class {
	#name : 'CgtMatcherProjectionBuilder',
	#superclass : 'Object',
	#instVars : [
		'styleRule',
		'selectedElement',
		'hierarchyRoot'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'instance creation' }
CgtMatcherProjectionBuilder class >> projectionForStyleRule: aCgtThemeStyleRule selectedElement: anElement hierarchyRoot: aHierarchyRoot [
	^ self new
		styleRule: aCgtThemeStyleRule;
		selectedElement: anElement;
		hierarchyRoot: aHierarchyRoot;
		buildProjection
]

{ #category : 'accessing' }
CgtMatcherProjectionBuilder >> styleRule: aCgtThemeStyleRule [
	styleRule := aCgtThemeStyleRule.
	^ self
]

{ #category : 'accessing' }
CgtMatcherProjectionBuilder >> selectedElement: anElement [
	selectedElement := anElement.
	^ self
]

{ #category : 'accessing' }
CgtMatcherProjectionBuilder >> hierarchyRoot: anElement [
	hierarchyRoot := anElement.
	^ self
]

{ #category : 'building' }
CgtMatcherProjectionBuilder >> buildProjection [
	| projection matchedElements |
	projection := CgtMatcherProjection new.
	projection styleRule: styleRule.
	projection selectedElement: selectedElement.
	projection hierarchyRoot: hierarchyRoot.
	matchedElements := self matchedElementsForSelectedElement.
	matchedElements
		ifNil: [ self addFallbackSelectedNodeTo: projection ]
		ifNotNil: [ self addMatchedElements: matchedElements toProjection: projection ].
	^ projection
]

{ #category : 'building' }
CgtMatcherProjectionBuilder >> addFallbackSelectedNodeTo: aProjection [
	selectedElement ifNil: [ ^ aProjection ].
	aProjection addNode: ((CgtMatcherProjectionNode kind: #selectedElement)
		representedElement: selectedElement;
		isInCurrentRule: false;
		yourself).
	^ aProjection
]

{ #category : 'building' }
CgtMatcherProjectionBuilder >> addMatchedElements: matchedElements toProjection: aProjection [
	| steps selectedIndex previousDisplayNode |
	steps := CgtThemeSelectorDecomposer stepsForSelector: styleRule selector.
	selectedIndex := matchedElements indexOf: selectedElement ifAbsent: [ 0 ].
	1 to: matchedElements size do: [ :anIndex |
		| element node |
		element := matchedElements at: anIndex.
		node := self nodeForMatchedElement: element atIndex: anIndex selectedIndex: selectedIndex step: (steps at: anIndex).
		aProjection addNode: node.
		previousDisplayNode
			ifNil: [ previousDisplayNode := node ]
			ifNotNil: [ previousDisplayNode := self connectPreviousDisplayNode: previousDisplayNode toCurrentNode: node betweenMatchedElementsAtIndex: anIndex matchedElements: matchedElements steps: steps projection: aProjection ] ]
]

{ #category : 'building' }
CgtMatcherProjectionBuilder >> connectPreviousDisplayNode: aPreviousDisplayNode toCurrentNode: aCurrentNode betweenMatchedElementsAtIndex: anIndex matchedElements: matchedElements steps: steps projection: aProjection [
	| combinator previousElement currentElement hiddenElements compactedNode |
	combinator := (steps at: anIndex - 1) combinatorToNext.
	previousElement := matchedElements at: anIndex - 1.
	currentElement := matchedElements at: anIndex.
	(combinator = #descendant and: [ (hiddenElements := self elementsBetweenAncestor: previousElement andDescendant: currentElement) notEmpty ]) ifTrue: [
		compactedNode := self compactedNodeForElements: hiddenElements.
		aProjection addNode: compactedNode.
		aProjection addRelation: (CgtMatcherProjectionRelation from: aPreviousDisplayNode to: compactedNode kind: #compaction).
		aProjection addRelation: ((CgtMatcherProjectionRelation from: compactedNode to: aCurrentNode kind: #matcher)
			combinator: combinator;
			yourself).
		^ aCurrentNode ].
	aProjection addRelation: ((CgtMatcherProjectionRelation from: aPreviousDisplayNode to: aCurrentNode kind: #matcher)
		combinator: combinator;
		yourself).
	^ aCurrentNode
]

{ #category : 'building' }
CgtMatcherProjectionBuilder >> compactedNodeForElements: aCollection [
	^ (CgtMatcherProjectionNode kind: #compactedSection)
		representedElements: aCollection;
		hiddenNodeCount: aCollection size;
		isEditable: false;
		yourself
]

{ #category : 'building' }
CgtMatcherProjectionBuilder >> nodeForMatchedElement: anElement atIndex: anIndex selectedIndex: aSelectedIndex step: aSelectorStep [
	| node |
	node := CgtMatcherProjectionNode kind: (self kindForMatchedNodeAtIndex: anIndex selectedIndex: aSelectedIndex).
	node representedElement: anElement.
	node isInCurrentRule: true.
	node isInOtherRule: false.
	node isEditable: true.
	node matchByClass: (self step: aSelectorStep includesPredicateOfClass: CgtThemeClassPredicate).
	node matchById: (self step: aSelectorStep includesPredicateOfClass: CgtThemeIdPredicate).
	^ node
]

{ #category : 'building' }
CgtMatcherProjectionBuilder >> kindForMatchedNodeAtIndex: anIndex selectedIndex: aSelectedIndex [
	aSelectedIndex = 0 ifTrue: [ ^ #otherRuleRelated ].
	anIndex < aSelectedIndex ifTrue: [ ^ #upstreamScope ].
	anIndex = aSelectedIndex ifTrue: [ ^ #selectedElement ].
	^ #downstreamScope
]

{ #category : 'matching' }
CgtMatcherProjectionBuilder >> matchedElementsForSelectedElement [
	| steps matchingIndexes |
	selectedElement ifNil: [ ^ nil ].
	styleRule ifNil: [ ^ nil ].
	styleRule selector ifNil: [ ^ nil ].
	steps := CgtThemeSelectorDecomposer stepsForSelector: styleRule selector.
	steps ifEmpty: [ ^ nil ].
	matchingIndexes := OrderedCollection new.
	steps doWithIndex: [ :eachStep :anIndex |
		(eachStep simpleSelector matchesElement: selectedElement)
			ifTrue: [ matchingIndexes add: anIndex ] ].
	matchingIndexes reverseDo: [ :eachIndex |
		| matched |
		matched := self matchedElementsForSelectedElementAtStepIndex: eachIndex steps: steps.
		matched ifNotNil: [ ^ matched ] ].
	^ nil
]

{ #category : 'matching' }
CgtMatcherProjectionBuilder >> matchedElementsForSelectedElementAtStepIndex: anIndex steps: steps [
	| prefix suffix |
	prefix := self prefixMatchEndingAt: selectedElement stepIndex: anIndex steps: steps.
	prefix ifNil: [ ^ nil ].
	suffix := self suffixMatchStartingAt: selectedElement stepIndex: anIndex steps: steps.
	suffix ifNil: [ ^ nil ].
	^ (prefix allButLast), suffix
]

{ #category : 'matching' }
CgtMatcherProjectionBuilder >> prefixMatchEndingAt: anElement previousStepIndex: aPreviousIndex combinator: aSymbol steps: steps [
	aSymbol = #child ifTrue: [
		| prefix |
		anElement parent ifNil: [ ^ nil ].
		prefix := self prefixMatchEndingAt: anElement parent stepIndex: aPreviousIndex steps: steps.
		prefix ifNil: [ ^ nil ].
		^ prefix, (OrderedCollection with: anElement) ].
	aSymbol = #descendant ifTrue: [
		| currentAncestor |
		currentAncestor := anElement parent.
		[currentAncestor notNil] whileTrue: [
			| prefix |
			prefix := self prefixMatchEndingAt: currentAncestor stepIndex: aPreviousIndex steps: steps.
			prefix ifNotNil: [ ^ prefix, (OrderedCollection with: anElement) ].
			currentAncestor := currentAncestor parent ].
		^ nil ].
	^ nil
]

{ #category : 'matching' }
CgtMatcherProjectionBuilder >> prefixMatchEndingAt: anElement stepIndex: anIndex steps: steps [
	anElement ifNil: [ ^ nil ].
	((steps at: anIndex) simpleSelector matchesElement: anElement) ifFalse: [ ^ nil ].
	anIndex = 1 ifTrue: [ ^ OrderedCollection with: anElement ].
	^ self prefixMatchEndingAt: anElement previousStepIndex: anIndex - 1 combinator: ((steps at: anIndex - 1) combinatorToNext) steps: steps
]

{ #category : 'matching' }
CgtMatcherProjectionBuilder >> suffixMatchStartingAt: anElement stepIndex: anIndex steps: steps [
	| combinator candidates |
	anElement ifNil: [ ^ nil ].
	((steps at: anIndex) simpleSelector matchesElement: anElement) ifFalse: [ ^ nil ].
	anIndex = steps size ifTrue: [ ^ OrderedCollection with: anElement ].
	combinator := (steps at: anIndex) combinatorToNext.
	candidates := combinator = #child
		ifTrue: [ self childrenOf: anElement ]
		ifFalse: [ self descendantsOf: anElement ].
	candidates do: [ :eachCandidate |
		| suffix |
		suffix := self suffixMatchStartingAt: eachCandidate stepIndex: anIndex + 1 steps: steps.
		suffix ifNotNil: [ ^ (OrderedCollection with: anElement), suffix ] ].
	^ nil
]

{ #category : 'private' }
CgtMatcherProjectionBuilder >> childrenOf: anElement [
	^ anElement children
]

{ #category : 'private' }
CgtMatcherProjectionBuilder >> descendantsOf: anElement [
	| descendants |
	descendants := OrderedCollection new.
	(self childrenOf: anElement) do: [ :eachChild |
		descendants add: eachChild.
		descendants addAll: (self descendantsOf: eachChild) ].
	^ descendants
]

{ #category : 'private' }
CgtMatcherProjectionBuilder >> elementsBetweenAncestor: anAncestor andDescendant: aDescendant [
	| elements current |
	elements := OrderedCollection new.
	current := aDescendant parent.
	[current notNil and: [ current ~~ anAncestor ]] whileTrue: [
		elements addFirst: current.
		current := current parent ].
	^ current == anAncestor ifTrue: [ elements ] ifFalse: [ OrderedCollection new ]
]

{ #category : 'testing' }
CgtMatcherProjectionBuilder >> step: aSelectorStep includesPredicateOfClass: aClass [
	^ aSelectorStep simpleSelector predicates anySatisfy: [ :each | each isKindOf: aClass ]
]
