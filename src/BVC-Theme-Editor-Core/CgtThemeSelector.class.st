"
#Theme Selector
I am the abstract root of the theme selector model. I describe how a style rule chooses matching elements in the rendered tree.
"
Class {
	#name : 'CgtThemeSelector',
	#superclass : 'Object',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'instance creation' }
CgtThemeSelector class >> selectorFromElementPath: aCgtElementPath [
	| selectors rootSelector |
	aCgtElementPath ifNil: [ ^ nil ].
	selectors := aCgtElementPath elements collect: [ :eachElement |
		CgtThemeSimpleSelector defaultForElement: eachElement ].
	selectors ifEmpty: [ ^ nil ].
	rootSelector := selectors first.
	selectors allButFirstDo: [ :eachSelector |
		rootSelector := CgtThemeCombinatorSelector
			left: rootSelector
			combinator: #child
			right: eachSelector ].
	^ rootSelector
]

{ #category : 'testing' }
CgtThemeSelector >> matchesElement: anElement [
	self subclassResponsibility
]

{ #category : 'printing' }
CgtThemeSelector >> displayString [
	self subclassResponsibility
]
