"
#Theme Selector Test Element
I am a tiny test double for selector domain tests. I provide parent and identifier behavior without pulling editor semantics into the tests.
"
Class {
	#name : 'CgtThemeSelectorTestElement',
	#superclass : 'Object',
	#instVars : [
		'id',
		'parent',
		'children'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtThemeSelectorTestElement >> initialize [
	super initialize.
	id := BlElementId noId.
	children := OrderedCollection new
]

{ #category : 'accessing' }
CgtThemeSelectorTestElement >> id [
	^ id
]

{ #category : 'accessing' }
CgtThemeSelectorTestElement >> id: aBlElementId [
	id := aBlElementId
]

{ #category : 'accessing' }
CgtThemeSelectorTestElement >> parent [
	^ parent
]

{ #category : 'accessing' }
CgtThemeSelectorTestElement >> parent: anElement [
	parent := anElement
]

{ #category : 'accessing' }
CgtThemeSelectorTestElement >> children [
	^ children copy
]

{ #category : 'building' }
CgtThemeSelectorTestElement >> addChild: anElement [
	children add: anElement.
	anElement parent: self.
	^ anElement
]


{ #category : 'instance creation' }
CgtThemeSelectorTestElement class >> named: aName id: anId [
	^ self new
		id: anId;
		yourself
]
