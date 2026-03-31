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
		'children',
		'className'
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
CgtThemeSelectorTestElement >> className [
	^ className ifNil: [ self class name ]
]

{ #category : 'accessing' }
CgtThemeSelectorTestElement >> className: aString [
	className := aString
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
CgtThemeSelectorTestElement class >> named: aSymbol id: anId [
	^ self new
		id: (BlElementId named: anId);
		yourself
]
