"
#Matcher Visibility State Tests
"
Class {
	#name : 'CgtMatcherVisibilityStateTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtMatcherVisibilityStateTests >> testExpandedGapIsTrackedByGapIdentity [
	| state gapIdentity |
	state := CgtMatcherVisibilityState new.
	gapIdentity := #(#root #middle).
	self deny: (state isExpandedForGapIdentity: gapIdentity).
	state expandGapIdentity: gapIdentity.
	self assert: (state isExpandedForGapIdentity: gapIdentity)
]

{ #category : 'tests' }
CgtMatcherVisibilityStateTests >> testClearExpandedGapsRemovesExpansionState [
	| state gapIdentity |
	state := CgtMatcherVisibilityState new.
	gapIdentity := #(#root #middle).
	state expandGapIdentity: gapIdentity.
	state clearExpandedGaps.
	self deny: (state isExpandedForGapIdentity: gapIdentity)
]


{ #category : 'tests' }
CgtMatcherVisibilityStateTests >> testElementBasedTrackingStillMapsToGapIdentity [
	| first second state gapIdentity |
	first := CgtThemeSelectorTestElement new.
	first id: (BlElementId named: #first).
	second := CgtThemeSelectorTestElement new.
	second id: (BlElementId named: #second).
	state := CgtMatcherVisibilityState new.
	gapIdentity := state gapIdentityForElements: { first. second }.
	state expandElements: { first. second }.
	self assert: (state isExpandedForGapIdentity: gapIdentity)
]
