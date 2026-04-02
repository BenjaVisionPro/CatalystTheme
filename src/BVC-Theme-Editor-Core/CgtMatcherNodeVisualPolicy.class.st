
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
	aProjectionNode kind = #selectedElement ifTrue: [ ^ (Color r: 0.96 g: 0.96 b: 0.96 alpha: 1.0) ].
	aProjectionNode kind = #compactedSection ifTrue: [ ^ (Color gray alpha: 0.08) ].
	aProjectionNode kind = #otherRuleIndicator ifTrue: [ ^ (Color r: 0.78 g: 0.68 b: 0.28 alpha: 0.04) ].
	aProjectionNode isInOtherRule ifTrue: [ ^ (Color r: 0.78 g: 0.68 b: 0.28 alpha: 0.05) ].
	^ (Color r: 0.965 g: 0.965 b: 0.965 alpha: 1.0)
]

{ #category : 'rendering' }
CgtMatcherNodeVisualPolicy >> borderForNode: aProjectionNode [
	aProjectionNode kind = #selectedElement ifTrue: [ ^ BlBorder paint: (Color black alpha: 0.28) width: 3 ].
	aProjectionNode kind = #compactedSection ifTrue: [ ^ BlBorder paint: (Color gray alpha: 0.34) width: 1 ].
	aProjectionNode kind = #otherRuleIndicator ifTrue: [ ^ BlBorder paint: (Color r: 0.78 g: 0.68 b: 0.28 alpha: 0.35) width: 1 ].
	aProjectionNode isInOtherRule ifTrue: [ ^ BlBorder paint: (Color r: 0.72 g: 0.62 b: 0.22 alpha: 0.55) width: 2 ].
	^ BlBorder paint: (Color black alpha: 0.18) width: 2
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
	isOtherRule ifTrue: [ ^ (Color r: 0.955 g: 0.94 b: 0.88 alpha: 1.0) ].
	isSelected ifTrue: [ ^ (Color r: 0.96 g: 0.96 b: 0.96 alpha: 1.0) ].
	isInScope ifTrue: [ ^ (Color r: 0.965 g: 0.965 b: 0.965 alpha: 1.0) ].
	isRevealedContext ifTrue: [ ^ (Color r: 0.97 g: 0.97 b: 0.97 alpha: 1.0) ].
	^ self backgroundForNode: aProjectionNode
]

{ #category : 'rendering' }
CgtMatcherNodeVisualPolicy >> rowBorderForNode: aProjectionNode selected: isSelected inScope: isInScope revealedContext: isRevealedContext otherRule: isOtherRule [
	isOtherRule ifTrue: [ ^ BlBorder paint: (Color r: 0.72 g: 0.62 b: 0.22 alpha: 0.55) width: 2 ].
	isSelected ifTrue: [ ^ BlBorder paint: (Color black alpha: 0.24) width: 3 ].
	isInScope ifTrue: [ ^ BlBorder paint: (Color black alpha: 0.18) width: 2 ].
	isRevealedContext ifTrue: [ ^ BlBorder paint: (Color black alpha: 0.14) width: 1 ].
	^ self borderForNode: aProjectionNode
]

{ #category : 'rendering' }
CgtMatcherNodeVisualPolicy >> chipBackgroundForEnabled: aBoolean [
	^ Color transparent
]

{ #category : 'rendering' }
CgtMatcherNodeVisualPolicy >> chipBorderForEnabled: aBoolean [
	^ BlBorder empty
]

{ #category : 'rendering' }
CgtMatcherNodeVisualPolicy >> chipForegroundForEnabled: aBoolean [
	^ aBoolean
		ifTrue: [ Color black ]
		ifFalse: [ Color gray ]
]

{ #category : 'rendering' }
CgtMatcherNodeVisualPolicy >> chipForegroundForEnabled: aBoolean chipKind: aSymbol [
	aSymbol = #class ifTrue: [
		^ aBoolean
			ifTrue: [ Color black alpha: 0.84 ]
			ifFalse: [ Color black alpha: 0.54 ] ].
	^ aBoolean
		ifTrue: [ Color black alpha: 0.34 ]
		ifFalse: [ Color black alpha: 0.22 ]
]
