Class {
	#name : 'CgtElementPathNodeUnhoveredEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'element'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
	#comment : 'I am responsible for announcing that path-node hover ended in the path selector. I let the editor clear widget-driven hover without hiding that behavior in callbacks.'
}

{ #category : 'accessing' }
CgtElementPathNodeUnhoveredEvent >> element [
	^ element
]

{ #category : 'accessing' }
CgtElementPathNodeUnhoveredEvent >> element: anElement [
	element := anElement
]

{ #category : 'sending' }
CgtElementPathNodeUnhoveredEvent >> sendTo: anObject [
	anObject elementPathNodeUnhoveredEvent: self
]
