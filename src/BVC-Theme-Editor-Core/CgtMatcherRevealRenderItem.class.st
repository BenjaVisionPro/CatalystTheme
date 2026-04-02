"
#Matcher Reveal Render Item
I represent one grouped revealed-context section in the custom selector widget. I am responsible for carrying the ordered revealed row items and reveal direction for one expanded hidden section without owning selector semantics or UI choreography.
"
Class {
	#name : 'CgtMatcherRevealRenderItem',
	#superclass : 'CgtMatcherRenderItem',
	#instVars : [
		'rowItems',
		'direction'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtMatcherRevealRenderItem >> initialize [
	super initialize.
	self kind: #reveal.
	rowItems := OrderedCollection new.
	direction := #upstream
]

{ #category : 'accessing' }
CgtMatcherRevealRenderItem >> direction [
	^ direction
]

{ #category : 'accessing' }
CgtMatcherRevealRenderItem >> direction: aSymbol [
	direction := aSymbol ifNil: [ #upstream ].
	^ self
]

{ #category : 'testing' }
CgtMatcherRevealRenderItem >> isRevealItem [
	^ true
]

{ #category : 'accessing' }
CgtMatcherRevealRenderItem >> renderKey [
	| key |
	key := rowItems collect: [ :each |
		each projectionNode ifNil: [ nil ] ifNotNil: [ :aNode |
			aNode representedElement ifNotNil: [ :anElement | anElement ] ifNil: [
				Array with: aNode kind with: aNode className with: aNode elementId ] ] ].
	^ Array with: self kind with: direction with: key asArray
]

{ #category : 'accessing' }
CgtMatcherRevealRenderItem >> rowItems [
	^ rowItems copy
]

{ #category : 'accessing' }
CgtMatcherRevealRenderItem >> rowItems: aCollection [
	rowItems := (aCollection ifNil: [ #() ]) asOrderedCollection.
	^ self
]
