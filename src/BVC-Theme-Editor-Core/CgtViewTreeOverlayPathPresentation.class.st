Class {
	#name : 'CgtViewTreeOverlayPathPresentation',
	#superclass : 'Object',
	#instVars : [
		'elementPath',
		'kind'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'instance creation' }
CgtViewTreeOverlayPathPresentation class >> kind: aKind path: anElementPath [
	^ self new
		kind: aKind;
		elementPath: anElementPath;
		yourself
]

{ #category : 'accessing' }
CgtViewTreeOverlayPathPresentation >> elementPath [
	^ elementPath
]

{ #category : 'accessing' }
CgtViewTreeOverlayPathPresentation >> elementPath: aPath [
	elementPath := aPath
]

{ #category : 'testing' }
CgtViewTreeOverlayPathPresentation >> isMatching [
	^ kind = #matching
]

{ #category : 'testing' }
CgtViewTreeOverlayPathPresentation >> isPrimary [
	^ kind = #primary
]

{ #category : 'accessing' }
CgtViewTreeOverlayPathPresentation >> kind [
	^ kind
]

{ #category : 'accessing' }
CgtViewTreeOverlayPathPresentation >> kind: aKind [
	kind := aKind
]
