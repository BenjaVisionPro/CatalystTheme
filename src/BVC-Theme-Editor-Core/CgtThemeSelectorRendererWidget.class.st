"
#Theme Selector Renderer Widget
I am the abstract UI seam for selector renderers. I hold the supplied selector projection and refresh my contents when it changes, while leaving selector semantics in CgtThemeSelectorModel.
"
Class {
	#name : 'CgtThemeSelectorRendererWidget',
	#superclass : 'BrVerticalPane',
	#instVars : [
		'projection'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtThemeSelectorRendererWidget >> projection [
	^ projection
]

{ #category : 'accessing' }
CgtThemeSelectorRendererWidget >> projection: aCgtMatcherProjection [
	projection := aCgtMatcherProjection.
	self refreshContents.
	^ self
]

{ #category : 'accessing' }
CgtThemeSelectorRendererWidget >> currentSelector [
	projection ifNil: [ ^ nil ].
	^ CgtMatcherProjectionSelectorComposer selectorForProjection: projection
]

{ #category : 'rendering' }
CgtThemeSelectorRendererWidget >> refreshContents [
	self subclassResponsibility
]
