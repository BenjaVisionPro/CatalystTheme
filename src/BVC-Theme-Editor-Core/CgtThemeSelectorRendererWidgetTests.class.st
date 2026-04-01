"
#Theme Selector Renderer Widget Tests
I verify the explicit base contract for selector renderers. I check that the renderer seam accepts selector projections, rejects unrelated inputs, and publishes selector-facing events through the shared helper protocol.
"
Class {
	#name : 'CgtThemeSelectorRendererWidgetTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'private' }
CgtThemeSelectorRendererWidgetTests >> newProjectionNode [
	^ (CgtMatcherProjectionNode kind: #selectedElement)
		className: 'SelectedElement';
		yourself
]

{ #category : 'private' }
CgtThemeSelectorRendererWidgetTests >> newRendererWidget [
	^ CgtThemeSelectorCompactWidget new
]

{ #category : 'tests' }
CgtThemeSelectorRendererWidgetTests >> testSupportedSelectorEventClassesExposeRendererContract [
	<gtExample>
	| eventClasses |
	eventClasses := CgtThemeSelectorRendererWidget supportedSelectorEventClasses.
	self assert: (eventClasses includes: CgtThemeSelectorNodeHoveredEvent).
	self assert: (eventClasses includes: CgtThemeSelectorNodeUnhoveredEvent).
	self assert: (eventClasses includes: CgtThemeSelectorNodeSelectedEvent).
	self assert: (eventClasses includes: CgtThemeSelectorClassMatchChangedEvent).
	self assert: (eventClasses includes: CgtThemeSelectorIdMatchChangedEvent).
	self assert: (eventClasses includes: CgtThemeSelectorCombinatorChangedEvent).
	self assert: (eventClasses includes: CgtThemeSelectorCompactedSectionExpandedEvent).
	self assert: (eventClasses includes: CgtThemeSelectorNodeIncludedInRuleEvent).
	self assert: (eventClasses includes: CgtThemeSelectorNodeExcludedFromRuleEvent).
	self assert: (eventClasses includes: CgtThemeSelectorOtherRuleContextToggledEvent).
	^ eventClasses
]

{ #category : 'tests' }
CgtThemeSelectorRendererWidgetTests >> testProjectionInputRejectsNonProjectionObjects [
	<gtExample>
	| widget |
	widget := self newRendererWidget.
	self should: [ widget projection: Object new ] raise: Error.
	^ widget
]

{ #category : 'tests' }
CgtThemeSelectorRendererWidgetTests >> testProjectionInputAcceptsProjectionAndRefreshesRenderer [
	<gtExample>
	| projection node widget |
	projection := CgtMatcherProjection new.
	node := self newProjectionNode.
	projection addNode: node.
	widget := self newRendererWidget.
	widget projection: projection.
	self assert: widget selectorProjection identicalTo: projection.
	self assert: widget children isNotEmpty.
	^ widget
]

{ #category : 'tests' }
CgtThemeSelectorRendererWidgetTests >> testBaseAnnouncementHelpersPublishSelectorFacingEvents [
	<gtExample>
	| widget node relation hovered selected combinatorChanged |
	widget := self newRendererWidget.
	node := self newProjectionNode.
	relation := CgtMatcherProjectionRelation from: node to: node kind: #matcher.
	widget when: CgtThemeSelectorNodeHoveredEvent do: [ :anEvent | hovered := anEvent ].
	widget when: CgtThemeSelectorNodeSelectedEvent do: [ :anEvent | selected := anEvent ].
	widget when: CgtThemeSelectorCombinatorChangedEvent do: [ :anEvent | combinatorChanged := anEvent ].
	widget announceSelectorNodeHoveredFor: node.
	widget announceSelectorNodeSelectedFor: node.
	widget announceSelectorCombinator: #child for: relation.
	self assert: hovered projectionNode identicalTo: node.
	self assert: selected projectionNode identicalTo: node.
	self assert: combinatorChanged relation identicalTo: relation.
	self assert: combinatorChanged combinator equals: #child.
	^ widget
]
