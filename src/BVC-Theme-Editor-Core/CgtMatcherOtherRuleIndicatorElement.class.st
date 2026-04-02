"
#Matcher Other Rule Indicator Element
I render the compact affordance for hidden other-rule context in the selector UI. I am responsible for explaining that related-rule context exists and for requesting that the selector host reveal it explicitly.
"
Class {
	#name : 'CgtMatcherOtherRuleIndicatorElement',
	#superclass : 'BrVerticalPane',
	#instVars : [
		'projectionNode'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtMatcherOtherRuleIndicatorElement >> initialize [
	super initialize.
	self
		vFitContent;
		hFitContent;
		cellSpacing: 4;
		padding: (BlInsets all: 4);
		background: (Color orange alpha: 0.08);
		border: (BlBorder paint: (Color orange alpha: 0.3));
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ]
]

{ #category : 'accessing' }
CgtMatcherOtherRuleIndicatorElement >> projectionNode [
	^ projectionNode
]

{ #category : 'accessing' }
CgtMatcherOtherRuleIndicatorElement >> projectionNode: aCgtMatcherProjectionNode [
	projectionNode := aCgtMatcherProjectionNode.
	self refreshContents.
	^ self
]

{ #category : 'rendering' }
CgtMatcherOtherRuleIndicatorElement >> refreshContents [
	self removeChildren.
	projectionNode ifNil: [ ^ self ].
	self addChildren: {
		(self newBadgeLabeled: 'Other rules').
		(self newCountLabel).
		(self newRevealButton) }.
	^ self
]

{ #category : 'rendering' }
CgtMatcherOtherRuleIndicatorElement >> newBadgeLabeled: aString [
	^ BrLabel new
		beSmallSize;
		aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
		text: aString
]

{ #category : 'rendering' }
CgtMatcherOtherRuleIndicatorElement >> newCountLabel [
	| count text |
	count := projectionNode hiddenNodeCount ifNil: [ 0 ].
	text := count = 1
		ifTrue: [ '1 hidden path' ]
		ifFalse: [ count asString , ' hidden paths' ].
	^ BrLabel new
		beSmallSize;
		aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
		text: text
]

{ #category : 'rendering' }
CgtMatcherOtherRuleIndicatorElement >> newRevealButton [
	^ BrButton new
		label: 'Show';
		aptitude: (BrGlamorousButtonLabelAptitude new) + (BrGlamorousButtonRectangularAptitude paddingScale: 0.45; cornerRadius: 4);
		action: [ :aButton | self requestOtherRuleContextToggle ];
		yourself
]

{ #category : 'events' }
CgtMatcherOtherRuleIndicatorElement >> requestOtherRuleContextToggle [
	self fireEvent: CgtMatcherOtherRuleContextToggledEvent new
]
