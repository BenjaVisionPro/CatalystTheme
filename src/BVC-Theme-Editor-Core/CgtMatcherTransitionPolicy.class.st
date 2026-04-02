"
#Matcher Transition Policy
I provide timing and motion policy for matcher structural transitions. I am responsible for reveal/collapse animation values, orientation-aware leading-side expansion semantics, and structural refresh anchor decisions, not for matcher semantics.
"
Class {
	#name : 'CgtMatcherTransitionPolicy',
	#superclass : 'Object',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> structuralRefreshDuration [
	^ 220 milliSeconds
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> hoverDuration [
	^ 140 milliSeconds
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> revealDuration [
	^ 240 milliSeconds
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> collapseDuration [
	^ 200 milliSeconds
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> replaceDuration [
	^ 220 milliSeconds
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> graphRevealOffsetForOrientation: anOrientation [
	anOrientation = #horizontal ifTrue: [ ^ -24 @ 0 ].
	^ 0 @ -24
]



{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> structuralRefreshDurationForPlan: aStructuralRefreshPlan [
	aStructuralRefreshPlan ifNil: [ ^ self structuralRefreshDuration ].
	aStructuralRefreshPlan isReveal ifTrue: [ ^ self revealDuration ].
	aStructuralRefreshPlan isCollapse ifTrue: [ ^ self collapseDuration ].
	aStructuralRefreshPlan isReplace ifTrue: [ ^ self replaceDuration ].
	^ self structuralRefreshDuration
]



{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> shouldAnimateStructuralRefreshPlan: aStructuralRefreshPlan [
	aStructuralRefreshPlan ifNil: [ ^ false ].
	^ aStructuralRefreshPlan isStable not
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> structuralRefreshStartOpacityForPlan: aStructuralRefreshPlan [
	aStructuralRefreshPlan ifNil: [ ^ self graphRevealStartOpacity ].
	(aStructuralRefreshPlan isStable or: [ aStructuralRefreshPlan isReplace ]) ifTrue: [ ^ self graphRevealEndOpacity ].
	^ self graphRevealStartOpacity
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> structuralRefreshEndOpacityForPlan: aStructuralRefreshPlan [
	^ self graphRevealEndOpacity
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> graphRevealStartOpacity [
	^ 0.0
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> graphRevealEndOpacity [
	^ 1.0
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> keepsFollowingNodeFixed [
	^ true
]

{ #category : 'accessing' }
CgtMatcherTransitionPolicy >> leadingExpansionSideForOrientation: anOrientation [
	anOrientation = #horizontal ifTrue: [ ^ #left ].
	^ #up
]







{ #category : 'querying' }
CgtMatcherTransitionPolicy >> structuralRefreshTransitionKindFrom: anOldProjection to: aNewProjection [
	| oldLeadingNode newLeadingNode oldLeadingGapIdentity newLeadingGapIdentity oldHasLeadingReveal newHasLeadingReveal |
	(aNewProjection notNil and: [ anOldProjection isNil ]) ifTrue: [
		^ ((aNewProjection hasLeadingCompactedProjectionNode)
			or: [ self hasLeadingRevealedContextIn: aNewProjection ])
			ifTrue: [ #reveal ]
			ifFalse: [ #stable ] ].
	(anOldProjection isNil or: [ aNewProjection isNil ]) ifTrue: [ ^ #stable ].
	oldLeadingNode := anOldProjection leadingCompactedProjectionNode.
	newLeadingNode := aNewProjection leadingCompactedProjectionNode.
	(oldLeadingNode isNil and: [ newLeadingNode notNil ]) ifTrue: [ ^ #reveal ].
	(oldLeadingNode notNil and: [ newLeadingNode isNil ]) ifTrue: [ ^ #collapse ].
	oldHasLeadingReveal := self hasLeadingRevealedContextIn: anOldProjection.
	newHasLeadingReveal := self hasLeadingRevealedContextIn: aNewProjection.
	(oldHasLeadingReveal not and: [ newHasLeadingReveal ]) ifTrue: [ ^ #reveal ].
	(oldHasLeadingReveal and: [ newHasLeadingReveal not ]) ifTrue: [ ^ #collapse ].
	oldLeadingGapIdentity := oldLeadingNode ifNil: [ nil ] ifNotNil: [ oldLeadingNode gapIdentity ].
	newLeadingGapIdentity := newLeadingNode ifNil: [ nil ] ifNotNil: [ newLeadingNode gapIdentity ].
	oldLeadingGapIdentity = newLeadingGapIdentity ifTrue: [ ^ #stable ].
	(newLeadingGapIdentity notNil and: [ oldLeadingGapIdentity notNil ]) ifTrue: [ ^ #replace ].
	newLeadingGapIdentity notNil ifTrue: [ ^ #reveal ].
	^ #collapse
]

{ #category : 'querying' }
CgtMatcherTransitionPolicy >> hasLeadingRevealedContextIn: aProjection [
	| current relation previous |
	aProjection ifNil: [ ^ false ].
	current := aProjection selectedProjectionNode.
	current ifNil: [ ^ false ].
	[relation := (aProjection visibleCorridorRelations
		detect: [ :each | each toNode == current ]
		ifNone: [ nil ]).
	relation notNil] whileTrue: [
		previous := relation fromNode.
		(previous isCompactedSection not
			and: [ previous isOtherRuleIndicator not
				and: [ previous isInCurrentRule not ] ]) ifTrue: [ ^ true ].
		current := previous ].
	^ false
]

{ #category : 'querying' }
CgtMatcherTransitionPolicy >> structuralRefreshPlanFrom: anOldProjection to: aNewProjection orientation: anOrientation [
	| plan transitionKind |
	plan := CgtMatcherStructuralRefreshPlan new.
	plan anchorProjectionNode: (self structuralRefreshAnchorProjectionNodeFor: aNewProjection).
	transitionKind := self
		structuralRefreshTransitionKindFrom: anOldProjection
		to: aNewProjection.
	plan transitionKind: transitionKind.
	plan revealOffset: (self
		structuralRefreshRevealOffsetForTransitionKind: transitionKind
		oldProjection: anOldProjection
		newProjection: aNewProjection
		orientation: anOrientation).
	^ plan
]

{ #category : 'querying' }
CgtMatcherTransitionPolicy >> structuralRefreshAnchorProjectionNodeFor: aProjection [
	aProjection ifNil: [ ^ nil ].
	^ aProjection followingProjectionNodeAfterLeadingCompaction
		ifNil: [ aProjection selectedProjectionNode ]
]

{ #category : 'querying' }
CgtMatcherTransitionPolicy >> structuralRefreshRevealOffsetForProjection: aProjection orientation: anOrientation [
	aProjection ifNil: [ ^ 0 @ 0 ].
	self keepsFollowingNodeFixed ifFalse: [
		^ self graphRevealOffsetForOrientation: anOrientation ].
	^ aProjection hasLeadingCompactedProjectionNode
		ifTrue: [ self graphRevealOffsetForOrientation: anOrientation ]
		ifFalse: [ 0 @ 0 ]
]

{ #category : 'querying' }
CgtMatcherTransitionPolicy >> structuralRefreshRevealOffsetForTransitionKind: aTransitionKind oldProjection: anOldProjection newProjection: aNewProjection orientation: anOrientation [
	aTransitionKind = #reveal ifTrue: [
		anOldProjection ifNil: [ ^ self structuralRefreshRevealOffsetForProjection: aNewProjection orientation: anOrientation ].
		^ self graphRevealOffsetForOrientation: anOrientation ].
	aTransitionKind = #collapse ifTrue: [ ^ (self graphRevealOffsetForOrientation: anOrientation) negated ].
	aTransitionKind = #replace ifTrue: [ ^ self graphRevealOffsetForOrientation: anOrientation ].
	^ 0 @ 0
]
