"
#Theme Selector Node Excluded From Rule Event
I announce that the selector renderer requested excluding a projection node from the current rule.
"
Class {
	#name : 'CgtThemeSelectorNodeExcludedFromRuleEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'projectionNode'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}
{ #category : 'accessing' }
CgtThemeSelectorNodeExcludedFromRuleEvent >> projectionNode [ ^ projectionNode ]
{ #category : 'accessing' }
CgtThemeSelectorNodeExcludedFromRuleEvent >> projectionNode: aCgtMatcherProjectionNode [ projectionNode := aCgtMatcherProjectionNode ]
{ #category : 'sending' }
CgtThemeSelectorNodeExcludedFromRuleEvent >> sendTo: anObject [ anObject selectorNodeExcludedFromRuleEvent: self ]
