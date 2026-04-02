"
#Matcher Row Render Item
I represent one visible matcher row for the custom selector widget. I am responsible for carrying the projection node and its rendering state without knowing how the row is drawn or edited.
"
Class {
	#name : 'CgtMatcherRowRenderItem',
	#superclass : 'CgtMatcherRenderItem',
	#instVars : [
		'projectionNode',
		'incomingRelation',
		'isSelected',
		'isCurrentRule',
		'isOtherRule',
		'isInScope',
		'isRevealedContext'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtMatcherRowRenderItem >> initialize [
	super initialize.
	self kind: #row.
	isSelected := false.
	isCurrentRule := false.
	isOtherRule := false.
	isInScope := false.
	isRevealedContext := false
]

{ #category : 'accessing' }
CgtMatcherRowRenderItem >> incomingRelation [
	^ incomingRelation
]

{ #category : 'accessing' }
CgtMatcherRowRenderItem >> incomingRelation: aCgtMatcherProjectionRelation [
	incomingRelation := aCgtMatcherProjectionRelation.
	^ self
]

{ #category : 'testing' }
CgtMatcherRowRenderItem >> isCurrentRule [
	^ isCurrentRule
]

{ #category : 'accessing' }
CgtMatcherRowRenderItem >> isCurrentRule: aBoolean [
	isCurrentRule := aBoolean.
	^ self
]

{ #category : 'testing' }
CgtMatcherRowRenderItem >> isOtherRule [
	^ isOtherRule
]

{ #category : 'accessing' }
CgtMatcherRowRenderItem >> isOtherRule: aBoolean [
	isOtherRule := aBoolean.
	^ self
]


{ #category : 'testing' }
CgtMatcherRowRenderItem >> isInScope [
	^ isInScope
]

{ #category : 'accessing' }
CgtMatcherRowRenderItem >> isInScope: aBoolean [
	isInScope := aBoolean.
	^ self
]

{ #category : 'testing' }
CgtMatcherRowRenderItem >> isRevealedContext [
	^ isRevealedContext
]

{ #category : 'accessing' }
CgtMatcherRowRenderItem >> isRevealedContext: aBoolean [
	isRevealedContext := aBoolean.
	^ self
]

{ #category : 'testing' }
CgtMatcherRowRenderItem >> isRowItem [
	^ true
]

{ #category : 'testing' }
CgtMatcherRowRenderItem >> isSelected [
	^ isSelected
]

{ #category : 'accessing' }
CgtMatcherRowRenderItem >> isSelected: aBoolean [
	isSelected := aBoolean.
	^ self
]

{ #category : 'accessing' }
CgtMatcherRowRenderItem >> projectionNode [
	^ projectionNode
]

{ #category : 'accessing' }
CgtMatcherRowRenderItem >> projectionNode: aCgtMatcherProjectionNode [
	projectionNode := aCgtMatcherProjectionNode.
	^ self
]

{ #category : 'accessing' }
CgtMatcherRowRenderItem >> renderKey [
	| keyPart |
	keyPart := projectionNode ifNil: [ nil ] ifNotNil: [
		projectionNode gapIdentity ifNotNil: [ projectionNode gapIdentity ] ifNil: [
			projectionNode representedElement ifNotNil: [ projectionNode representedElement ] ifNil: [
				Array with: projectionNode kind with: projectionNode className with: projectionNode elementId ] ] ].
	^ Array with: self kind with: keyPart
]
