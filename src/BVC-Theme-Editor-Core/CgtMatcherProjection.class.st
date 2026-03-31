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
