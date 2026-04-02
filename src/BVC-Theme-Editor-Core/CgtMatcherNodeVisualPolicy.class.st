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
	aProjectionNode kind = #otherRuleIndicator ifTrue: [ ^ (Color orange alpha: 0.08) ].
	aProjectionNode isInOtherRule ifTrue: [ ^ (Color orange alpha: 0.12) ].
	^ (Color white alpha: 0.95)
]

{ #category : 'rendering' }
CgtMatcherNodeVisualPolicy >> borderForNode: aProjectionNode [
	aProjectionNode kind = #selectedElement ifTrue: [ ^ BlBorder paint: (Color black alpha: 0.25) width: 2 ].
	aProjectionNode kind = #compactedSection ifTrue: [ ^ BlBorder paint: (Color gray alpha: 0.35) width: 1 ].
	aProjectionNode kind = #otherRuleIndicator ifTrue: [ ^ BlBorder paint: (Color orange alpha: 0.35) width: 1 ].
	aProjectionNode isInOtherRule ifTrue: [ ^ BlBorder paint: (Color orange alpha: 0.45) width: 1 ].
	^ BlBorder paint: (Color gray alpha: 0.3)
]

{ #category : 'rendering' }
CgtMatcherNodeVisualPolicy >> titleForNode: aProjectionNode [
	aProjectionNode kind = #otherRuleIndicator ifTrue: [ ^ self otherRuleIndicatorTitleForNode: aProjectionNode ].
	^ aProjectionNode kind = #compactedSection
		ifTrue: [ self compactedTitleForNode: aProjectionNode ]
		ifFalse: [ aProjectionNode className ifNil: [ 'Unspecified element' ] ]
]

{ #category : 'rendering' }
CgtMatcherNodeVisualPolicy >> compactedTitleForNode: aProjectionNode [
	^ aProjectionNode hiddenNodeCount asString , ' hidden node' , (aProjectionNode hiddenNodeCount = 1 ifTrue: [ '' ] ifFalse: [ 's' ])
]

{ #category : 'rendering' }
CgtMatcherNodeVisualPolicy >> otherRuleIndicatorTitleForNode: aProjectionNode [
	^ aProjectionNode hiddenNodeCount asString , ' hidden related rule path' , (aProjectionNode hiddenNodeCount = 1 ifTrue: [ '' ] ifFalse: [ 's' ])
]

{ #category : 'rendering' }
CgtMatcherNodeVisualPolicy >> elementIdTextForNode: aProjectionNode [
	aProjectionNode kind = #compactedSection ifTrue: [ ^ 'Compacted section' ].
	aProjectionNode kind = #otherRuleIndicator ifTrue: [ ^ 'Other-rule context hidden' ].
	^ aProjectionNode elementId
		ifNil: [ 'No element id' ]
		ifNotNil: [ '#' , aProjectionNode elementId asString ]
]

{ #category : 'rendering' }
CgtMatcherNodeVisualPolicy >> roleLabelForNode: aProjectionNode [
	aProjectionNode kind = #selectedElement ifTrue: [ ^ 'Selected' ].
	aProjectionNode kind = #upstreamScope ifTrue: [ ^ 'Scope' ].
	aProjectionNode kind = #selectedChildScope ifTrue: [ ^ 'Child scope' ].
	aProjectionNode kind = #compactedSection ifTrue: [ ^ 'Between' ].
	aProjectionNode kind = #otherRuleIndicator ifTrue: [ ^ 'Other rules' ].
	aProjectionNode kind = #otherRuleRelated ifTrue: [ ^ 'Other rule' ].
	^ aProjectionNode kind asString
]

{ #category : 'rendering' }
CgtMatcherNodeVisualPolicy >> matchSummaryForNode: aProjectionNode [
	aProjectionNode isCompactedSection ifTrue: [ ^ 'Context only' ].
	aProjectionNode kind = #otherRuleIndicator ifTrue: [ ^ 'Reveal related rules' ].
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
	aProjectionNode kind = #selectedChildScope ifTrue: [ ^ 30 ].
	aProjectionNode kind = #compactedSection ifTrue: [ ^ 40 ].
	aProjectionNode kind = #otherRuleIndicator ifTrue: [ ^ 45 ].
	aProjectionNode kind = #otherRuleRelated ifTrue: [ ^ 50 ].
	^ 100
]



{ #category : 'rendering' }
CgtMatcherNodeVisualPolicy >> rowBackgroundForNode: aProjectionNode selected: isSelected inScope: isInScope revealedContext: isRevealedContext otherRule: isOtherRule [
	isOtherRule ifTrue: [ ^ (Color r: 0.72 g: 0.62 b: 0.22 alpha: 0.08) ].
	isSelected ifTrue: [ ^ (Color white alpha: 0.98) ].
	isInScope ifTrue: [ ^ (Color white alpha: 0.96) ].
	isRevealedContext ifTrue: [ ^ (Color black alpha: 0.018) ].
	^ self backgroundForNode: aProjectionNode
]

{ #category : 'rendering' }
CgtMatcherNodeVisualPolicy >> rowBorderForNode: aProjectionNode selected: isSelected inScope: isInScope revealedContext: isRevealedContext otherRule: isOtherRule [
	isOtherRule ifTrue: [ ^ BlBorder paint: (Color r: 0.72 g: 0.62 b: 0.22 alpha: 0.55) width: 1 ].
	isSelected ifTrue: [ ^ BlBorder paint: (Color black alpha: 0.22) width: 2 ].
	isInScope ifTrue: [ ^ BlBorder paint: (Color gray alpha: 0.28) width: 1 ].
	isRevealedContext ifTrue: [ ^ BlBorder paint: (Color gray alpha: 0.14) width: 1 ].
	^ self borderForNode: aProjectionNode
]

{ #category : 'rendering' }
CgtMatcherNodeVisualPolicy >> chipBackgroundForEnabled: aBoolean [
	^ aBoolean
		ifTrue: [ Color white ]
		ifFalse: [ Color transparent ]
]

{ #category : 'rendering' }
CgtMatcherNodeVisualPolicy >> chipBorderForEnabled: aBoolean [
	^ aBoolean
		ifTrue: [ BlBorder paint: (Color black alpha: 0.18) width: 1 ]
		ifFalse: [ BlBorder paint: (Color gray alpha: 0.22) width: 1 ]
]

{ #category : 'rendering' }
CgtMatcherNodeVisualPolicy >> chipForegroundForEnabled: aBoolean [
	^ aBoolean
		ifTrue: [ Color black ]
		ifFalse: [ Color gray muchDarker ]
]
