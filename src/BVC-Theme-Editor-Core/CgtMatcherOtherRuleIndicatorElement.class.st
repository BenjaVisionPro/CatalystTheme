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
		cellSpacing: 3;
		padding: (BlInsets top: 2 right: 6 bottom: 2 left: 6);
		background: Color transparent;
		border: BlBorder empty;
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
		aptitude: (BrGlamorousLabelAptitude new foreground: (Color r: 0.72 g: 0.62 b: 0.22 alpha: 1.0));
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
		aptitude: (BrGlamorousLabelAptitude new foreground: (Color gray alpha: 0.8));
		text: text
]

{ #category : 'rendering' }
CgtMatcherOtherRuleIndicatorElement >> newRevealButton [
	^ BrButton new
		label: 'Show';
		background: Color transparent;
		border: (BlBorder paint: (Color gray alpha: 0.18) width: 1);
		aptitude: (BrGlamorousButtonLabelAptitude new) + (BrGlamorousButtonRectangularAptitude paddingScale: 0.32; cornerRadius: 6);
		action: [ :aButton | self requestOtherRuleContextToggle ];
		yourself
]

{ #category : 'events' }
CgtMatcherOtherRuleIndicatorElement >> requestOtherRuleContextToggle [
	self fireEvent: CgtMatcherOtherRuleContextToggledEvent new
]
