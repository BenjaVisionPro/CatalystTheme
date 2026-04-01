"
#Matcher Projection
I represent the editor-facing matcher projection derived from a selector rule and a live hierarchy context. I am responsible for holding passive projection nodes and relations without taking on editor or rendering behavior.
"
Class {
	#name : 'CgtMatcherProjection',
	#superclass : 'Object',
	#instVars : [
		'styleRule',
		'selectedElement',
		'hierarchyRoot',
		'relatedStyleRules',
		'visibilityState',
		'nodes',
		'relations'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtMatcherProjection >> initialize [
	super initialize.
	relatedStyleRules := OrderedCollection new.
	nodes := OrderedCollection new.
	relations := OrderedCollection new
]

{ #category : 'accessing' }
CgtMatcherProjection >> styleRule [
	^ styleRule
]

{ #category : 'accessing' }
CgtMatcherProjection >> styleRule: aCgtThemeStyleRule [
	styleRule := aCgtThemeStyleRule
]

{ #category : 'accessing' }
CgtMatcherProjection >> selectedElement [
	^ selectedElement
]

{ #category : 'accessing' }
CgtMatcherProjection >> selectedElement: anElement [
	selectedElement := anElement
]

{ #category : 'accessing' }
CgtMatcherProjection >> hierarchyRoot [
	^ hierarchyRoot
]


{ #category : 'accessing' }
CgtMatcherProjection >> relatedStyleRules [
	^ relatedStyleRules copy
]


{ #category : 'accessing' }
CgtMatcherProjection >> visibilityState [
	^ visibilityState ifNil: [ visibilityState := CgtMatcherVisibilityState new ]
]

{ #category : 'accessing' }
CgtMatcherProjection >> visibilityState: aCgtMatcherVisibilityState [
	visibilityState := aCgtMatcherVisibilityState ifNil: [ CgtMatcherVisibilityState new ]
]

{ #category : 'accessing' }
CgtMatcherProjection >> relatedStyleRules: aCollection [
	relatedStyleRules := (aCollection ifNil: [ #() ]) asOrderedCollection
]

{ #category : 'accessing' }
CgtMatcherProjection >> hierarchyRoot: anElement [
	hierarchyRoot := anElement
]

{ #category : 'accessing' }
CgtMatcherProjection >> nodes [
	^ nodes copy
]

{ #category : 'accessing' }
CgtMatcherProjection >> relations [
	^ relations copy
]

{ #category : 'adding' }
CgtMatcherProjection >> addNode: aCgtMatcherProjectionNode [
	nodes add: aCgtMatcherProjectionNode.
	^ aCgtMatcherProjectionNode
]

{ #category : 'adding' }
CgtMatcherProjection >> addRelation: aCgtMatcherProjectionRelation [
	relations add: aCgtMatcherProjectionRelation.
	^ aCgtMatcherProjectionRelation
]


{ #category : 'removing' }
CgtMatcherProjection >> removeNode: aCgtMatcherProjectionNode [
	nodes remove: aCgtMatcherProjectionNode ifAbsent: [ ].
	^ aCgtMatcherProjectionNode
]

{ #category : 'removing' }
CgtMatcherProjection >> removeRelation: aCgtMatcherProjectionRelation [
	relations remove: aCgtMatcherProjectionRelation ifAbsent: [ ].
	^ aCgtMatcherProjectionRelation
]

{ #category : 'querying' }
CgtMatcherProjection >> relationsFromNode: aCgtMatcherProjectionNode [
	^ relations select: [ :each | each fromNode == aCgtMatcherProjectionNode ]
]

{ #category : 'querying' }
CgtMatcherProjection >> relationsToNode: aCgtMatcherProjectionNode [
	^ relations select: [ :each | each toNode == aCgtMatcherProjectionNode ]
]



{ #category : 'querying' }
CgtMatcherProjection >> leadingCompactedProjectionNode [
	^ nodes
		detect: [ :each |
			each isCompactedSection
				and: [ (self relationsToNode: each) isEmpty
					and: [ (self relationsFromNode: each) anySatisfy: [ :aRelation | aRelation kind = #compaction ] ] ] ]
		ifNone: [ nil ]
]

{ #category : 'querying' }
CgtMatcherProjection >> trailingCompactedProjectionNode [
	^ nodes
		detect: [ :each |
			each isCompactedSection
				and: [ (self relationsFromNode: each) isEmpty
					and: [ (self relationsToNode: each) anySatisfy: [ :aRelation | aRelation kind = #compaction ] ] ] ]
		ifNone: [ nil ]
]


{ #category : 'querying' }
CgtMatcherProjection >> leadingCompactedGapIdentity [
	^ self leadingCompactedProjectionNode
		ifNil: [ nil ]
		ifNotNil: [ :aNode | aNode gapIdentity ]
]

{ #category : 'querying' }
CgtMatcherProjection >> trailingCompactedGapIdentity [
	^ self trailingCompactedProjectionNode
		ifNil: [ nil ]
		ifNotNil: [ :aNode | aNode gapIdentity ]
]

{ #category : 'querying' }
CgtMatcherProjection >> hasLeadingCompactedProjectionNode [
	^ self leadingCompactedProjectionNode notNil
]

{ #category : 'querying' }
CgtMatcherProjection >> followingProjectionNodeAfterLeadingCompaction [
	| leadingNode relation |
	leadingNode := self leadingCompactedProjectionNode.
	leadingNode ifNil: [ ^ nil ].
	relation := (self relationsFromNode: leadingNode)
		detect: [ :aRelation | aRelation kind = #compaction ]
		ifNone: [ nil ].
	^ relation ifNil: [ nil ] ifNotNil: [ relation toNode ]
]


{ #category : 'querying' }
CgtMatcherProjection >> upstreamScopeNodes [
	^ self nodesOfKind: #upstreamScope
]

{ #category : 'querying' }
CgtMatcherProjection >> selectedChildScopeNodes [
	^ self nodesOfKind: #selectedChildScope
]

{ #category : 'querying' }
CgtMatcherProjection >> selectedChildScopeNode [
	^ self selectedChildScopeNodes
		ifEmpty: [ nil ]
		ifNotEmpty: [ :nodes | nodes first ]
]

{ #category : 'querying' }
CgtMatcherProjection >> compactedSectionNodes [
	^ self nodesOfKind: #compactedSection
]

{ #category : 'querying' }
CgtMatcherProjection >> otherRuleIndicatorNodes [
	^ self nodesOfKind: #otherRuleIndicator
]

{ #category : 'querying' }
CgtMatcherProjection >> otherRuleIndicatorNode [
	^ self otherRuleIndicatorNodes
		ifEmpty: [ nil ]
		ifNotEmpty: [ :nodes | nodes first ]
]

{ #category : 'querying' }
CgtMatcherProjection >> visibleCorridorNodes [
	^ nodes select: [ :each |
		(#(#upstreamScope #selectedElement #selectedChildScope #compactedSection) includes: each kind) ]
]

{ #category : 'querying' }
CgtMatcherProjection >> relationsOfKind: aSymbol [
	^ relations select: [ :each | each kind = aSymbol ]
]

{ #category : 'querying' }
CgtMatcherProjection >> matcherRelations [
	^ self relationsOfKind: #matcher
]

{ #category : 'querying' }
CgtMatcherProjection >> compactionRelations [
	^ self relationsOfKind: #compaction
]

{ #category : 'querying' }
CgtMatcherProjection >> otherRuleRelations [
	^ self relationsOfKind: #otherRule
]

{ #category : 'querying' }
CgtMatcherProjection >> contextRelations [
	^ self relationsOfKind: #context
]

{ #category : 'querying' }
CgtMatcherProjection >> visibleCorridorRelations [
	^ relations select: [ :each | each kind ~= #otherRule ]
]

{ #category : 'querying' }
CgtMatcherProjection >> relationFromNode: aFromNode toNode: aToNode [
	^ relations
		detect: [ :each | each fromNode == aFromNode and: [ each toNode == aToNode ] ]
		ifNone: [ nil ]
]

{ #category : 'querying' }
CgtMatcherProjection >> selectedProjectionNode [
	^ nodes
		detect: [ :each | each kind = #selectedElement and: [ each representedElement == selectedElement ] ]
		ifNone: [
			nodes detect: [ :each | each kind = #selectedElement ] ifNone: [ nil ] ]
]

{ #category : 'querying' }
CgtMatcherProjection >> currentRuleNodes [
	^ nodes select: [ :each | each isInCurrentRule ]
]

{ #category : 'querying' }
CgtMatcherProjection >> otherRuleNodes [
	^ nodes select: [ :each | each isInOtherRule ]
]

{ #category : 'querying' }
CgtMatcherProjection >> nodesOfKind: aSymbol [
	^ nodes select: [ :each | each kind = aSymbol ]
]
