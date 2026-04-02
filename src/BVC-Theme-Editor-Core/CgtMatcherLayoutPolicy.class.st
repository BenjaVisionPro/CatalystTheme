
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
	^ BlInsets top: 5 right: 12 bottom: 6 left: 12
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> nodeCellSpacing [
	^ 0
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
	^ 250
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> scopeNodeWidth [
	^ 250
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> contextNodeWidth [
	^ 250
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
	^ self chipMinimumWidth
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> idChipWidth [
	^ self chipMinimumWidth
]


{ #category : 'layout' }
CgtMatcherLayoutPolicy >> chipMinimumWidth [
	^ 250
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> chipHorizontalPadding [
	^ 0
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> chipVerticalPadding [
	^ 0
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> rowCornerRadius [
	^ 28
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> rowCellSpacing [
	^ 8
]
