"
#Matcher Node Visual Policy
I centralize the explicit visual language for matcher projection nodes. I am responsible for mapping passive matcher node state to presentation-oriented labels, colors, and render ordering without taking on widget or editor semantics.
"
Class {
	#name : 'CgtMatcherNodeVisualPolicy',
	#superclass : 'Object',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'rendering' }
CgtMatcherNodeVisualPolicy >> backgroundForNode: aProjectionNode [
	aProjectionNode kind = #selectedElement ifTrue: [ ^ Color veryVeryLightGray ].
	aProjectionNode kind = #compactedSection ifTrue: [ ^ (Color gray alpha: 0.12) ].
	aProjectionNode isInOtherRule ifTrue: [ ^ (Color orange alpha: 0.12) ].
	^ (Color white alpha: 0.95)
]

{ #category : 'rendering' }
CgtMatcherNodeVisualPolicy >> borderForNode: aProjectionNode [
	aProjectionNode kind = #selectedElement ifTrue: [ ^ BlBorder paint: (Color black alpha: 0.25) width: 2 ].
	aProjectionNode kind = #compactedSection ifTrue: [ ^ BlBorder paint: (Color gray alpha: 0.35) width: 1 ].
	aProjectionNode isInOtherRule ifTrue: [ ^ BlBorder paint: (Color orange alpha: 0.45) width: 1 ].
	^ BlBorder paint: (Color gray alpha: 0.3)
]

{ #category : 'rendering' }
CgtMatcherNodeVisualPolicy >> titleForNode: aProjectionNode [
	^ aProjectionNode kind = #compactedSection
		ifTrue: [ self compactedTitleForNode: aProjectionNode ]
		ifFalse: [ aProjectionNode className ifNil: [ 'Unspecified element' ] ]
]

{ #category : 'rendering' }
CgtMatcherNodeVisualPolicy >> compactedTitleForNode: aProjectionNode [
	^ aProjectionNode hiddenNodeCount asString , ' hidden node' , (aProjectionNode hiddenNodeCount = 1 ifTrue: [ '' ] ifFalse: [ 's' ])
]

{ #category : 'rendering' }
CgtMatcherNodeVisualPolicy >> elementIdTextForNode: aProjectionNode [
	aProjectionNode kind = #compactedSection ifTrue: [ ^ 'Compacted section' ].
	^ aProjectionNode elementId
		ifNil: [ 'No element id' ]
		ifNotNil: [ '#' , aProjectionNode elementId asString ]
]

{ #category : 'rendering' }
CgtMatcherNodeVisualPolicy >> roleLabelForNode: aProjectionNode [
	aProjectionNode kind = #selectedElement ifTrue: [ ^ 'Selected' ].
	aProjectionNode kind = #upstreamScope ifTrue: [ ^ 'Scope' ].
	aProjectionNode kind = #downstreamScope ifTrue: [ ^ 'Scope' ].
	aProjectionNode kind = #compactedSection ifTrue: [ ^ 'Between' ].
	aProjectionNode kind = #otherRuleRelated ifTrue: [ ^ 'Other rule' ].
	^ aProjectionNode kind asString
]

{ #category : 'rendering' }
CgtMatcherNodeVisualPolicy >> matchSummaryForNode: aProjectionNode [
	aProjectionNode isCompactedSection ifTrue: [ ^ 'Context only' ].
	(aProjectionNode matchByClass and: [ aProjectionNode matchById ]) ifTrue: [ ^ 'Class + id' ].
	aProjectionNode matchByClass ifTrue: [ ^ 'Class' ].
	aProjectionNode matchById ifTrue: [ ^ 'Id' ].
	^ aProjectionNode isEditable
		ifTrue: [ 'Choose class or id' ]
		ifFalse: [ 'Context only' ]
]

{ #category : 'rendering' }
CgtMatcherNodeVisualPolicy >> nodeSortPriorityFor: aProjectionNode [
	aProjectionNode kind = #upstreamScope ifTrue: [ ^ 10 ].
	aProjectionNode kind = #selectedElement ifTrue: [ ^ 20 ].
	aProjectionNode kind = #downstreamScope ifTrue: [ ^ 30 ].
	aProjectionNode kind = #compactedSection ifTrue: [ ^ 40 ].
	aProjectionNode kind = #otherRuleRelated ifTrue: [ ^ 50 ].
	^ 100
]
