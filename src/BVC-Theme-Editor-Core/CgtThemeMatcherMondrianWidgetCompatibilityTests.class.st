"
#Theme Matcher Mondrian Widget Compatibility Tests
"
Class {
	#name : 'CgtThemeMatcherMondrianWidgetCompatibilityTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtThemeMatcherMondrianWidgetCompatibilityTests >> testMatcherNamedRendererInheritsConcreteSelectorRenderer [
	self assert: CgtThemeMatcherMondrianWidget superclass equals: CgtThemeSelectorMondrianWidget
]
