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

{ #category : 'instance creation' }
CgtElementPath class >> anchorElement: anElement [
	^ self new
		anchorElement: anElement;
		yourself
]

{ #category : 'accessing' }
CgtElementPath >> addElement: anElement [
	(self includesElement: anElement) ifTrue: [ ^ self ].
	nodes add: (CgtElementPathNode element: anElement)
]

{ #category : 'accessing' }
CgtElementPath >> anchorElement [
	(anchorIndex between: 1 and: nodes size)
		ifFalse: [ ^ nil ].
	^ (nodes at: anchorIndex) element
]

{ #category : 'accessing' }
CgtElementPath >> anchorElement: anElement [
	nodes := OrderedCollection with: (CgtElementPathNode element: anElement).
	anchorIndex := 1
]

{ #category : 'accessing' }
CgtElementPath >> anchorIndex [
	^ anchorIndex
]

{ #category : 'accessing' }
CgtElementPath >> anchorIndex: anInteger [
	anchorIndex := anInteger
]

{ #category : 'accessing' }
CgtElementPath >> elements [
	^ nodes collect: [ :eachNode | eachNode element ]
]

{ #category : 'testing' }
CgtElementPath >> includesElement: anElement [
	^ nodes anySatisfy: [ :eachNode | eachNode element == anElement ]
]

{ #category : 'initialization' }
CgtElementPath >> initialize [
	super initialize.
	nodes := OrderedCollection new.
	anchorIndex := 0
]

{ #category : 'accessing' }
CgtElementPath >> nodes [
	^ nodes
]

{ #category : 'accessing' }
CgtElementPath >> nodes: aCollection [
	nodes := aCollection asOrderedCollection
]

{ #category : 'removing' }
CgtElementPath >> removeElement: anElement [
	| anIndex |
	anIndex := nodes findFirst: [ :eachNode | eachNode element == anElement ] ifAbsent: [ ^ self ].
	nodes removeAt: anIndex.
	anchorIndex > anIndex ifTrue: [ anchorIndex := anchorIndex - 1 ].
	nodes isEmpty ifTrue: [ anchorIndex := 0 ].
	(anchorIndex = 0 and: [ nodes notEmpty ]) ifTrue: [ anchorIndex := 1 ]
]
