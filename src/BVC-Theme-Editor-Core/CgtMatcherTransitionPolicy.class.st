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
CgtMatcherTransitionPolicy >> structuralRefreshPlanFrom: anOldProjection to: aNewProjection orientation: anOrientation [
	| plan offset oldLeadingNode newLeadingNode oldLeadingGapIdentity newLeadingGapIdentity |
	plan := CgtMatcherStructuralRefreshPlan new.
	plan anchorProjectionNode: (self structuralRefreshAnchorProjectionNodeFor: aNewProjection).
	offset := 0 @ 0.
	(aNewProjection notNil and: [ anOldProjection isNil ]) ifTrue: [
		offset := self structuralRefreshRevealOffsetForProjection: aNewProjection orientation: anOrientation.
		plan transitionKind: ((offset = (0 @ 0)) ifTrue: [ #stable ] ifFalse: [ #reveal ]).
		plan revealOffset: offset.
		^ plan ].
	(anOldProjection isNil or: [ aNewProjection isNil ]) ifTrue: [
		plan transitionKind: #stable.
		plan revealOffset: offset.
		^ plan ].
	oldLeadingNode := anOldProjection leadingCompactedProjectionNode.
	newLeadingNode := aNewProjection leadingCompactedProjectionNode.
	(oldLeadingNode isNil and: [ newLeadingNode notNil ]) ifTrue: [
		plan transitionKind: #reveal.
		plan revealOffset: (self graphRevealOffsetForOrientation: anOrientation).
		^ plan ].
	(oldLeadingNode notNil and: [ newLeadingNode isNil ]) ifTrue: [
		plan transitionKind: #collapse.
		plan revealOffset: (self graphRevealOffsetForOrientation: anOrientation) negated.
		^ plan ].
	oldLeadingGapIdentity := oldLeadingNode ifNil: [ nil ] ifNotNil: [ oldLeadingNode gapIdentity ].
	newLeadingGapIdentity := newLeadingNode ifNil: [ nil ] ifNotNil: [ newLeadingNode gapIdentity ].
	oldLeadingGapIdentity = newLeadingGapIdentity
		ifTrue: [
			plan transitionKind: #stable.
			plan revealOffset: offset ]
		ifFalse: [
			(newLeadingGapIdentity notNil and: [ oldLeadingGapIdentity notNil ])
				ifTrue: [
					plan transitionKind: #replace.
					offset := self graphRevealOffsetForOrientation: anOrientation ]
				ifFalse: [
					newLeadingGapIdentity notNil
						ifTrue: [
							plan transitionKind: #reveal.
							offset := self graphRevealOffsetForOrientation: anOrientation ]
						ifFalse: [
							plan transitionKind: #collapse.
							offset := (self graphRevealOffsetForOrientation: anOrientation) negated ] ].
			plan revealOffset: offset ].
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
