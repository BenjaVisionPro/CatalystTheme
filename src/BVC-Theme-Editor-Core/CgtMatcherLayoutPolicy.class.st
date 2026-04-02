"
#Matcher Layout Policy
I centralize the functional layout constants for the matcher editor. I am responsible for keeping sizing, spacing, corridor orientation, and connection direction explicit so visual cleanup does not leak ad-hoc numbers across the widget tree.
"
Class {
	#name : 'CgtMatcherLayoutPolicy',
	#superclass : 'Object',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> corridorOrientation [
	^ #vertical
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> edgeConnectionSelectorsForOrientation: anOrientation [
	anOrientation = #horizontal ifTrue: [ ^ #(fromCenterRight toCenterLeft) ].
	^ #(fromCenterBottom toCenterTop)
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
CgtMatcherLayoutPolicy >> selectedNodeWidth [
	^ 220
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> scopeNodeWidth [
	^ 190
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> contextNodeWidth [
	^ 156
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> compactedGapWidth [
	^ 132
]



{ #category : 'layout' }
CgtMatcherLayoutPolicy >> relationControlDiameter [
	^ 24
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> gapHandleWidth [
	^ 34
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> gapHandleHeight [
	^ 10
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> chipMinimumWidth [
	^ 56
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> chipHorizontalPadding [
	^ 8
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> chipVerticalPadding [
	^ 4
]
