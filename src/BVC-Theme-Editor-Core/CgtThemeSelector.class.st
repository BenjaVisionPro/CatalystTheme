Class {
	#name : 'CgtThemeSelector',
	#superclass : 'Object',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
	#comment : 'I am responsible for representing a theme selector in the abstract. I provide the common protocol for selector objects that describe how style rules match the rendered element tree.'
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
