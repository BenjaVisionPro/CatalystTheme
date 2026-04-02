"
#Matcher Other Rule Indicator Render Item
I represent compact hidden other-rule context in the custom selector widget. I am responsible for carrying the minimal rendering facts needed to show an indicator without changing active-rule semantics.
"
Class {
	#name : 'CgtMatcherOtherRuleIndicatorRenderItem',
	#superclass : 'CgtMatcherRenderItem',
	#instVars : [
		'hiddenCount'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtMatcherOtherRuleIndicatorRenderItem >> initialize [
	super initialize.
	self kind: #otherRuleIndicator.
	hiddenCount := 0
]

{ #category : 'accessing' }
CgtMatcherOtherRuleIndicatorRenderItem >> hiddenCount [
	^ hiddenCount
]

{ #category : 'accessing' }
CgtMatcherOtherRuleIndicatorRenderItem >> hiddenCount: anInteger [
	hiddenCount := anInteger.
	^ self
]

{ #category : 'testing' }
CgtMatcherOtherRuleIndicatorRenderItem >> isOtherRuleIndicatorItem [
	^ true
]

{ #category : 'accessing' }
CgtMatcherOtherRuleIndicatorRenderItem >> renderKey [
	^ Array with: self kind with: hiddenCount
]
