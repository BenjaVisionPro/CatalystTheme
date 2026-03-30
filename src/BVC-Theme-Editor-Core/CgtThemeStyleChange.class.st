Class {
	#name : 'CgtThemeStyleChange',
	#superclass : 'Object',
	#instVars : [
		'propertyName',
		'value'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
	#comment : 'I am responsible for representing one style change in a theme rule. I capture a single change so style rules can describe what should be altered independently of how elements are matched.'
}

{ #category : 'instance creation' }
CgtThemeStyleChange class >> propertyName: aSymbol value: anObject [
	^ self new
		propertyName: aSymbol;
		value: anObject;
		yourself
]

{ #category : 'accessing' }
CgtThemeStyleChange >> propertyName [ ^ propertyName ]
{ #category : 'accessing' }
CgtThemeStyleChange >> propertyName: aSymbol [ propertyName := aSymbol ]
{ #category : 'accessing' }
CgtThemeStyleChange >> value [ ^ value ]
{ #category : 'accessing' }
CgtThemeStyleChange >> value: anObject [ value := anObject ]
