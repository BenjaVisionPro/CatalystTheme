"
#Theme Selector Id Match Changed Event
I announce that the selector renderer requested an id-match change for a selector projection node.
"
Class {
	#name : 'CgtThemeSelectorIdMatchChangedEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'projectionNode',
		'shouldMatch'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtThemeSelectorIdMatchChangedEvent >> projectionNode [ ^ projectionNode ]
{ #category : 'accessing' }
CgtThemeSelectorIdMatchChangedEvent >> projectionNode: aCgtMatcherProjectionNode [ projectionNode := aCgtMatcherProjectionNode ]
{ #category : 'accessing' }
CgtThemeSelectorIdMatchChangedEvent >> shouldMatch [ ^ shouldMatch ]
{ #category : 'accessing' }
CgtThemeSelectorIdMatchChangedEvent >> shouldMatch: aBoolean [ shouldMatch := aBoolean ]
{ #category : 'sending' }
CgtThemeSelectorIdMatchChangedEvent >> sendTo: anObject [ anObject selectorIdMatchChangedEvent: self ]
