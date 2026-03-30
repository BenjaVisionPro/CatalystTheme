"
#Matcher Other Rule Indicator Element Tests
I verify that the compact other-rule indicator reflects hidden related-rule context and emits explicit toggle events.
"
Class {
	#name : 'CgtMatcherOtherRuleIndicatorElementTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtMatcherOtherRuleIndicatorElementTests >> testPublishesToggleEvent [
	| element event |
	element := CgtMatcherOtherRuleIndicatorElement new
		relatedRuleCount: 2;
		showsOtherRuleContext: false;
		yourself.
	element when: CgtMatcherOtherRuleContextToggledEvent do: [ :anEvent | event := anEvent ].
	element requestToggle.
	self assert: event notNil.
	self assert: event shouldShow
]
