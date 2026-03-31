"
#Theme Selector Other Rule Context Toggled Event
I announce that the selector renderer requested toggling hidden other-rule context.
"
Class {
	#name : 'CgtThemeSelectorOtherRuleContextToggledEvent',
	#superclass : 'BlEvent',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}
{ #category : 'sending' }
CgtThemeSelectorOtherRuleContextToggledEvent >> sendTo: anObject [ anObject selectorOtherRuleContextToggledEvent: self ]
