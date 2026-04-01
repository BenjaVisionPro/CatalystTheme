"
#Theme Selector Renderer Widget
I am the abstract UI seam for selector renderers. I hold the supplied selector projection and refresh my contents when it changes, while leaving selector semantics in CgtThemeSelectorModel.
"
Class {
	#name : 'CgtThemeSelectorRendererWidget',
	#superclass : 'BrVerticalPane',
	#instVars : [
		'projection'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtThemeSelectorRendererWidget >> projection [
	^ projection
]


{ #category : 'accessing' }
CgtThemeSelectorRendererWidget >> currentSelector [
	projection ifNil: [ ^ nil ].
	^ CgtMatcherProjectionSelectorComposer selectorForProjection: projection
]

{ #category : 'rendering' }
CgtThemeSelectorRendererWidget >> refreshContents [
	self subclassResponsibility
]

{ #category : 'testing' }
CgtThemeSelectorRendererWidget class >> supportedSelectorEventClasses [
	^ {
		CgtThemeSelectorNodeHoveredEvent.
		CgtThemeSelectorNodeUnhoveredEvent.
		CgtThemeSelectorNodeSelectedEvent.
		CgtThemeSelectorClassMatchChangedEvent.
		CgtThemeSelectorIdMatchChangedEvent.
		CgtThemeSelectorCombinatorChangedEvent.
		CgtThemeSelectorCompactedSectionExpandedEvent.
		CgtThemeSelectorNodeIncludedInRuleEvent.
		CgtThemeSelectorNodeExcludedFromRuleEvent.
		CgtThemeSelectorOtherRuleContextToggledEvent }
]

{ #category : 'testing' }
CgtThemeSelectorRendererWidget >> acceptsProjection: anObject [
	^ anObject isNil or: [ anObject isKindOf: CgtMatcherProjection ]
]

{ #category : 'accessing' }
CgtThemeSelectorRendererWidget >> selectorProjection [
	^ self projection
]

{ #category : 'accessing' }
CgtThemeSelectorRendererWidget >> projection: aCgtMatcherProjection [
	(self acceptsProjection: aCgtMatcherProjection) ifFalse: [
		self error: 'Selector renderer widgets accept only CgtMatcherProjection inputs' ].
	projection := aCgtMatcherProjection.
	self refreshProjection.
	^ self
]

{ #category : 'rendering' }
CgtThemeSelectorRendererWidget >> refreshProjection [
	^ self refreshContents
]

{ #category : 'accessing' }
CgtThemeSelectorRendererWidget >> supportedSelectorEventClasses [
	^ self class supportedSelectorEventClasses
]

{ #category : 'events' }
CgtThemeSelectorRendererWidget >> announceSelectorEvent: anEvent [
	self fireEvent: anEvent.
	^ anEvent
]

{ #category : 'events' }
CgtThemeSelectorRendererWidget >> announceSelectorNodeHoveredFor: aProjectionNode [
	^ self announceSelectorEvent: (CgtThemeSelectorNodeHoveredEvent new
		projectionNode: aProjectionNode;
		yourself)
]

{ #category : 'events' }
CgtThemeSelectorRendererWidget >> announceSelectorNodeUnhoveredFor: aProjectionNode [
	^ self announceSelectorEvent: (CgtThemeSelectorNodeUnhoveredEvent new
		projectionNode: aProjectionNode;
		yourself)
]

{ #category : 'events' }
CgtThemeSelectorRendererWidget >> announceSelectorNodeSelectedFor: aProjectionNode [
	^ self announceSelectorEvent: (CgtThemeSelectorNodeSelectedEvent new
		projectionNode: aProjectionNode;
		yourself)
]

{ #category : 'events' }
CgtThemeSelectorRendererWidget >> announceSelectorClassMatch: aBoolean for: aProjectionNode [
	^ self announceSelectorEvent: (CgtThemeSelectorClassMatchChangedEvent new
		projectionNode: aProjectionNode;
		shouldMatch: aBoolean;
		yourself)
]

{ #category : 'events' }
CgtThemeSelectorRendererWidget >> announceSelectorIdMatch: aBoolean for: aProjectionNode [
	^ self announceSelectorEvent: (CgtThemeSelectorIdMatchChangedEvent new
		projectionNode: aProjectionNode;
		shouldMatch: aBoolean;
		yourself)
]

{ #category : 'events' }
CgtThemeSelectorRendererWidget >> announceSelectorCombinator: aSymbol for: aRelation [
	^ self announceSelectorEvent: (CgtThemeSelectorCombinatorChangedEvent new
		relation: aRelation;
		combinator: aSymbol;
		yourself)
]

{ #category : 'events' }
CgtThemeSelectorRendererWidget >> announceSelectorCompactedSectionExpandedFor: aProjectionNode [
	^ self announceSelectorEvent: (CgtThemeSelectorCompactedSectionExpandedEvent new
		projectionNode: aProjectionNode;
		yourself)
]

{ #category : 'events' }
CgtThemeSelectorRendererWidget >> announceSelectorNodeIncludedInRuleFor: aProjectionNode [
	^ self announceSelectorEvent: (CgtThemeSelectorNodeIncludedInRuleEvent new
		projectionNode: aProjectionNode;
		yourself)
]

{ #category : 'events' }
CgtThemeSelectorRendererWidget >> announceSelectorNodeExcludedFromRuleFor: aProjectionNode [
	^ self announceSelectorEvent: (CgtThemeSelectorNodeExcludedFromRuleEvent new
		projectionNode: aProjectionNode;
		yourself)
]

{ #category : 'events' }
CgtThemeSelectorRendererWidget >> announceSelectorOtherRuleContextToggled [
	^ self announceSelectorEvent: CgtThemeSelectorOtherRuleContextToggledEvent new
]
