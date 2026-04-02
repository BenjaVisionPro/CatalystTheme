
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
	^ BlInsets top: 10 right: 14 bottom: 10 left: 14
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> widgetCellSpacing [
	^ 10
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> nodePadding [
	^ BlInsets top: 10 right: 18 bottom: 12 left: 16
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> nodeCellSpacing [
	^ 2
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
	^ 520
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> scopeNodeWidth [
	^ 460
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> contextNodeWidth [
	^ 430
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> compactedGapWidth [
	^ 28
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> rowLeadingInset [
	^ 8
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> classChipWidth [
	^ 452
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> idChipWidth [
	^ 452
]


{ #category : 'layout' }
CgtMatcherLayoutPolicy >> chipMinimumWidth [
	^ 220
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> chipHorizontalPadding [
	^ 0
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> chipVerticalPadding [
	^ 0
]
