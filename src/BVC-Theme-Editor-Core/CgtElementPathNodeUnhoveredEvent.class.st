"
#Element Path Node Unhovered Event
I announce that a previously hovered path node is no longer hovered. I allow the editor to clear widget-driven hover explicitly.
"
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
