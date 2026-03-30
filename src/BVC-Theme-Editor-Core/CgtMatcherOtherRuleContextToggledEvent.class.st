"
#Matcher Other Rule Context Toggled Event
I announce that the matcher UI requested hidden other-rule context to be shown or hidden. I carry the requested visibility state.
"
Class {
	#name : 'CgtMatcherOtherRuleContextToggledEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'shouldShow'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtMatcherOtherRuleContextToggledEvent >> shouldShow [
	^ shouldShow
]

{ #category : 'accessing' }
CgtMatcherOtherRuleContextToggledEvent >> shouldShow: aBoolean [
	shouldShow := aBoolean
]

{ #category : 'sending' }
CgtMatcherOtherRuleContextToggledEvent >> sendTo: anObject [
	anObject matcherOtherRuleContextToggledEvent: self
]
