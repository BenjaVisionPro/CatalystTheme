"
#Theme Selector Renderer Widget Tests
I verify the shared renderer seam holds projection state and derives a selector from it for any concrete selector renderer UI.
"
Class {
	#name : 'CgtThemeSelectorRendererWidgetTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'private' }
CgtThemeSelectorRendererWidgetTests >> newTestElementWithId: anId [.
	^ CgtThemeSelectorTestElement new
		id: anId;
		yourself
]

{ #category : 'tests' }
CgtThemeSelectorRendererWidgetTests >> testProjectionAccessIsSharedByConcreteRenderers [
	<gtExample>
	| root selected rule projection renderers |
	root := self newTestElementWithId: #root.
	selected := self newTestElementWithId: #selected.
	root addChild: selected.
	rule := CgtThemeStyleRule new
		selector: (CgtThemeSimpleSelector new
			addPredicate: (CgtThemeIdPredicate elementId: #selected);
			yourself);
		yourself.
	projection := CgtMatcherProjectionBuilder
		projectionForStyleRule: rule
		selectedElement: selected
		hierarchyRoot: root
		relatedStyleRules: #()
		visibilityState: CgtMatcherVisibilityState new.
	renderers := {
		CgtThemeSelectorMondrianWidget new.
		CgtThemeSelectorBreadcrumbWidget new.
		CgtThemeSelectorCompactWidget new }.
	renderers do: [ :each |
		each projection: projection.
		self assert: each projection identicalTo: projection.
		self assert: each currentSelector displayString equals: #'#selected' ].
	^ projection

]
