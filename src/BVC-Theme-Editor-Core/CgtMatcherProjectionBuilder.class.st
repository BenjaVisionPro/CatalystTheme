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
		'hierarchyRoot',
		'relatedStyleRules',
		'visibilityState'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'instance creation' }
CgtMatcherProjectionBuilder class >> projectionForStyleRule: aCgtThemeStyleRule selectedElement: anElement hierarchyRoot: aHierarchyRoot [
	^ self
		projectionForStyleRule: aCgtThemeStyleRule
		selectedElement: anElement
		hierarchyRoot: aHierarchyRoot
		relatedStyleRules: #()
]

{ #category : 'instance creation' }
CgtMatcherProjectionBuilder class >> projectionForStyleRule: aCgtThemeStyleRule selectedElement: anElement hierarchyRoot: aHierarchyRoot relatedStyleRules: aCollection [
	^ self
		projectionForStyleRule: aCgtThemeStyleRule
		selectedElement: anElement
		hierarchyRoot: aHierarchyRoot
		relatedStyleRules: aCollection
		visibilityState: CgtMatcherVisibilityState new
]

{ #category : 'instance creation' }
CgtMatcherProjectionBuilder class >> projectionForStyleRule: aCgtThemeStyleRule selectedElement: anElement hierarchyRoot: aHierarchyRoot relatedStyleRules: aCollection visibilityState: aCgtMatcherVisibilityState [
	^ self new
		styleRule: aCgtThemeStyleRule;
		selectedElement: anElement;
		hierarchyRoot: aHierarchyRoot;
		relatedStyleRules: aCollection;
		visibilityState: aCgtMatcherVisibilityState;
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

{ #category : 'accessing' }
CgtMatcherProjectionBuilder >> relatedStyleRules: aCollection [
	relatedStyleRules := (aCollection ifNil: [ #() ]) asOrderedCollection.
	^ self
]

{ #category : 'accessing' }
CgtMatcherProjectionBuilder >> visibilityState: aCgtMatcherVisibilityState [
	visibilityState := aCgtMatcherVisibilityState ifNil: [ CgtMatcherVisibilityState new ].
	^ self
]

{ #category : 'building' }
CgtMatcherProjectionBuilder >> buildProjection [
	| projection matchedElements |
	projection := CgtMatcherProjection new.
	projection styleRule: styleRule.
	projection selectedElement: selectedElement.
	projection hierarchyRoot: hierarchyRoot.
	projection relatedStyleRules: relatedStyleRules.
	projection visibilityState: visibilityState.
	matchedElements := self matchedElementsForStyleRule: styleRule.
	matchedElements
		ifNil: [ self addFallbackSelectedNodeTo: projection ]
		ifNotNil: [ self addMatchedElements: matchedElements selector: styleRule selector toProjection: projection currentRule: true otherRule: false ].
	self addFocusedCorridorGapsTo: projection matchedElements: matchedElements.
	self addOtherRuleContextTo: projection.
	^ projection
]


{ #category : 'building' }
CgtMatcherProjectionBuilder >> addFocusedCorridorGapsTo: aProjection matchedElements: matchedElements [
	| visibleElements firstVisible lastVisible firstNode lastNode leadingElements trailingElements |
	visibleElements := matchedElements
		ifNil: [ selectedElement ifNil: [ #() ] ifNotNil: [ Array with: selectedElement ] ]
		ifNotNil: [ matchedElements ].
	visibleElements ifEmpty: [ ^ aProjection ].
	firstVisible := visibleElements first.
	lastVisible := visibleElements last.
	firstNode := self nodeRepresenting: firstVisible in: aProjection.
	lastNode := self nodeRepresenting: lastVisible in: aProjection.
	leadingElements := self leadingHiddenElementsBefore: firstVisible excluding: visibleElements.
	trailingElements := self trailingHiddenElementsAfter: lastVisible excluding: visibleElements.
	leadingElements ifNotEmpty: [
		self addLeadingCompactedNodeForElements: leadingElements beforeNode: firstNode toProjection: aProjection ].
	trailingElements ifNotEmpty: [
		self addTrailingCompactedNodeForElements: trailingElements afterNode: lastNode toProjection: aProjection ].
	^ aProjection
]

{ #category : 'building' }
CgtMatcherProjectionBuilder >> addLeadingCompactedNodeForElements: aCollection beforeNode: aProjectionNode toProjection: aProjection [
	| compactedNode |
	aProjectionNode ifNil: [ ^ aProjection ].
	compactedNode := self compactedNodeForElements: aCollection.
	aProjection addNode: compactedNode.
	aProjection addRelation: (CgtMatcherProjectionRelation from: compactedNode to: aProjectionNode kind: #compaction).
	^ compactedNode
]

{ #category : 'building' }
CgtMatcherProjectionBuilder >> addTrailingCompactedNodeForElements: aCollection afterNode: aProjectionNode toProjection: aProjection [
	| compactedNode |
	aProjectionNode ifNil: [ ^ aProjection ].
	compactedNode := self compactedNodeForElements: aCollection.
	aProjection addNode: compactedNode.
	aProjection addRelation: (CgtMatcherProjectionRelation from: aProjectionNode to: compactedNode kind: #compaction).
	^ compactedNode
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
CgtMatcherProjectionBuilder >> addMatchedElements: matchedElements selector: aSelector toProjection: aProjection currentRule: isCurrentRule otherRule: isOtherRule [
	| steps selectedIndex previousDisplayNode |
	steps := CgtThemeSelectorDecomposer stepsForSelector: aSelector.
	selectedIndex := matchedElements indexOf: selectedElement ifAbsent: [ 0 ].
	1 to: matchedElements size do: [ :anIndex |
		| element node |
		element := matchedElements at: anIndex.
		node := self
			nodeForMatchedElement: element
			atIndex: anIndex
			selectedIndex: selectedIndex
			step: (steps at: anIndex)
			currentRule: isCurrentRule
			otherRule: isOtherRule
			projection: aProjection.
		node ifNotNil: [
			previousDisplayNode
				ifNil: [
					(aProjection nodes includes: node) ifFalse: [ aProjection addNode: node ].
					previousDisplayNode := node ]
				ifNotNil: [
					previousDisplayNode := self
						connectPreviousDisplayNode: previousDisplayNode
						toCurrentNode: node
						betweenMatchedElementsAtIndex: anIndex
						matchedElements: matchedElements
						steps: steps
						projection: aProjection
						otherRule: isOtherRule ] ] ]
]

{ #category : 'building' }
CgtMatcherProjectionBuilder >> connectPreviousDisplayNode: aPreviousDisplayNode toCurrentNode: aCurrentNode betweenMatchedElementsAtIndex: anIndex matchedElements: matchedElements steps: steps projection: aProjection otherRule: isOtherRule [
	| combinator previousElement currentElement hiddenElements compactedNode |
	combinator := (steps at: anIndex - 1) combinatorToNext.
	previousElement := matchedElements at: anIndex - 1.
	currentElement := matchedElements at: anIndex.
	(combinator = #descendant and: [ (hiddenElements := self elementsBetweenAncestor: previousElement andDescendant: currentElement) notEmpty ]) ifTrue: [
		(self shouldRevealElements: hiddenElements)
			ifTrue: [ ^ self
				addRevealedGapElements: hiddenElements
				between: aPreviousDisplayNode
				and: aCurrentNode
				relationKind: (isOtherRule ifTrue: [ #otherRule ] ifFalse: [ #matcher ])
				combinator: combinator
				toProjection: aProjection ].
		compactedNode := self compactedNodeForElements: hiddenElements.
		aProjection addNode: compactedNode.
		aProjection addRelation: (CgtMatcherProjectionRelation from: aPreviousDisplayNode to: compactedNode kind: #compaction).
		aProjection addRelation: ((CgtMatcherProjectionRelation from: compactedNode to: aCurrentNode kind: (isOtherRule ifTrue: [ #otherRule ] ifFalse: [ #matcher ]))
			combinator: combinator;
			yourself).
		^ aCurrentNode ].
	aProjection addRelation: ((CgtMatcherProjectionRelation from: aPreviousDisplayNode to: aCurrentNode kind: (isOtherRule ifTrue: [ #otherRule ] ifFalse: [ #matcher ]))
		combinator: combinator;
		yourself).
	^ aCurrentNode
]


{ #category : 'private' }
CgtMatcherProjectionBuilder >> shouldRevealElements: aCollection [
	^ visibilityState notNil and: [ visibilityState isExpandedForElements: aCollection ]
]

{ #category : 'building' }
CgtMatcherProjectionBuilder >> addRevealedGapElements: hiddenElements between: aPreviousDisplayNode and: aCurrentNode relationKind: aRelationKind combinator: aCombinator toProjection: aProjection [
	| previousLinkNode revealedNodes |
	revealedNodes := hiddenElements collect: [ :each | self revealedContextNodeForElement: each ].
	revealedNodes do: [ :each | aProjection addNode: each ].
	previousLinkNode := aPreviousDisplayNode.
	revealedNodes do: [ :eachNode |
		aProjection addRelation: (CgtMatcherProjectionRelation from: previousLinkNode to: eachNode kind: #context).
		previousLinkNode := eachNode ].
	aProjection addRelation: ((CgtMatcherProjectionRelation from: previousLinkNode to: aCurrentNode kind: aRelationKind)
		combinator: aCombinator;
		yourself).
	^ aCurrentNode
]

{ #category : 'private' }
CgtMatcherProjectionBuilder >> revealedContextNodeForElement: anElement [
	^ (CgtMatcherProjectionNode kind: (self kindForRevealedContextElement: anElement))
		representedElement: anElement;
		isEditable: true;
		yourself
]

{ #category : 'private' }
CgtMatcherProjectionBuilder >> kindForRevealedContextElement: anElement [
	anElement == selectedElement ifTrue: [ ^ #selectedElement ].
	(self isAncestor: anElement of: selectedElement) ifTrue: [ ^ #upstreamScope ].
	(self isAncestor: selectedElement of: anElement) ifTrue: [ ^ #downstreamScope ].
	^ #otherRuleRelated
]

{ #category : 'private' }
CgtMatcherProjectionBuilder >> isAncestor: aPossibleAncestor of: anElement [
	| current |
	aPossibleAncestor ifNil: [ ^ false ].
	anElement ifNil: [ ^ false ].
	current := anElement parent.
	[current notNil] whileTrue: [
		current == aPossibleAncestor ifTrue: [ ^ true ].
		current := current parent ].
	^ false
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
CgtMatcherProjectionBuilder >> nodeForMatchedElement: anElement atIndex: anIndex selectedIndex: aSelectedIndex step: aSelectorStep currentRule: isCurrentRule otherRule: isOtherRule projection: aProjection [
	| node existingSelectedNode |
	(anElement == selectedElement and: [ isOtherRule ]) ifTrue: [
		existingSelectedNode := self selectedNodeIn: aProjection.
		existingSelectedNode ifNotNil: [
			existingSelectedNode isInOtherRule: true.
			^ existingSelectedNode ] ].
	node := CgtMatcherProjectionNode kind: (self kindForMatchedNodeAtIndex: anIndex selectedIndex: aSelectedIndex).
	node representedElement: anElement.
	node isInCurrentRule: isCurrentRule.
	node isInOtherRule: isOtherRule.
	node isEditable: isCurrentRule.
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

{ #category : 'building' }
CgtMatcherProjectionBuilder >> addOtherRuleContextTo: aProjection [
	(visibilityState notNil and: [ visibilityState showsOtherRuleContext not ]) ifTrue: [ ^ aProjection ].
	relatedStyleRules do: [ :eachRule |
		(eachRule notNil and: [ eachRule ~~ styleRule ]) ifTrue: [
			| matchedElements |
			matchedElements := self matchedElementsForStyleRule: eachRule.
			matchedElements ifNotNil: [
				self
					addMatchedElements: matchedElements
					selector: eachRule selector
					toProjection: aProjection
					currentRule: false
					otherRule: true ] ] ].
	^ aProjection
]

{ #category : 'private' }
CgtMatcherProjectionBuilder >> selectedNodeIn: aProjection [
	^ aProjection nodes
		detect: [ :each | each representedElement == selectedElement and: [ each kind = #selectedElement ] ]
		ifNone: [ nil ]
]

{ #category : 'matching' }
CgtMatcherProjectionBuilder >> matchedElementsForStyleRule: aStyleRule [
	| steps matchingIndexes |
	selectedElement ifNil: [ ^ nil ].
	aStyleRule ifNil: [ ^ nil ].
	aStyleRule selector ifNil: [ ^ nil ].
	steps := CgtThemeSelectorDecomposer stepsForSelector: aStyleRule selector.
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


{ #category : 'private' }
CgtMatcherProjectionBuilder >> leadingHiddenElementsBefore: anElement excluding: visibleElements [
	| elements current |
	elements := OrderedCollection new.
	current := anElement ifNil: [ nil ] ifNotNil: [ anElement parent ].
	[current notNil] whileTrue: [
		(visibleElements includes: current) ifFalse: [ elements addFirst: current ].
		current == hierarchyRoot ifTrue: [ ^ elements ].
		current := current parent ].
	^ elements
]

{ #category : 'private' }
CgtMatcherProjectionBuilder >> trailingHiddenElementsAfter: anElement excluding: visibleElements [
	anElement ifNil: [ ^ OrderedCollection new ].
	^ (self descendantsOf: anElement)
		reject: [ :each | visibleElements includes: each ]
]

{ #category : 'private' }
CgtMatcherProjectionBuilder >> nodeRepresenting: anElement in: aProjection [
	^ aProjection nodes
		detect: [ :each | each representedElement == anElement ]
		ifNone: [ nil ]
]
