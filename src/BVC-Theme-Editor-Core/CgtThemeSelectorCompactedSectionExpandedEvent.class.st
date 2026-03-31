"
#Theme Selector Compacted Section Expanded Event
I announce that the selector renderer requested revealing a compacted selector section.
"
Class {
	#name : 'CgtThemeSelectorCompactedSectionExpandedEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'projectionNode'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}
{ #category : 'accessing' }
CgtThemeSelectorCompactedSectionExpandedEvent >> projectionNode [ ^ projectionNode ]
{ #category : 'accessing' }
CgtThemeSelectorCompactedSectionExpandedEvent >> projectionNode: aCgtMatcherProjectionNode [ projectionNode := aCgtMatcherProjectionNode ]
{ #category : 'sending' }
CgtThemeSelectorCompactedSectionExpandedEvent >> sendTo: anObject [ anObject selectorCompactedSectionExpandedEvent: self ]
