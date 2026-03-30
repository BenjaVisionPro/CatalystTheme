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
CgtMatcherVisibilityStateTests >> testExpandedGapIsTrackedByRepresentedElements [
	| first second state |
	first := Object new.
	second := Object new.
	state := CgtMatcherVisibilityState new.
	self deny: (state isExpandedForElements: { first. second }).
	state expandElements: { first. second }.
	self assert: (state isExpandedForElements: { first. second })
]

{ #category : 'tests' }
CgtMatcherVisibilityStateTests >> testClearExpandedGapsRemovesExpansionState [
	| first second state |
	first := Object new.
	second := Object new.
	state := CgtMatcherVisibilityState new.
	state expandElements: { first. second }.
	state clearExpandedGaps.
	self deny: (state isExpandedForElements: { first. second })
]
