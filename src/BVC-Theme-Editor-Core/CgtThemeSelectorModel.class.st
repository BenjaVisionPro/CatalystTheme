"
#Theme Selector Model
I hold the selector editor's non-visual state. I own the current style rule, selected element, hierarchy root, related style-rule context, temporary selector visibility state, and the derived selector projection rebuilt from that context. I do not render UI.
"
Class {
	#name : 'CgtThemeSelectorModel',
	#superclass : 'Object',
	#instVars : [
		'styleRule',
		'selectedElement',
		'hierarchyRoot',
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
CgtThemeSelectorModel >> configureForStyleRule: aCgtThemeStyleRule selectedElement: anElement hierarchyRoot: aRootElement relatedStyleRules: aCollection [
	styleRule := aCgtThemeStyleRule.
	selectedElement := anElement.
	hierarchyRoot := aRootElement.
	relatedStyleRules := (aCollection ifNil: [ #() ]) asOrderedCollection.
	self clearTemporaryRevealState.
	self refreshProjection.
	^ self
]


{ #category : 'accessing' }
CgtThemeSelectorModel >> configureForStyleInspectorModel: aCgtThemeStyleInspectorModel [
	aCgtThemeStyleInspectorModel ifNil: [
		styleRule := nil.
		selectedElement := nil.
		hierarchyRoot := nil.
		relatedStyleRules := OrderedCollection new.
		self clearTemporaryRevealState.
		self refreshProjection.
		^ self ].
	^ self
		configureForStyleRule: aCgtThemeStyleInspectorModel activeStyleRule
		selectedElement: aCgtThemeStyleInspectorModel selectedElement
		hierarchyRoot: aCgtThemeStyleInspectorModel hierarchyRoot
		relatedStyleRules: aCgtThemeStyleInspectorModel relatedStyleRules
]

{ #category : 'accessing' }
CgtThemeSelectorModel >> currentStyleRule [
	^ styleRule
]

{ #category : 'events' }
CgtThemeSelectorModel >> collapseTemporaryReveals [
	self clearTemporaryRevealState.
	self refreshProjection
]

{ #category : 'editing' }
CgtThemeSelectorModel >> expandCompactedProjectionNode: aProjectionNode [
	| gapIdentity |
	(projection isNil or: [ aProjectionNode isNil or: [ aProjectionNode representedElements isEmpty ] ]) ifTrue: [ ^ self ].
	gapIdentity := aProjectionNode gapIdentity ifNil: [ self visibilityState gapIdentityForElements: aProjectionNode representedElements ].
	self visibilityState expandGapIdentity: gapIdentity.
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

{ #category : 'editing' }
CgtThemeSelectorModel >> selector: aCgtThemeSelector [
	styleRule ifNil: [ styleRule := CgtThemeStyleRule new ].
	styleRule selector: aCgtThemeSelector.
	self clearTemporaryRevealState.
	self refreshProjection
]

{ #category : 'editing' }
CgtThemeSelectorModel >> applyClassMatch: aBoolean toProjectionNode: aProjectionNode [
	self toggleClassMatchForProjectionNode: aProjectionNode shouldMatch: aBoolean
]

{ #category : 'editing' }
CgtThemeSelectorModel >> applyIdMatch: aBoolean toProjectionNode: aProjectionNode [
	self toggleIdMatchForProjectionNode: aProjectionNode shouldMatch: aBoolean
]

{ #category : 'editing' }
CgtThemeSelectorModel >> includeProjectionNode: aProjectionNode [
	self includeProjectionNodeInRule: aProjectionNode
]

{ #category : 'editing' }
CgtThemeSelectorModel >> excludeProjectionNode: aProjectionNode [
	self excludeProjectionNodeFromRule: aProjectionNode
]

{ #category : 'editing' }
CgtThemeSelectorModel >> revealCompactedProjectionNode: aProjectionNode [
	self expandCompactedProjectionNode: aProjectionNode
]

{ #category : 'editing' }
CgtThemeSelectorModel >> applyCombinator: aSymbol toRelation: aRelation [
	self changeCombinatorForRelation: aRelation to: aSymbol
]

{ #category : 'editing' }
CgtThemeSelectorModel >> showOtherRuleContext [
	self visibilityState showsOtherRuleContext: true.
	self clearTemporaryRevealState.
	self refreshProjection
]

{ #category : 'editing' }
CgtThemeSelectorModel >> hideOtherRuleContext [
	self visibilityState showsOtherRuleContext: false.
	self clearTemporaryRevealState.
	self refreshProjection
]

{ #category : 'editing' }
CgtThemeSelectorModel >> toggleOtherRuleContext [
	self visibilityState showsOtherRuleContext: self visibilityState showsOtherRuleContext not.
	self clearTemporaryRevealState.
	self refreshProjection
]

{ #category : 'private - visibility state' }
CgtThemeSelectorModel >> clearTemporaryRevealState [
	self visibilityState clearExpandedGaps.
	idleCollapseGeneration := idleCollapseGeneration + 1.
	^ self
]

{ #category : 'private - idle collapse' }
CgtThemeSelectorModel >> noteSelectorInteraction [
	idleCollapseGeneration := idleCollapseGeneration + 1.
	^ idleCollapseGeneration
]


{ #category : 'accessing' }
CgtThemeSelectorModel >> hierarchyRoot [
	^ hierarchyRoot
]

{ #category : 'accessing' }
CgtThemeSelectorModel >> hierarchyRoot: anElement [
	hierarchyRoot := anElement.
	self clearTemporaryRevealState.
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
		hierarchyRoot: hierarchyRoot
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
	self clearTemporaryRevealState.
	self refreshProjection.
	^ self
]

{ #category : 'private - idle collapse' }
CgtThemeSelectorModel >> scheduleIdleCollapseAfter: aBlockClosure [
	| token |
	(self visibilityState hasExpandedGaps not) ifTrue: [ ^ self ].
	token := self noteSelectorInteraction.
	[ 
		(Delay forMilliseconds: idleCollapseDelayMilliseconds) wait.
		(token = idleCollapseGeneration and: [ self visibilityState hasExpandedGaps ]) ifTrue: [
			aBlockClosure value ] ] forkAt: Processor userBackgroundPriority.
	^ self
]



{ #category : 'accessing' }
CgtThemeSelectorModel >> activeStyleRule [
	^ self currentStyleRule
]

{ #category : 'accessing' }
CgtThemeSelectorModel >> currentProjection [
	^ self projection
]

{ #category : 'querying' }
CgtThemeSelectorModel >> hasProjection [
	^ projection notNil
]

{ #category : 'querying' }
CgtThemeSelectorModel >> selectedProjectionNode [
	^ projection ifNil: [ nil ] ifNotNil: [ projection selectedProjectionNode ]
]

{ #category : 'querying' }
CgtThemeSelectorModel >> visibleProjectionNodes [
	^ projection ifNil: [ #() ] ifNotNil: [ projection nodes ]
]

{ #category : 'querying' }
CgtThemeSelectorModel >> visibleProjectionRelations [
	^ projection ifNil: [ #() ] ifNotNil: [ projection relations ]
]

{ #category : 'querying' }
CgtThemeSelectorModel >> currentRuleProjectionNodes [
	^ projection ifNil: [ #() ] ifNotNil: [ projection currentRuleNodes ]
]

{ #category : 'querying' }
CgtThemeSelectorModel >> otherRuleProjectionNodes [
	^ projection ifNil: [ #() ] ifNotNil: [ projection otherRuleNodes ]
]

{ #category : 'querying' }
CgtThemeSelectorModel >> compactedProjectionNodes [
	^ projection ifNil: [ #() ] ifNotNil: [ projection nodesOfKind: #compactedSection ]
]

{ #category : 'querying' }
CgtThemeSelectorModel >> showsOtherRuleContext [
	^ self visibilityState showsOtherRuleContext
]

{ #category : 'querying' }
CgtThemeSelectorModel >> hasExpandedCompactedContext [
	^ self visibilityState hasExpandedGaps
]

{ #category : 'querying' }
CgtThemeSelectorModel >> isProjectionNodeEditable: aProjectionNode [
	aProjectionNode ifNil: [ ^ false ].
	^ aProjectionNode isEditable
]

{ #category : 'querying' }
CgtThemeSelectorModel >> isProjectionRelationEditable: aRelation [
	aRelation ifNil: [ ^ false ].
	^ aRelation kind = #matcher
]
{ #category : 'accessing' }
CgtThemeSelectorModel >> selectedElement [
	^ selectedElement
]

{ #category : 'accessing' }
CgtThemeSelectorModel >> selectedElement: anElement [
	selectedElement := anElement.
	self clearTemporaryRevealState.
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
	self clearTemporaryRevealState.
	self refreshProjection.
	^ self
]

{ #category : 'editing' }
CgtThemeSelectorModel >> toggleClassMatchForProjectionNode: aProjectionNode shouldMatch: aBoolean [
	self withProjectionMutationDo: [
		aProjectionNode ifNil: [ ^ self ].
		(aBoolean and: [ aProjectionNode isInCurrentRule not ]) ifTrue: [
			self includeProjectionNodeInRule: aProjectionNode ].
		aProjectionNode matchByClass: aBoolean.
		((aBoolean not)
			and: [ aProjectionNode kind ~= #selectedElement ]
			and: [ aProjectionNode isInCurrentRule ]
			and: [ aProjectionNode matchById not ]) ifTrue: [
			self excludeProjectionNodeFromRule: aProjectionNode ] ]
]

{ #category : 'editing' }
CgtThemeSelectorModel >> toggleIdMatchForProjectionNode: aProjectionNode shouldMatch: aBoolean [
	self withProjectionMutationDo: [
		aProjectionNode ifNil: [ ^ self ].
		(aBoolean and: [ aProjectionNode isInCurrentRule not ]) ifTrue: [
			self includeProjectionNodeInRule: aProjectionNode ].
		aProjectionNode matchById: aBoolean.
		((aBoolean not)
			and: [ aProjectionNode kind ~= #selectedElement ]
			and: [ aProjectionNode isInCurrentRule ]
			and: [ aProjectionNode matchByClass not ]) ifTrue: [
			self excludeProjectionNodeFromRule: aProjectionNode ] ]
]

{ #category : 'accessing' }
CgtThemeSelectorModel >> visibilityState [
	^ visibilityState ifNil: [ visibilityState := CgtMatcherVisibilityState new ]
]

{ #category : 'private - projection' }
CgtThemeSelectorModel >> withProjectionMutationDo: aBlock [
	projection ifNil: [ ^ self ].
	aBlock value.
	self clearTemporaryRevealState.
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
