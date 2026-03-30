"
#Matcher Node Element
I render one matcher projection node as a Bloc widget. I am responsible for presenting passive node data for the Mondrian matcher view without deciding editor semantics.
"
Class {
	#name : 'CgtMatcherNodeElement',
	#superclass : 'BrVerticalPane',
	#instVars : [
		'projectionNode'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtMatcherNodeElement >> initialize [
	super initialize.
	self
		vFitContent;
		hFitContent;
		padding: (BlInsets all: 8);
		background: (Color white alpha: 0.95);
		border: (BlBorder paint: (Color gray alpha: 0.3));
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ]
]

{ #category : 'accessing' }
CgtMatcherNodeElement >> projectionNode [
	^ projectionNode
]

{ #category : 'accessing' }
CgtMatcherNodeElement >> projectionNode: aCgtMatcherProjectionNode [
	projectionNode := aCgtMatcherProjectionNode.
	self refreshContents.
	^ self
]

{ #category : 'rendering' }
CgtMatcherNodeElement >> refreshContents [
	self removeAllChildren.
	projectionNode ifNil: [ ^ self ].
	self background: (self backgroundForNode: projectionNode).
	self addChildren: {
		(self newTitleLabelFor: projectionNode).
		(self newElementIdLabelFor: projectionNode).
		(self newMatchStateRowFor: projectionNode) }
]

{ #category : 'rendering' }
CgtMatcherNodeElement >> backgroundForNode: aProjectionNode [
	aProjectionNode kind = #selectedElement ifTrue: [ ^ Color veryVeryLightGray ].
	aProjectionNode kind = #compactedSection ifTrue: [ ^ (Color gray alpha: 0.12) ].
	aProjectionNode isInOtherRule ifTrue: [ ^ (Color orange alpha: 0.12) ].
	^ (Color white alpha: 0.95)
]

{ #category : 'rendering' }
CgtMatcherNodeElement >> newTitleLabelFor: aProjectionNode [
	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		text: (aProjectionNode kind = #compactedSection
			ifTrue: [ self compactedTitleFor: aProjectionNode ]
			ifFalse: [ aProjectionNode className ifNil: [ 'Unspecified element' ] ])
]

{ #category : 'rendering' }
CgtMatcherNodeElement >> compactedTitleFor: aProjectionNode [
	^ aProjectionNode hiddenNodeCount asString , ' hidden node' , (aProjectionNode hiddenNodeCount = 1 ifTrue: [ '' ] ifFalse: [ 's' ])
]

{ #category : 'rendering' }
CgtMatcherNodeElement >> newElementIdLabelFor: aProjectionNode [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
		text: (aProjectionNode kind = #compactedSection
			ifTrue: [ 'Compacted section' ]
			ifFalse: [ self elementIdTextFor: aProjectionNode ])
]

{ #category : 'rendering' }
CgtMatcherNodeElement >> elementIdTextFor: aProjectionNode [
	^ aProjectionNode elementId
		ifNil: [ 'No element id' ]
		ifNotNil: [ '#' , aProjectionNode elementId asString ]
]

{ #category : 'rendering' }
CgtMatcherNodeElement >> newMatchStateRowFor: aProjectionNode [
	| row |
	row := BrHorizontalPane new
		vFitContent;
		hFitContent;
		cellSpacing: 4.
	row addChildren: {
		(self newBadgeLabeled: 'Class' active: aProjectionNode matchByClass).
		(self newBadgeLabeled: 'Id' active: aProjectionNode matchById).
		(self newBadgeLabeled: aProjectionNode kind asString active: aProjectionNode isInCurrentRule) }.
	^ row
]

{ #category : 'rendering' }
CgtMatcherNodeElement >> newBadgeLabeled: aString active: aBoolean [
	^ BrLabel new
		beSmallSize;
		padding: (BlInsets top: 2 right: 5 bottom: 2 left: 5);
		background: (aBoolean
			ifTrue: [ Color black alpha: 0.08 ]
			ifFalse: [ Color gray alpha: 0.06 ]);
		aptitude: (BrGlamorousLabelAptitude new
			foreground: (aBoolean ifTrue: [ Color black ] ifFalse: [ Color darkGray ]));
		text: aString
]
