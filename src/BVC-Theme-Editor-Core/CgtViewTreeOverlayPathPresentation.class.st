"
#View Tree Overlay Path Presentation
I represent a path presentation for the overlay. I am responsible for carrying the information the overlay needs to render one path-oriented presentation cleanly.
"
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
CgtViewTreeOverlayPathPresentation class >> path: aPath kind: aSymbol [
	^ self new
		elementPath: aPath;
		kind: aSymbol;
		yourself
]

{ #category : 'accessing' }
CgtViewTreeOverlayPathPresentation >> elementPath [ ^ elementPath ]
{ #category : 'accessing' }
CgtViewTreeOverlayPathPresentation >> elementPath: aPath [ elementPath := aPath ]
{ #category : 'accessing' }
CgtViewTreeOverlayPathPresentation >> kind [ ^ kind ifNil: [ #primary ] ]
{ #category : 'accessing' }
CgtViewTreeOverlayPathPresentation >> kind: aSymbol [ kind := aSymbol ]
