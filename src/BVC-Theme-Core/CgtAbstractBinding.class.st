Class {
	#name : #CgtAbstractBinding,
	#superclass : #Object,
	#instVars : [
		'roleName',
		'consumerSelector'
	],
	#category : #'BVC-Theme-Core'
}

{ #category : #'instance creation' }
CgtAbstractBinding class >> roleNamed: aRoleName consumerSelector: aSelector [
	^ self new
		roleName: aRoleName;
		consumerSelector: aSelector;
		yourself
]

{ #category : #accessing }
CgtAbstractBinding >> consumerSelector [
	^ consumerSelector
]

{ #category : #accessing }
CgtAbstractBinding >> consumerSelector: aSelector [
	consumerSelector := aSelector
]

{ #category : #printing }
CgtAbstractBinding >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPutAll: '(';
		nextPutAll: roleName asString;
		nextPutAll: ' -> ';
		nextPutAll: consumerSelector asString;
		nextPutAll: ')'
]

{ #category : #accessing }
CgtAbstractBinding >> roleName [
	^ roleName
]

{ #category : #accessing }
CgtAbstractBinding >> roleName: aSymbol [
	roleName := aSymbol
]

{ #category : #resolving }
CgtAbstractBinding >> valueFromPalette: aPalette [
	^ aPalette valueForRoleNamed: roleName
]
