Class {
	#name : 'CgtEditorExamples',
	#superclass : 'Object',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
	#comment : 'I am responsible for providing executable examples of the theme editor. I exist to demonstrate behavior, support exploration, and give tests and debugging sessions a concrete way to exercise the editor in a realistic setup.'
}

{ #category : 'examples' }
CgtEditorExamples >> themeEditorOnWorld [
	<gtExample>
	<noTest>
	| world |
	world := GtWorldElement new
		addEventHandler: CgtEditorEventHandler new.
	world
		fireEvent:
			(CgtEditorShowWish new
				elementToSelect: world children first children first;
				sceneExtent: 800 @ 600).
	^ world
]
