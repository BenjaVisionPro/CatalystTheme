"
#Theme Selector Node Included In Rule Event
I announce that the selector renderer requested including a projection node in the current rule.
"
Class {
	#name : 'CgtThemeSelectorNodeIncludedInRuleEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'projectionNode'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}
{ #category : 'accessing' }
CgtThemeSelectorNodeIncludedInRuleEvent >> projectionNode [ ^ projectionNode ]
{ #category : 'accessing' }
CgtThemeSelectorNodeIncludedInRuleEvent >> projectionNode: aCgtMatcherProjectionNode [ projectionNode := aCgtMatcherProjectionNode ]
{ #category : 'sending' }
CgtThemeSelectorNodeIncludedInRuleEvent >> sendTo: anObject [ anObject selectorNodeIncludedInRuleEvent: self ]
