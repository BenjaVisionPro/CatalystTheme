"
#Editor Examples
I collect examples for the Theme Editor. I am responsible for small example setups that demonstrate or exercise the editor.
"
Class {
	#name : 'CgtEditorExamples',
	#superclass : 'Object',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
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
