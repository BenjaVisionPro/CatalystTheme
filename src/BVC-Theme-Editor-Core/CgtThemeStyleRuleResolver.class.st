"
#Theme Style Rule Resolver
I resolve the active style rule for the current style-inspector session. Given the selected element, selected scope path, hierarchy root, and the theme's style rules, I determine which existing rule is the current editing target and which other rules remain related context. If nothing resolves, I create a new authoring fallback rule explicitly.
"
Class {
	#name : 'CgtThemeStyleRuleResolver',
	#superclass : 'Object',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'instance creation' }
CgtThemeStyleRuleResolver class >> resolutionForSelectedElement: anElement scopePath: aCgtElementPath withinStyleRules: aCollection hierarchyRoot: aHierarchyRoot [
	^ self new
		resolutionForSelectedElement: anElement
		scopePath: aCgtElementPath
		withinStyleRules: aCollection
		hierarchyRoot: aHierarchyRoot
]

{ #category : 'resolving' }
CgtThemeStyleRuleResolver >> resolutionForSelectedElement: anElement scopePath: aCgtElementPath withinStyleRules: aCollection hierarchyRoot: aHierarchyRoot [
	| matchingRules activeRule |
	anElement ifNil: [
		^ CgtThemeStyleRuleResolution new
			activeStyleRule: nil;
			relatedStyleRules: #();
			wasBootstrapped: false;
			yourself ].
	matchingRules := self
		matchingRulesForSelectedElement: anElement
		withinStyleRules: aCollection.
	activeRule := self
		chooseActiveRuleFrom: matchingRules
		forSelectedElement: anElement
		scopePath: aCgtElementPath.
	activeRule ifNil: [
		activeRule := CgtThemeStyleRule bootstrapForSelectedElement: anElement withinHierarchyRoot: aHierarchyRoot.
		^ CgtThemeStyleRuleResolution new
			activeStyleRule: activeRule;
			relatedStyleRules: #();
			wasBootstrapped: true;
			yourself ].
	^ CgtThemeStyleRuleResolution new
		activeStyleRule: activeRule;
		relatedStyleRules: ((aCollection ifNil: [ #() ]) asOrderedCollection reject: [ :each | each == activeRule ]);
		wasBootstrapped: false;
		yourself
]

{ #category : 'private - resolving' }
CgtThemeStyleRuleResolver >> matchingRulesForSelectedElement: anElement withinStyleRules: aCollection [
	^ ((aCollection ifNil: [ #() ]) asOrderedCollection)
		select: [ :each |
			each notNil
				and: [ each selector notNil
				and: [ each selector matchesElement: anElement ] ] ]
]

{ #category : 'private - resolving' }
CgtThemeStyleRuleResolver >> chooseActiveRuleFrom: aCollection forSelectedElement: anElement scopePath: aCgtElementPath [
	| desiredDepth exactDepthMatches boundedMatches boundedDepth |
	aCollection ifEmpty: [ ^ nil ].
	desiredDepth := self desiredSelectorDepthForScopePath: aCgtElementPath.
	exactDepthMatches := aCollection
		select: [ :each | (self selectorDepthForRule: each) = desiredDepth ].
	exactDepthMatches ifNotEmpty: [ ^ exactDepthMatches first ].
	boundedMatches := aCollection
		select: [ :each | (self selectorDepthForRule: each) <= desiredDepth ].
	boundedMatches ifNotEmpty: [
		boundedDepth := (boundedMatches collect: [ :each | self selectorDepthForRule: each ]) max.
		^ boundedMatches detect: [ :each | (self selectorDepthForRule: each) = boundedDepth ] ].
	boundedDepth := (aCollection collect: [ :each | self selectorDepthForRule: each ]) max.
	^ aCollection detect: [ :each | (self selectorDepthForRule: each) = boundedDepth ]
]

{ #category : 'private - resolving' }
CgtThemeStyleRuleResolver >> desiredSelectorDepthForScopePath: aCgtElementPath [
	aCgtElementPath ifNil: [ ^ 1 ].
	^ aCgtElementPath upstreamElements size + 1
]

{ #category : 'private - resolving' }
CgtThemeStyleRuleResolver >> selectorDepthForRule: aCgtThemeStyleRule [
	aCgtThemeStyleRule ifNil: [ ^ 0 ].
	^ (CgtThemeSelectorDecomposer stepsForSelector: aCgtThemeStyleRule selector) size
]
