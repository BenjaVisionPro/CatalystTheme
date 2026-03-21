Class {
	#name : #CgtAbstractUIPalette,
	#superclass : #CgtAbstractPalette,
	#category : #'BVC-Theme-Core'
}

{ #category : #testing }
CgtAbstractUIPalette >> isCodePalette [
	^ false
]

{ #category : #testing }
CgtAbstractUIPalette >> isUiPalette [
	^ true
]
