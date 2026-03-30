"
#Matcher Layout Policy
I centralize the functional layout constants for the matcher editor. I am responsible for keeping sizing, spacing, and scroll constraints explicit so visual cleanup does not leak ad-hoc numbers across the widget tree.
"
Class {
	#name : 'CgtMatcherLayoutPolicy',
	#superclass : 'Object',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> corridorOrientation [
	^ #horizontal
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> widgetPadding [
	^ BlInsets all: 8
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> widgetCellSpacing [
	^ 8
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> nodePadding [
	^ BlInsets all: 6
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> nodeCellSpacing [
	^ 4
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> nodeWidth [
	^ 180
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> legendPadding [
	^ BlInsets top: 4 right: 6 bottom: 4 left: 6
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> legendCellSpacing [
	^ 3
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> popoverMatcherHeight [
	^ 260
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> treeHorizontalGap [
	^ 22
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> treeVerticalGap [
	^ 12
]


{ #category : 'layout' }
CgtMatcherLayoutPolicy >> showsLegendByDefault [
	^ false
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> widthForNode: aProjectionNode [
	aProjectionNode ifNil: [ ^ self nodeWidth ].
	aProjectionNode kind = #selectedElement ifTrue: [ ^ self selectedNodeWidth ].
	(aProjectionNode isInCurrentRule or: [ aProjectionNode kind = #upstreamScope or: [ aProjectionNode kind = #downstreamScope ] ]) ifTrue: [ ^ self scopeNodeWidth ].
	^ self contextNodeWidth
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> selectedNodeWidth [
	^ 196
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> scopeNodeWidth [
	^ 168
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> contextNodeWidth [
	^ 148
]
