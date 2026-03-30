Class {
	#name : 'CgtEditorTreeRowStencilBuilder',
	#superclass : 'BrGlamorousSimpleTreeSelectableRowElementStencilBuilder',
	#instVars : [
		'whenHovered',
		'whenUnhovered'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
	#comment : 'I am responsible for building the visual stencil used for rows in the editor''s element tree. I encapsulate that row construction so tree presentation stays out of the higher-level editor composition code.'
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
