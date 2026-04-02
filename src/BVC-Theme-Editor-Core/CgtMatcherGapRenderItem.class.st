"
#Matcher Gap Render Item
I represent one compacted hidden gap in the custom selector widget. I am responsible for carrying the gap identity, hidden count, and reveal direction for a single hidden section.
"
Class {
	#name : 'CgtMatcherGapRenderItem',
	#superclass : 'CgtMatcherRenderItem',
	#instVars : [
		'gapIdentity',
		'hiddenCount',
		'direction'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtMatcherGapRenderItem >> initialize [
	super initialize.
	self kind: #gap.
	hiddenCount := 0.
]

{ #category : 'accessing' }
CgtMatcherGapRenderItem >> direction [
	^ direction
]

{ #category : 'accessing' }
CgtMatcherGapRenderItem >> direction: aSymbol [
	direction := aSymbol.
	^ self
]

{ #category : 'accessing' }
CgtMatcherGapRenderItem >> gapIdentity [
	^ gapIdentity
]

{ #category : 'accessing' }
CgtMatcherGapRenderItem >> gapIdentity: anObject [
	gapIdentity := anObject.
	^ self
]

{ #category : 'accessing' }
CgtMatcherGapRenderItem >> hiddenCount [
	^ hiddenCount
]

{ #category : 'accessing' }
CgtMatcherGapRenderItem >> hiddenCount: anInteger [
	hiddenCount := anInteger.
	^ self
]

{ #category : 'testing' }
CgtMatcherGapRenderItem >> isGapItem [
	^ true
]

{ #category : 'accessing' }
CgtMatcherGapRenderItem >> renderKey [
	^ Array with: self kind with: gapIdentity with: direction
]
