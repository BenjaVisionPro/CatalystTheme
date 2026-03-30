"
#Theme Selector Decomposer
I decompose a theme selector into an ordered sequence of structural steps. I am responsible for flattening nested combinator selectors into a stable editor-friendly representation.
"
Class {
	#name : 'CgtThemeSelectorDecomposer',
	#superclass : 'Object',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'instance creation' }
CgtThemeSelectorDecomposer class >> stepsForSelector: aCgtThemeSelector [
	^ self new stepsForSelector: aCgtThemeSelector
]

{ #category : 'decomposing' }
CgtThemeSelectorDecomposer >> stepsForSelector: aCgtThemeSelector [
	aCgtThemeSelector ifNil: [ ^ OrderedCollection new ].
	(aCgtThemeSelector isKindOf: CgtThemeSimpleSelector) ifTrue: [
		^ OrderedCollection with: (CgtThemeSelectorStep simpleSelector: aCgtThemeSelector combinatorToNext: nil) ].
	(aCgtThemeSelector isKindOf: CgtThemeCombinatorSelector) ifTrue: [
		| leftSteps rightSteps |
		leftSteps := self stepsForSelector: aCgtThemeSelector leftSelector.
		rightSteps := self stepsForSelector: aCgtThemeSelector rightSelector.
		leftSteps ifEmpty: [ ^ rightSteps ].
		leftSteps last combinatorToNext: aCgtThemeSelector combinator.
		leftSteps addAll: rightSteps.
		^ leftSteps ].
	^ self error: 'Unsupported selector type: ', aCgtThemeSelector class name
]
