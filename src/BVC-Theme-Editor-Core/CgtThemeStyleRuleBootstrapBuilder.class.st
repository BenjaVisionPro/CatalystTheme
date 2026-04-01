"
#Theme Style Rule Bootstrap Builder
I build a default style rule for the current selected element in the live hierarchy. I am an authoring utility, not part of the selector domain itself.
"
Class {
	#name : 'CgtThemeStyleRuleBootstrapBuilder',
	#superclass : 'Object',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'instance creation' }
CgtThemeStyleRuleBootstrapBuilder class >> ruleForSelectedElement: anElement withinHierarchyRoot: aHierarchyRoot [
	^ CgtThemeStyleRule new
		selector: (CgtThemeSelectorBootstrapBuilder selectorForSelectedElement: anElement withinHierarchyRoot: aHierarchyRoot);
		yourself
]
