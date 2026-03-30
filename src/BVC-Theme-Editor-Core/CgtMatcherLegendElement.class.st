"
#Matcher Legend Element
I render a compact legend for the matcher graph. I am responsible for making node and relation semantics visible in the UI without teaching the graph widget any extra editorial meaning.
"
Class {
	#name : 'CgtMatcherLegendElement',
	#superclass : 'BrVerticalPane',
	#instVars : [
		'nodeVisualPolicy',
		'relationVisualPolicy',
		'layoutPolicy'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtMatcherLegendElement >> initialize [
	super initialize.
	nodeVisualPolicy := CgtMatcherNodeVisualPolicy new.
	relationVisualPolicy := CgtMatcherRelationVisualPolicy new.
	layoutPolicy := CgtMatcherLayoutPolicy new.
	self
		vFitContent;
		hMatchParent;
		padding: layoutPolicy legendPadding;
		cellSpacing: layoutPolicy legendCellSpacing;
		background: (Color white alpha: 0.65);
		border: (BlBorder paint: (Color gray alpha: 0.15)).
	self refreshContents
]

{ #category : 'rendering' }
CgtMatcherLegendElement >> refreshContents [
	self removeChildren.
	self addChild: (self newHeaderLabel).
	self addChild: (self newRoleLegendRow).
	self addChild: (self newRelationLegendRow)
]

{ #category : 'rendering' }
CgtMatcherLegendElement >> newHeaderLabel [
	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		text: 'Matcher legend'
]

{ #category : 'rendering' }
CgtMatcherLegendElement >> newRoleLegendRow [
	| row |
	row := BrHorizontalPane new
		vFitContent;
		hFitContent;
		cellSpacing: 4.
	row addChildren: {
		(self newRoleBadgeLabeled: (nodeVisualPolicy roleLabelForNode: (CgtMatcherProjectionNode kind: #selectedElement))).
		(self newRoleBadgeLabeled: (nodeVisualPolicy roleLabelForNode: (CgtMatcherProjectionNode kind: #upstreamScope))).
		(self newRoleBadgeLabeled: (nodeVisualPolicy roleLabelForNode: (CgtMatcherProjectionNode kind: #downstreamScope))).
		(self newRoleBadgeLabeled: (nodeVisualPolicy roleLabelForNode: (CgtMatcherProjectionNode kind: #compactedSection))).
		(self newRoleBadgeLabeled: (nodeVisualPolicy roleLabelForNode: (CgtMatcherProjectionNode kind: #otherRuleRelated))) }.
	^ row
]

{ #category : 'rendering' }
CgtMatcherLegendElement >> newRelationLegendRow [
	| row childRelation descendantRelation otherRuleRelation |
	childRelation := CgtMatcherProjectionRelation from: CgtMatcherProjectionNode new to: CgtMatcherProjectionNode new kind: #matcher.
	descendantRelation := (CgtMatcherProjectionRelation from: CgtMatcherProjectionNode new to: CgtMatcherProjectionNode new kind: #matcher)
		combinator: #descendant;
		yourself.
	otherRuleRelation := CgtMatcherProjectionRelation from: CgtMatcherProjectionNode new to: CgtMatcherProjectionNode new kind: #otherRule.
	row := BrHorizontalPane new
		vFitContent;
		hFitContent;
		cellSpacing: 4.
	row addChildren: {
		(self newRelationBadgeFor: childRelation).
		(self newRelationBadgeFor: descendantRelation).
		(self newRelationBadgeFor: otherRuleRelation) }.
	^ row
]

{ #category : 'rendering' }
CgtMatcherLegendElement >> newRoleBadgeLabeled: aString [
	^ BrLabel new
		beSmallSize;
		padding: (BlInsets top: 2 right: 5 bottom: 2 left: 5);
		background: (Color black alpha: 0.05);
		aptitude: (BrGlamorousLabelAptitude new foreground: Color black);
		text: aString
]

{ #category : 'rendering' }
CgtMatcherLegendElement >> newRelationBadgeFor: aRelation [
	^ BrLabel new
		beSmallSize;
		padding: (BlInsets top: 2 right: 5 bottom: 2 left: 5);
		background: ((relationVisualPolicy colorForRelation: aRelation) alpha: 0.12);
		aptitude: (BrGlamorousLabelAptitude new foreground: Color black);
		text: (relationVisualPolicy labelForRelation: aRelation)
]
