"
#Theme Selector Model
I hold the selector editor's non-visual state. I own the current style rule, selected element, hierarchy root, related style-rule context, temporary matcher visibility state, and the derived matcher projection rebuilt from that context. I do not render UI.
"
Class {
	#name : 'CgtThemeSelectorModel',
	#superclass : 'Object',
	#instVars : [
		'styleRule',
		'selectedElement',
		'pathRootElement',
		'relatedStyleRules',
		'visibilityState',
		'idleCollapseDelayMilliseconds',
		'idleCollapseGeneration',
		'projection'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtThemeSelectorModel >> initialize [
	super initialize.
	idleCollapseDelayMilliseconds := 1800.
	idleCollapseGeneration := 0.
	relatedStyleRules := OrderedCollection new.
	visibilityState := CgtMatcherVisibilityState new
]

{ #category : 'accessing' }
CgtThemeSelectorModel >> configureForStyleRule: aCgtThemeStyleRule selectedElement: anElement pathRootElement: aRootElement relatedStyleRules: aCollection [
	styleRule := aCgtThemeStyleRule.
	selectedElement := anElement.
	pathRootElement := aRootElement.
	relatedStyleRules := (aCollection ifNil: [ #() ]) asOrderedCollection.
	self refreshProjection.
	^ self
]

{ #category : 'accessing' }
CgtThemeSelectorModel >> currentStyleRule [
	^ styleRule
]

{ #category : 'events' }
CgtThemeSelectorModel >> collapseTemporaryReveals [
	self visibilityState clearExpandedGaps.
	idleCollapseGeneration := idleCollapseGeneration + 1.
	self refreshProjection
]

{ #category : 'editing' }
CgtThemeSelectorModel >> expandCompactedProjectionNode: aProjectionNode [
	(projection isNil or: [ aProjectionNode isNil or: [ aProjectionNode representedElements isEmpty ] ]) ifTrue: [ ^ self ].
	self visibilityState expandElements: aProjectionNode representedElements.
	self refreshProjection
]

{ #category : 'accessing' }
CgtThemeSelectorModel >> idleCollapseDelayMilliseconds [
	^ idleCollapseDelayMilliseconds
]

{ #category : 'accessing' }
CgtThemeSelectorModel >> idleCollapseDelayMilliseconds: anInteger [
	idleCollapseDelayMilliseconds := anInteger.
	^ self
]

{ #category : 'accessing' }
CgtThemeSelectorModel >> idleCollapseGeneration [
	^ idleCollapseGeneration
]

{ #category : 'editing' }
CgtThemeSelectorModel >> includeProjectionNodeInRule: aProjectionNode [
	self withProjectionMutationDo: [
		| incoming outgoing |
		aProjectionNode ifNil: [ ^ self ].
		aProjectionNode isInCurrentRule: true.
		(aProjectionNode matchByClass not and: [ aProjectionNode matchById not ]) ifTrue: [
			aProjectionNode matchByClass: true ].
		incoming := self preferredIncomingRelationForNode: aProjectionNode.
		incoming ifNotNil: [
			incoming kind: #matcher.
			incoming combinator ifNil: [ incoming combinator: #child ] ].
		outgoing := self preferredOutgoingRelationForNode: aProjectionNode.
		outgoing ifNotNil: [
			(outgoing toNode isInCurrentRule or: [ outgoing toNode kind = #selectedElement ]) ifTrue: [
				outgoing kind: #matcher.
				outgoing combinator ifNil: [ outgoing combinator: #child ] ] ] ]
]

{ #category : 'editing' }
CgtThemeSelectorModel >> excludeProjectionNodeFromRule: aProjectionNode [
	self withProjectionMutationDo: [
		| incoming |
		aProjectionNode ifNil: [ ^ self ].
		aProjectionNode kind = #selectedElement ifTrue: [ ^ self ].
		aProjectionNode isInCurrentRule: false.
		incoming := self preferredIncomingRelationForNode: aProjectionNode.
		incoming ifNotNil: [ incoming kind: #context ] ]
]

{ #category : 'events' }
CgtThemeSelectorModel >> matcherSelectorChangedEvent: anEvent [
	styleRule ifNil: [ styleRule := CgtThemeStyleRule new ].
	styleRule selector: anEvent selector.
	self refreshProjection
]

{ #category : 'editing' }
CgtThemeSelectorModel >> matcherClassMatchToggledEvent: anEvent [
	self toggleClassMatchForProjectionNode: anEvent projectionNode shouldMatch: anEvent shouldMatch
]

{ #category : 'editing' }
CgtThemeSelectorModel >> matcherIdMatchToggledEvent: anEvent [
	self toggleIdMatchForProjectionNode: anEvent projectionNode shouldMatch: anEvent shouldMatch
]

{ #category : 'editing' }
CgtThemeSelectorModel >> matcherNodeIncludedInRuleEvent: anEvent [
	self includeProjectionNodeInRule: anEvent projectionNode
]

{ #category : 'editing' }
CgtThemeSelectorModel >> matcherNodeExcludedFromRuleEvent: anEvent [
	self excludeProjectionNodeFromRule: anEvent projectionNode
]

{ #category : 'editing' }
CgtThemeSelectorModel >> matcherCompactedSectionExpandedEvent: anEvent [
	self expandCompactedProjectionNode: anEvent projectionNode
]

{ #category : 'editing' }
CgtThemeSelectorModel >> matcherCombinatorChangedEvent: anEvent [
	self changeCombinatorForRelation: anEvent relation to: anEvent combinator
]

{ #category : 'private - idle collapse' }
CgtThemeSelectorModel >> noteMatcherInteraction [
	idleCollapseGeneration := idleCollapseGeneration + 1.
	^ idleCollapseGeneration
]

{ #category : 'accessing' }
CgtThemeSelectorModel >> pathRootElement [
	^ pathRootElement
]

{ #category : 'accessing' }
CgtThemeSelectorModel >> pathRootElement: anElement [
	pathRootElement := anElement.
	self refreshProjection.
	^ self
]

{ #category : 'accessing' }
CgtThemeSelectorModel >> projection [
	^ projection
]

{ #category : 'private - projection' }
CgtThemeSelectorModel >> refreshProjection [
	(styleRule isNil or: [ selectedElement isNil ]) ifTrue: [
		projection := nil.
		^ self ].
	visibilityState ifNil: [ visibilityState := CgtMatcherVisibilityState new ].
	projection := (CgtMatcherProjectionBuilder
		projectionForStyleRule: styleRule
		selectedElement: selectedElement
		hierarchyRoot: pathRootElement
		relatedStyleRules: self relatedStyleRules
		visibilityState: visibilityState).
	^ self
]

{ #category : 'accessing' }
CgtThemeSelectorModel >> relatedStyleRules [
	^ relatedStyleRules ifNil: [ #() ]
]

{ #category : 'accessing' }
CgtThemeSelectorModel >> relatedStyleRules: aCollection [
	relatedStyleRules := (aCollection ifNil: [ #() ]) asOrderedCollection.
	visibilityState ifNil: [ visibilityState := CgtMatcherVisibilityState new ].
	self refreshProjection.
	^ self
]

{ #category : 'private - idle collapse' }
CgtThemeSelectorModel >> scheduleIdleCollapseAfter: aBlockClosure [
	| token |
	(self visibilityState hasExpandedGaps not) ifTrue: [ ^ self ].
	token := self noteMatcherInteraction.
	[ 
		(Delay forMilliseconds: idleCollapseDelayMilliseconds) wait.
		(token = idleCollapseGeneration and: [ self visibilityState hasExpandedGaps ]) ifTrue: [
			aBlockClosure value ] ] forkAt: Processor userBackgroundPriority.
	^ self
]

{ #category : 'accessing' }
CgtThemeSelectorModel >> selectedElement [
	^ selectedElement
]

{ #category : 'accessing' }
CgtThemeSelectorModel >> selectedElement: anElement [
	selectedElement := anElement.
	self refreshProjection.
	^ self
]

{ #category : 'accessing' }
CgtThemeSelectorModel >> selector [
	^ styleRule ifNil: [ nil ] ifNotNil: [ styleRule selector ]
]

{ #category : 'accessing' }
CgtThemeSelectorModel >> styleRule [
	^ styleRule
]

{ #category : 'accessing' }
CgtThemeSelectorModel >> styleRule: aCgtThemeStyleRule [
	styleRule := aCgtThemeStyleRule.
	self refreshProjection.
	^ self
]

{ #category : 'editing' }
CgtThemeSelectorModel >> toggleClassMatchForProjectionNode: aProjectionNode shouldMatch: aBoolean [
	self withProjectionMutationDo: [
		aProjectionNode ifNotNil: [ aProjectionNode matchByClass: aBoolean ] ]
]

{ #category : 'editing' }
CgtThemeSelectorModel >> toggleIdMatchForProjectionNode: aProjectionNode shouldMatch: aBoolean [
	self withProjectionMutationDo: [
		aProjectionNode ifNotNil: [ aProjectionNode matchById: aBoolean ] ]
]

{ #category : 'accessing' }
CgtThemeSelectorModel >> visibilityState [
	^ visibilityState ifNil: [ visibilityState := CgtMatcherVisibilityState new ]
]

{ #category : 'private - projection' }
CgtThemeSelectorModel >> withProjectionMutationDo: aBlock [
	projection ifNil: [ ^ self ].
	aBlock value.
	styleRule ifNil: [ styleRule := CgtThemeStyleRule new ].
	styleRule selector: (CgtMatcherProjectionSelectorComposer selectorForProjection: projection).
	self refreshProjection
]

{ #category : 'editing' }
CgtThemeSelectorModel >> changeCombinatorForRelation: aRelation to: aSymbol [
	self withProjectionMutationDo: [
		aRelation ifNotNil: [ aRelation combinator: aSymbol ] ]
]

{ #category : 'private - projection' }
CgtThemeSelectorModel >> preferredIncomingRelationForNode: aProjectionNode [
	| incoming |
	projection ifNil: [ ^ nil ].
	incoming := projection relationsToNode: aProjectionNode.
	^ incoming ifEmpty: [ nil ] ifNotEmpty: [ incoming first ]
]

{ #category : 'private - projection' }
CgtThemeSelectorModel >> preferredOutgoingRelationForNode: aProjectionNode [
	| outgoing |
	projection ifNil: [ ^ nil ].
	outgoing := projection relationsFromNode: aProjectionNode.
	^ outgoing ifEmpty: [ nil ] ifNotEmpty: [ outgoing first ]
]
