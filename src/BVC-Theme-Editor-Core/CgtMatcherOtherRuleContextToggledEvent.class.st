"
#Matcher Other Rule Context Toggled Event
I announce that the hidden other-rule context affordance was toggled in a selector renderer. I let the selector host decide whether to reveal or hide the related-rule context explicitly.
"
Class {
	#name : 'CgtMatcherOtherRuleContextToggledEvent',
	#superclass : 'BlEvent',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'sending' }
CgtMatcherOtherRuleContextToggledEvent >> sendTo: anObject [
	anObject matcherOtherRuleContextToggledEvent: self
]
