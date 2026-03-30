"
#Matcher Projection Node
I represent one passive node in the matcher projection. I am responsible for carrying editor-facing matcher data derived from a rule and hierarchy, without knowing about rendering or editor control flow.
"
Class {
	#name : 'CgtMatcherProjectionNode',
	#superclass : 'Object',
	#instVars : [
		'kind',
		'representedElements',
		'className',
		'elementId',
		'inCurrentRule',
		'inOtherRule',
		'matchByClass',
		'matchById',
		'hiddenNodeCount',
		'editable'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'instance creation' }
CgtMatcherProjectionNode class >> kind: aSymbol [
	^ self new
		kind: aSymbol;
		yourself
]

{ #category : 'initialization' }
CgtMatcherProjectionNode >> initialize [
	super initialize.
	representedElements := OrderedCollection new.
	inCurrentRule := false.
	inOtherRule := false.
	matchByClass := false.
	matchById := false.
	hiddenNodeCount := 0.
	editable := true
]

{ #category : 'accessing' }
CgtMatcherProjectionNode >> kind [
	^ kind
]

{ #category : 'accessing' }
CgtMatcherProjectionNode >> kind: aSymbol [
	kind := aSymbol.
	^ self
]

{ #category : 'accessing' }
CgtMatcherProjectionNode >> representedElements [
	^ representedElements copy
]

{ #category : 'accessing' }
CgtMatcherProjectionNode >> representedElements: aCollection [
	representedElements := aCollection asOrderedCollection.
	^ self
]

{ #category : 'accessing' }
CgtMatcherProjectionNode >> representedElement [
	^ representedElements ifEmpty: [ nil ] ifNotEmpty: [ representedElements first ]
]

{ #category : 'accessing' }
CgtMatcherProjectionNode >> representedElement: anElement [
	self representedElements: (anElement ifNil: [ #() ] ifNotNil: [ Array with: anElement ]).
	anElement ifNil: [
		className := nil.
		elementId := nil.
		^ self ].
	className := anElement class name.
	elementId := anElement id.
	^ self
]

{ #category : 'accessing' }
CgtMatcherProjectionNode >> className [
	^ className
]

{ #category : 'accessing' }
CgtMatcherProjectionNode >> className: aString [
	className := aString.
	^ self
]

{ #category : 'accessing' }
CgtMatcherProjectionNode >> elementId [
	^ elementId
]

{ #category : 'accessing' }
CgtMatcherProjectionNode >> elementId: anElementId [
	elementId := anElementId.
	^ self
]

{ #category : 'accessing' }
CgtMatcherProjectionNode >> isInCurrentRule [
	^ inCurrentRule
]

{ #category : 'accessing' }
CgtMatcherProjectionNode >> isInCurrentRule: aBoolean [
	inCurrentRule := aBoolean.
	^ self
]

{ #category : 'accessing' }
CgtMatcherProjectionNode >> isInOtherRule [
	^ inOtherRule
]

{ #category : 'accessing' }
CgtMatcherProjectionNode >> isInOtherRule: aBoolean [
	inOtherRule := aBoolean.
	^ self
]

{ #category : 'accessing' }
CgtMatcherProjectionNode >> matchByClass [
	^ matchByClass
]

{ #category : 'accessing' }
CgtMatcherProjectionNode >> matchByClass: aBoolean [
	matchByClass := aBoolean.
	^ self
]

{ #category : 'accessing' }
CgtMatcherProjectionNode >> matchById [
	^ matchById
]

{ #category : 'accessing' }
CgtMatcherProjectionNode >> matchById: aBoolean [
	matchById := aBoolean.
	^ self
]

{ #category : 'accessing' }
CgtMatcherProjectionNode >> hiddenNodeCount [
	^ hiddenNodeCount
]

{ #category : 'accessing' }
CgtMatcherProjectionNode >> hiddenNodeCount: anInteger [
	hiddenNodeCount := anInteger.
	^ self
]


{ #category : 'testing' }
CgtMatcherProjectionNode >> isCompactedSection [
	^ kind = #compactedSection
]

{ #category : 'accessing' }
CgtMatcherProjectionNode >> isEditable [
	^ editable
]

{ #category : 'accessing' }
CgtMatcherProjectionNode >> isEditable: aBoolean [
	editable := aBoolean.
	^ self
]
