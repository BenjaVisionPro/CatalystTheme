"
#Theme Selector Composer
I compose a theme selector from an ordered sequence of structural steps. I am responsible for rebuilding nested selector objects from the editor-friendly flattened representation.
"
Class {
	#name : 'CgtThemeSelectorComposer',
	#superclass : 'Object',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'instance creation' }
CgtThemeSelectorComposer class >> selectorFromSteps: aCollection [
	^ self new selectorFromSteps: aCollection
]

{ #category : 'composing' }
CgtThemeSelectorComposer >> selectorFromSteps: aCollection [
	| steps rootSelector |
	steps := aCollection asOrderedCollection.
	steps ifEmpty: [ ^ nil ].
	rootSelector := steps first simpleSelector.
	1 to: steps size - 1 do: [ :anIndex |
		| eachStep nextStep |
		eachStep := steps at: anIndex.
		eachStep combinatorToNext ifNil: [
			self error: 'Missing combinator between selector steps' ].
		nextStep := steps at: anIndex + 1.
		rootSelector := CgtThemeCombinatorSelector
			left: rootSelector
			combinator: eachStep combinatorToNext
			right: nextStep simpleSelector ].
	^ rootSelector
]
