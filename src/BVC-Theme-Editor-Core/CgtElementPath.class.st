Class {
	#name : 'CgtElementPath',
	#superclass : 'Object',
	#instVars : [
		'nodes',
		'anchorIndex'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtElementPath >> initialize [
	super initialize.
	nodes := OrderedCollection new.
	anchorIndex := 0
]

{ #category : 'instance creation' }
CgtElementPath class >> anchorElement: anElement [
	^ self new anchorElement: anElement; yourself
]

{ #category : 'accessing' }
CgtElementPath >> nodes [
	^ nodes copy
]

{ #category : 'accessing' }
CgtElementPath >> nodes: aCollection [
	nodes := aCollection asOrderedCollection
]

{ #category : 'accessing' }
CgtElementPath >> anchorIndex [ ^ anchorIndex ]

{ #category : 'accessing' }
CgtElementPath >> anchorIndex: anInteger [ anchorIndex := anInteger ]

{ #category : 'accessing' }
CgtElementPath >> anchorNode [
	(anchorIndex between: 1 and: nodes size) ifFalse: [ ^ nil ].
	^ nodes at: anchorIndex
]

{ #category : 'accessing' }
CgtElementPath >> anchorElement [
	^ self anchorNode ifNotNil: #element
]

{ #category : 'accessing' }
CgtElementPath >> anchorElement: anElement [
	nodes := OrderedCollection with: (CgtElementPathNode on: anElement).
	anchorIndex := 1
]

{ #category : 'testing' }
CgtElementPath >> isEmpty [ ^ nodes isEmpty ]

{ #category : 'accessing' }
CgtElementPath >> elements [ ^ nodes collect: #element ]

{ #category : 'accessing' }
CgtElementPath >> upstreamNodes [
	anchorIndex <= 1 ifTrue: [ ^ #() ].
	^ nodes copyFrom: 1 to: anchorIndex - 1
]

{ #category : 'accessing' }
CgtElementPath >> upstreamElements [ ^ self upstreamNodes collect: #element ]

{ #category : 'accessing' }
CgtElementPath >> selectedChildScopeNode [
	anchorIndex >= nodes size ifTrue: [ ^ nil ].
	^ nodes at: anchorIndex + 1
]

{ #category : 'accessing' }
CgtElementPath >> selectedChildScopeElement [
	^ self selectedChildScopeNode ifNotNil: #element
]

{ #category : 'testing' }
CgtElementPath >> includesElement: anElement [ ^ (self nodeForElement: anElement) notNil ]

{ #category : 'accessing' }
CgtElementPath >> nodeForElement: anElement [
	^ nodes detect: [ :each | each element == anElement ] ifNone: [ nil ]
]

{ #category : 'accessing' }
CgtElementPath >> indexOfElement: anElement [
	^ nodes findFirst: [ :each | each element == anElement ]
]

{ #category : 'testing' }
CgtElementPath >> isAnchorElement: anElement [ ^ self anchorElement == anElement ]

{ #category : 'accessing' }
CgtElementPath >> relationOfElementToAnchor: anElement [
	| anIndex |
	anIndex := self indexOfElement: anElement.
	anIndex = 0 ifTrue: [ ^ nil ].
	anIndex < anchorIndex ifTrue: [ ^ #upstream ].
	anIndex > anchorIndex ifTrue: [ ^ #downstream ].
	^ #anchor
]

{ #category : 'actions' }
CgtElementPath >> clearSelectedChildScope [
	nodes := (nodes copyFrom: 1 to: anchorIndex) asOrderedCollection
]

{ #category : 'actions' }
CgtElementPath >> toggleUpstreamElement: anElement [
	| ancestors ordered selectedChildScope anchor current includedUpstream |
	anchor := self anchorElement.
	anchor ifNil: [ ^ self ].
	anElement ifNil: [ ^ self ].
	ancestors := OrderedCollection new.
	current := anchor parent.
	[ current notNil ] whileTrue: [ ancestors add: current. current := current parent ].
	(ancestors includes: anElement) ifFalse: [ ^ self ].
	ordered := ancestors reversed.
	selectedChildScope := self selectedChildScopeElement.
	includedUpstream := self upstreamElements asOrderedCollection.
	(includedUpstream includes: anElement)
		ifTrue: [ includedUpstream remove: anElement ifAbsent: [ ] ]
		ifFalse: [ includedUpstream add: anElement ].
	nodes := OrderedCollection new.
	(ordered select: [ :each | includedUpstream includes: each ])
		do: [ :each | nodes add: (CgtElementPathNode on: each) ].
	nodes add: (CgtElementPathNode on: anchor).
	selectedChildScope ifNotNil: [ nodes add: (CgtElementPathNode on: selectedChildScope) ].
	anchorIndex := nodes findFirst: [ :each | each element == anchor ]
]


{ #category : 'actions' }
CgtElementPath >> selectedChildScopeElement: anElement [
	| anchor |
	anchor := self anchorElement.
	(anchor isNil or: [ anElement isNil ]) ifTrue: [ ^ self clearSelectedChildScope ].
	(anElement == anchor or: [ (anElement hasParent: anchor) not ]) ifTrue: [ ^ self ].
	self clearSelectedChildScope.
	nodes add: (CgtElementPathNode on: anElement).
	anchorIndex := nodes findFirst: [ :each | each element == anchor ]
]
