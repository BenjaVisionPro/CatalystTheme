"
#Matcher Other Rule Indicator Element
I render a compact control that indicates hidden other-rule matcher context and lets the user temporarily show or hide it.
"
Class {
	#name : 'CgtMatcherOtherRuleIndicatorElement',
	#superclass : 'BrHorizontalPane',
	#instVars : [
		'relatedRuleCount',
		'showsOtherRuleContext',
		'layoutPolicy'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtMatcherOtherRuleIndicatorElement >> initialize [
	super initialize.
	layoutPolicy := CgtMatcherLayoutPolicy new.
	self
		vFitContent;
		hFitContent;
		cellSpacing: 4;
		padding: (BlInsets top: 3 right: 6 bottom: 3 left: 6);
		background: (Color veryLightGray alpha: 0.55);
		border: (BlBorder paint: (Color gray alpha: 0.18));
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ].
	relatedRuleCount := 0.
	showsOtherRuleContext := false
]

{ #category : 'accessing' }
CgtMatcherOtherRuleIndicatorElement >> relatedRuleCount [
	^ relatedRuleCount ifNil: [ 0 ]
]

{ #category : 'accessing' }
CgtMatcherOtherRuleIndicatorElement >> relatedRuleCount: anInteger [
	relatedRuleCount := anInteger ifNil: [ 0 ].
	self refreshContents.
	^ self
]

{ #category : 'accessing' }
CgtMatcherOtherRuleIndicatorElement >> showsOtherRuleContext [
	^ showsOtherRuleContext ifNil: [ false ]
]

{ #category : 'accessing' }
CgtMatcherOtherRuleIndicatorElement >> showsOtherRuleContext: aBoolean [
	showsOtherRuleContext := aBoolean.
	self refreshContents.
	^ self
]

{ #category : 'rendering' }
CgtMatcherOtherRuleIndicatorElement >> refreshContents [
	self removeChildren.
	self addChild: self newCountLabel.
	self addChild: self newToggleButton
]

{ #category : 'rendering' }
CgtMatcherOtherRuleIndicatorElement >> newCountLabel [
	| label |
	label := self relatedRuleCount = 1
		ifTrue: [ '1 other rule hidden' ]
		ifFalse: [ self relatedRuleCount asString , ' other rules hidden' ].
	^ BrLabel new
		beSmallSize;
		aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
		text: label
]

{ #category : 'rendering' }
CgtMatcherOtherRuleIndicatorElement >> newToggleButton [
	^ BrButton new
		label: (self showsOtherRuleContext ifTrue: [ 'Hide' ] ifFalse: [ 'Show' ]);
		aptitude: ((BrGlamorousButtonLabelAptitude new
				hoveredColor: Color black;
				pressedColor: Color black) +
			(BrGlamorousButtonRectangularAptitude
				paddingScale: 0.4;
				cornerRadius: 4) +
			(BrStyleCommonAptitude new default: [ :aStyle |
				aStyle background: (self showsOtherRuleContext
					ifTrue: [ Color gray alpha: 0.18 ]
					ifFalse: [ Color transparent ]) ]));
		action: [ :aButton | self requestToggle ];
		yourself
]

{ #category : 'events' }
CgtMatcherOtherRuleIndicatorElement >> requestToggle [
	self fireEvent: (CgtMatcherOtherRuleContextToggledEvent new
		shouldShow: self showsOtherRuleContext not;
		yourself)
]
