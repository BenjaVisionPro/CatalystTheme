Class {
	#name : 'CgtThemeEditorOverlayRegion',
	#superclass : 'Object',
	#instVars : [
		'element',
		'dimAlpha',
		'inset',
		'cornerRadius',
		'priority',
		'explicitRectangle'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtThemeEditorOverlayRegion >> cornerRadius [
	^ cornerRadius ifNil: [ 0 ]
]

{ #category : 'accessing' }
CgtThemeEditorOverlayRegion >> cornerRadius: aNumber [
	cornerRadius := aNumber
]

{ #category : 'accessing' }
CgtThemeEditorOverlayRegion >> dimAlpha [
	^ dimAlpha ifNil: [ 0.45 ]
]

{ #category : 'accessing' }
CgtThemeEditorOverlayRegion >> dimAlpha: aNumber [
	dimAlpha := aNumber
]

{ #category : 'accessing' }
CgtThemeEditorOverlayRegion >> element [
	^ element
]

{ #category : 'accessing' }
CgtThemeEditorOverlayRegion >> element: anElement [
	element := anElement
]

{ #category : 'accessing' }
CgtThemeEditorOverlayRegion >> inset [
	^ inset ifNil: [ 0 ]
]

{ #category : 'accessing' }
CgtThemeEditorOverlayRegion >> inset: aNumber [
	inset := aNumber
]

{ #category : 'accessing' }
CgtThemeEditorOverlayRegion >> priority [
	^ priority ifNil: [ 0 ]
]

{ #category : 'accessing' }
CgtThemeEditorOverlayRegion >> priority: aNumber [
	priority := aNumber
]



{ #category : 'accessing' }
CgtThemeEditorOverlayRegion >> explicitRectangle [
	^ explicitRectangle
]

{ #category : 'accessing' }
CgtThemeEditorOverlayRegion >> explicitRectangle: aRectangle [
	explicitRectangle := aRectangle
]

{ #category : 'geometry' }
CgtThemeEditorOverlayRegion >> rectangleInOverlay: anOverlay [
	| aRectangle delta |
	aRectangle := explicitRectangle ifNotNil: [ explicitRectangle ] ifNil: [
		element ifNil: [ ^ nil ].
		anOverlay boundsRectFor: element ].
	delta := self inset.
	delta = 0 ifTrue: [ ^ aRectangle ].
	^ ((aRectangle left - delta) @ (aRectangle top - delta))
		corner: ((aRectangle right + delta) @ (aRectangle bottom + delta))
]
