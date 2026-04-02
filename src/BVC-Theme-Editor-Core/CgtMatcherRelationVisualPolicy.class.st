"
#Matcher Relation Visual Policy
I provide the explicit visual language for matcher projection relations. I am responsible for keeping edge styling semantics out of the Mondrian widget so relation meaning remains narrow, stable, and easy to refine.
"
Class {
	#name : 'CgtMatcherRelationVisualPolicy',
	#superclass : 'Object',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'styling' }
CgtMatcherRelationVisualPolicy >> colorForRelation: aRelation [
	aRelation kind = #compaction ifTrue: [ ^ Color gray alpha: 0.5 ].
	aRelation kind = #context ifTrue: [ ^ Color gray alpha: 0.28 ].
	aRelation kind = #otherRule ifTrue: [ ^ Color orange alpha: 0.5 ].
	(aRelation combinator = #descendant) ifTrue: [ ^ Color darkGray alpha: 0.6 ].
	^ Color black alpha: 0.5
]

{ #category : 'styling' }
CgtMatcherRelationVisualPolicy >> widthForRelation: aRelation [
	aRelation kind = #otherRule ifTrue: [ ^ 3 ].
	aRelation kind = #compaction ifTrue: [ ^ 1 ].
	^ 2
]

{ #category : 'styling' }
CgtMatcherRelationVisualPolicy >> labelForRelation: aRelation [
	aRelation kind = #otherRule ifTrue: [ ^ 'Other rule' ].
	aRelation kind = #compaction ifTrue: [ ^ 'Compacted context' ].
	aRelation kind = #context ifTrue: [ ^ 'Revealed context' ].
	(aRelation combinator = #descendant) ifTrue: [ ^ self labelForAnyDepth ].
	^ self labelForDirectChild
]


{ #category : 'styling' }
CgtMatcherRelationVisualPolicy >> labelForDirectChild [
	^ 'Child'
]

{ #category : 'styling' }
CgtMatcherRelationVisualPolicy >> labelForAnyDepth [
	^ 'Deep'
]
