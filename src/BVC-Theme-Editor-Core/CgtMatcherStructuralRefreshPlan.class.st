"
#Matcher Structural Refresh Plan
I describe the non-semantic animation plan for one selector renderer structural refresh. I capture the transition kind, the anchor projection node to keep visually stable, and the starting reveal offset to apply for the refreshed graph.
"
Class {
	#name : 'CgtMatcherStructuralRefreshPlan',
	#superclass : 'Object',
	#instVars : [
		'transitionKind',
		'anchorProjectionNode',
		'revealOffset'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtMatcherStructuralRefreshPlan >> transitionKind [
	^ transitionKind ifNil: [ #stable ]
]

{ #category : 'accessing' }
CgtMatcherStructuralRefreshPlan >> transitionKind: aSymbol [
	transitionKind := aSymbol.
	^ self
]

{ #category : 'accessing' }
CgtMatcherStructuralRefreshPlan >> anchorProjectionNode [
	^ anchorProjectionNode
]

{ #category : 'accessing' }
CgtMatcherStructuralRefreshPlan >> anchorProjectionNode: aProjectionNode [
	anchorProjectionNode := aProjectionNode.
	^ self
]

{ #category : 'accessing' }
CgtMatcherStructuralRefreshPlan >> revealOffset [
	^ revealOffset ifNil: [ 0 @ 0 ]
]

{ #category : 'accessing' }
CgtMatcherStructuralRefreshPlan >> revealOffset: aPoint [
	revealOffset := aPoint ifNil: [ 0 @ 0 ].
	^ self
]

{ #category : 'testing' }
CgtMatcherStructuralRefreshPlan >> isReveal [
	^ self transitionKind = #reveal
]

{ #category : 'testing' }
CgtMatcherStructuralRefreshPlan >> isCollapse [
	^ self transitionKind = #collapse
]


{ #category : 'testing' }
CgtMatcherStructuralRefreshPlan >> isReplace [
	^ self transitionKind = #replace
]

{ #category : 'testing' }
CgtMatcherStructuralRefreshPlan >> isStable [
	^ self transitionKind = #stable
]
