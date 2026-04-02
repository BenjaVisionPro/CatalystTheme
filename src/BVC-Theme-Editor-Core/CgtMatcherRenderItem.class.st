"
#Matcher Render Item
I am the abstract linear render item used by the custom selector widget. I am responsible for carrying ordered rendering facts derived from a matcher projection without owning selector semantics or UI behavior.
"
Class {
	#name : 'CgtMatcherRenderItem',
	#superclass : 'Object',
	#instVars : [
		'kind',
		'sortKey'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtMatcherRenderItem >> kind [
	^ kind
]

{ #category : 'accessing' }
CgtMatcherRenderItem >> kind: aSymbol [
	kind := aSymbol.
	^ self
]

{ #category : 'testing' }
CgtMatcherRenderItem >> isGapItem [
	^ false
]

{ #category : 'testing' }
CgtMatcherRenderItem >> isOtherRuleIndicatorItem [
	^ false
]


{ #category : 'testing' }
CgtMatcherRenderItem >> isRevealItem [
	^ false
]

{ #category : 'testing' }
CgtMatcherRenderItem >> isRowItem [
	^ false
]

{ #category : 'accessing' }
CgtMatcherRenderItem >> renderKey [
	^ sortKey ifNil: [ Array with: self class name with: kind ]
]

{ #category : 'accessing' }
CgtMatcherRenderItem >> sortKey [
	^ sortKey
]

{ #category : 'accessing' }
CgtMatcherRenderItem >> sortKey: anObject [
	sortKey := anObject.
	^ self
]
