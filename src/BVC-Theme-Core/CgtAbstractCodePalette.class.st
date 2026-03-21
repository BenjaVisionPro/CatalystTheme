Class {
	#name : #CgtAbstractCodePalette,
	#superclass : #CgtAbstractPalette,
	#category : #'BVC-Theme-Core'
}

{ #category : #testing }
CgtAbstractCodePalette >> isCodePalette [
	^ true
]

{ #category : #testing }
CgtAbstractCodePalette >> isUiPalette [
	^ false
]
