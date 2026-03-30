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
CgtMatcherLayoutPolicy >> widgetPadding [
	^ BlInsets all: 6
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> widgetCellSpacing [
	^ 6
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> nodePadding [
	^ BlInsets top: 5 right: 6 bottom: 5 left: 6
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> nodeCellSpacing [
	^ 3
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> nodeWidth [
	^ 165
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> badgePadding [
	^ BlInsets top: 1 right: 4 bottom: 1 left: 4
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> compactButtonPaddingScale [
	^ 0.45
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> compactButtonHeightScale [
	^ 0.72
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> compactButtonCornerRadius [
	^ 4
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> legendPadding [
	^ BlInsets top: 3 right: 5 bottom: 3 left: 5
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> legendCellSpacing [
	^ 2
]

{ #category : 'layout' }
CgtMatcherLayoutPolicy >> popoverMatcherHeight [
	^ 230
]
