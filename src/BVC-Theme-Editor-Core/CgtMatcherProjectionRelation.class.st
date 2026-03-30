"
#Matcher Projection Relation
I represent one explicit structural relation between matcher projection nodes. I am responsible for making graph structure first-class instead of leaving it implicit in rendering.
"
Class {
	#name : 'CgtMatcherProjectionRelation',
	#superclass : 'Object',
	#instVars : [
		'fromNode',
		'toNode',
		'kind',
		'combinator'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'instance creation' }
CgtMatcherProjectionRelation class >> from: aFromNode to: aToNode kind: aSymbol [
	^ self new
		fromNode: aFromNode;
		toNode: aToNode;
		kind: aSymbol;
		yourself
]

{ #category : 'accessing' }
CgtMatcherProjectionRelation >> fromNode [
	^ fromNode
]

{ #category : 'accessing' }
CgtMatcherProjectionRelation >> fromNode: aCgtMatcherProjectionNode [
	fromNode := aCgtMatcherProjectionNode
]

{ #category : 'accessing' }
CgtMatcherProjectionRelation >> toNode [
	^ toNode
]

{ #category : 'accessing' }
CgtMatcherProjectionRelation >> toNode: aCgtMatcherProjectionNode [
	toNode := aCgtMatcherProjectionNode
]

{ #category : 'accessing' }
CgtMatcherProjectionRelation >> kind [
	^ kind
]

{ #category : 'accessing' }
CgtMatcherProjectionRelation >> kind: aSymbol [
	kind := aSymbol
]

{ #category : 'accessing' }
CgtMatcherProjectionRelation >> combinator [
	^ combinator
]

{ #category : 'accessing' }
CgtMatcherProjectionRelation >> combinator: aSymbol [
	combinator := aSymbol
]
