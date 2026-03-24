Class {
	#name : 'CgtThemeEditorTreeRowStencilBuilder',
	#superclass : 'BrGlamorousSimpleTreeSelectableRowElementStencilBuilder',
	#instVars : [
		'whenHovered',
		'whenUnhovered'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtThemeEditorTreeRowStencilBuilder class >> stencilProperties [
	^ #(whenHovered whenUnhovered)
]

{ #category : 'api - instantiation' }
CgtThemeEditorTreeRowStencilBuilder >> buildDefault [
	^ super buildDefault
		when: BlElementHoveredEvent do: self whenHovered;
		when: BlElementUnhoveredEvent do: self whenUnhovered
]

{ #category : 'accessing' }
CgtThemeEditorTreeRowStencilBuilder >> whenHovered [
	^ whenHovered
]

{ #category : 'accessing' }
CgtThemeEditorTreeRowStencilBuilder >> whenHovered: anObject [
	whenHovered := anObject
]

{ #category : 'accessing' }
CgtThemeEditorTreeRowStencilBuilder >> whenUnhovered [
	^ whenUnhovered
]

{ #category : 'accessing' }
CgtThemeEditorTreeRowStencilBuilder >> whenUnhovered: anObject [
	whenUnhovered := anObject
]
