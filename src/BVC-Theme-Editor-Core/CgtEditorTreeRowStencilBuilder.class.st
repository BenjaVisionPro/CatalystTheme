"
#Editor Tree Row Stencil Builder
I build rows for the editor tree. I am responsible for the row UI used to present scene elements inside the editor tree without owning the editor’s interaction semantics.
"
Class {
	#name : 'CgtEditorTreeRowStencilBuilder',
	#superclass : 'BrGlamorousSimpleTreeSelectableRowElementStencilBuilder',
	#instVars : [
		'whenHovered',
		'whenUnhovered'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtEditorTreeRowStencilBuilder class >> stencilProperties [
	^ #(whenHovered whenUnhovered)
]

{ #category : 'api - instantiation' }
CgtEditorTreeRowStencilBuilder >> buildDefault [
	^ super buildDefault
		when: BlElementHoveredEvent do: self whenHovered;
		when: BlElementUnhoveredEvent do: self whenUnhovered
]

{ #category : 'accessing' }
CgtEditorTreeRowStencilBuilder >> whenHovered [
	^ whenHovered
]

{ #category : 'accessing' }
CgtEditorTreeRowStencilBuilder >> whenHovered: anObject [
	whenHovered := anObject
]

{ #category : 'accessing' }
CgtEditorTreeRowStencilBuilder >> whenUnhovered [
	^ whenUnhovered
]

{ #category : 'accessing' }
CgtEditorTreeRowStencilBuilder >> whenUnhovered: anObject [
	whenUnhovered := anObject
]
