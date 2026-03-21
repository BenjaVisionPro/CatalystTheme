Class {
	#name : #CgtSemanticRole,
	#superclass : #Object,
	#instVars : [
		'name',
		'domain',
		'kind',
		'description',
		'state',
		'notes'
	],
	#category : #'BVC-Theme-Core'
}

{ #category : #'instance creation' }
CgtSemanticRole class >> named: aSymbol domain: aDomainSymbol kind: aKindSymbol [
	^ self new
		name: aSymbol;
		domain: aDomainSymbol;
		kind: aKindSymbol;
		yourself
]

{ #category : #'instance creation' }
CgtSemanticRole class >> named: aSymbol domain: aDomainSymbol kind: aKindSymbol description: aString [
	^ self new
		name: aSymbol;
		domain: aDomainSymbol;
		kind: aKindSymbol;
		description: aString;
		yourself
]

{ #category : #comparing }
CgtSemanticRole >> = anObject [
	self class = anObject class ifFalse: [ ^ false ].
	^ name = anObject name
		and: [ domain = anObject domain
		and: [ kind = anObject kind ] ]
]

{ #category : #accessing }
CgtSemanticRole >> description [
	^ description
]

{ #category : #accessing }
CgtSemanticRole >> description: aString [
	description := aString
]

{ #category : #accessing }
CgtSemanticRole >> domain [
	^ domain
]

{ #category : #accessing }
CgtSemanticRole >> domain: aSymbol [
	domain := aSymbol
]

{ #category : #testing }
CgtSemanticRole >> hasState [
	^ state isNotNil
]

{ #category : #comparing }
CgtSemanticRole >> hash [
	^ name hash bitXor: domain hash bitXor: kind hash
]

{ #category : #testing }
CgtSemanticRole >> isCodeRole [
	^ domain = #code
]

{ #category : #testing }
CgtSemanticRole >> isUiRole [
	^ domain = #ui
]

{ #category : #accessing }
CgtSemanticRole >> kind [
	^ kind
]

{ #category : #accessing }
CgtSemanticRole >> kind: aSymbol [
	kind := aSymbol
]

{ #category : #accessing }
CgtSemanticRole >> name [
	^ name
]

{ #category : #accessing }
CgtSemanticRole >> name: aSymbol [
	name := aSymbol
]

{ #category : #accessing }
CgtSemanticRole >> notes [
	^ notes
]

{ #category : #accessing }
CgtSemanticRole >> notes: aString [
	notes := aString
]

{ #category : #printing }
CgtSemanticRole >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPutAll: '(';
		nextPutAll: name asString;
		nextPutAll: ')'
]

{ #category : #accessing }
CgtSemanticRole >> state [
	^ state
]

{ #category : #accessing }
CgtSemanticRole >> state: aSymbol [
	state := aSymbol
]
