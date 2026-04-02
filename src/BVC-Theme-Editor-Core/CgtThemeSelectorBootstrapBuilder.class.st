"
#Theme Selector Bootstrap Builder
I build a default selector from a live selected element and the current hierarchy root. I exist as an editor authoring utility so the selector domain does not need to know about editor paths.
"
Class {
	#name : 'CgtThemeSelectorBootstrapBuilder',
	#superclass : 'Object',
	#instVars : [
		'selectedElement',
		'hierarchyRoot'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'instance creation' }
CgtThemeSelectorBootstrapBuilder class >> selectorForSelectedElement: anElement withinHierarchyRoot: aHierarchyRoot [
	^ self new
		selectedElement: anElement;
		hierarchyRoot: aHierarchyRoot;
		buildSelector
]

{ #category : 'accessing' }
CgtThemeSelectorBootstrapBuilder >> selectedElement: anElement [
	selectedElement := anElement.
	^ self
]

{ #category : 'accessing' }
CgtThemeSelectorBootstrapBuilder >> hierarchyRoot: anElement [
	hierarchyRoot := anElement.
	^ self
]

{ #category : 'building' }
CgtThemeSelectorBootstrapBuilder >> buildSelector [
	selectedElement ifNil: [ ^ nil ].
	^ CgtThemeSimpleSelector defaultForElement: selectedElement
]

{ #category : 'building' }
CgtThemeSelectorBootstrapBuilder >> elementChain [
	| chain current |
	selectedElement ifNil: [ ^ OrderedCollection new ].
	chain := OrderedCollection new.
	current := selectedElement.
	[current notNil] whileTrue: [
		chain addFirst: current.
		current == hierarchyRoot ifTrue: [ ^ chain ].
		current := current parent ].
	^ OrderedCollection with: selectedElement
]
