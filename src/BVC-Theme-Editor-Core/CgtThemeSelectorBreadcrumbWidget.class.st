"
#Theme Selector Breadcrumb Widget
I am a simple non-Mondrian renderer for the theme selector model seam. I render the current projection as a compact breadcrumb-like row so the host widget can prove that selector semantics do not depend on Mondrian.
"
Class {
	#name : 'CgtThemeSelectorBreadcrumbWidget',
	#superclass : 'CgtThemeSelectorRendererWidget',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtThemeSelectorBreadcrumbWidget >> initialize [
	super initialize.
	self
		vFitContent;
		hMatchParent;
		cellSpacing: 6
]

{ #category : 'rendering' }
CgtThemeSelectorBreadcrumbWidget >> refreshContents [
	self removeChildren.
	projection ifNil: [ ^ self ].
	projection nodes doWithIndex: [ :aNode :anIndex |
		self addChild: (self newLabelForNode: aNode).
		anIndex < projection nodes size ifTrue: [
			self addChild: (BrLabel new
				aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
				text: '›') ] ].
	^ self
]

{ #category : 'rendering' }
CgtThemeSelectorBreadcrumbWidget >> newLabelForNode: aProjectionNode [
	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		text: (self labelForNode: aProjectionNode);
		yourself
]

{ #category : 'rendering' }
CgtThemeSelectorBreadcrumbWidget >> labelForNode: aProjectionNode [
	aProjectionNode representedElement ifNotNil: [ :anElement |
		^ anElement id ifNil: [ anElement class name ] ifNotNil: [ anElement id asString ] ].
	aProjectionNode className ifNotNil: [ :aClassName | ^ aClassName ].
	^ aProjectionNode kind asString
]
