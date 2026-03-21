Class {
	#name : #CgtAbstractPalette,
	#superclass : #Object,
	#instVars : [
		'valuesByRoleName'
	],
	#category : #'BVC-Theme-Core'
}

{ #category : #accessing }
CgtAbstractPalette >> associations [
	^ valuesByRoleName associations
]

{ #category : #private }
CgtAbstractPalette >> errorMissingValueForRoleNamed: aSymbol [
	self error: 'Missing palette value for role: ', aSymbol asString
]

{ #category : #testing }
CgtAbstractPalette >> hasValueForRole: aRole [
	^ self hasValueForRoleNamed: aRole name
]

{ #category : #testing }
CgtAbstractPalette >> hasValueForRoleNamed: aSymbol [
	^ valuesByRoleName includesKey: aSymbol
]

{ #category : #initialization }
CgtAbstractPalette >> initialize [
	super initialize.
	valuesByRoleName := Dictionary new
]

{ #category : #testing }
CgtAbstractPalette >> isCodePalette [
	^ false
]

{ #category : #testing }
CgtAbstractPalette >> isUiPalette [
	^ false
]

{ #category : #accessing }
CgtAbstractPalette >> roleNames [
	^ valuesByRoleName keys asArray
]

{ #category : #accessing }
CgtAbstractPalette >> valueAtRoleNamed: aSymbol put: anObject [
	valuesByRoleName at: aSymbol put: anObject
]

{ #category : #accessing }
CgtAbstractPalette >> valueForRole: aRole [
	^ self valueForRoleNamed: aRole name
]

{ #category : #accessing }
CgtAbstractPalette >> valueForRoleNamed: aSymbol [
	^ valuesByRoleName
		at: aSymbol
		ifAbsent: [ self errorMissingValueForRoleNamed: aSymbol ]
]
