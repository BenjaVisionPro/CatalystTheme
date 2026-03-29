Class {
	#name : 'CgtElementPathNodeUnhoveredEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'element'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
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
