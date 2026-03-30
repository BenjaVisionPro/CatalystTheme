"
#Theme Ordinal Predicate
I match an element by ordinal position. I am responsible for positional matching when selector structure needs it.
"
Class {
	#name : 'CgtThemeOrdinalPredicate',
	#superclass : 'CgtThemeSelectorPredicate',
	#instVars : [
		'ordinal'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'instance creation' }
CgtThemeOrdinalPredicate class >> ordinal: aSymbol [
	^ self new ordinal: aSymbol; yourself
]

{ #category : 'accessing' }
CgtThemeOrdinalPredicate >> ordinal [ ^ ordinal ]
{ #category : 'accessing' }
CgtThemeOrdinalPredicate >> ordinal: aSymbol [ ordinal := aSymbol ]

{ #category : 'testing' }
CgtThemeOrdinalPredicate >> matchesElement: anElement [
	| parent siblings index |
	anElement ifNil: [ ^ false ].
	ordinal = #all ifTrue: [ ^ true ].
	parent := anElement parent.
	parent ifNil: [ ^ false ].
	siblings := parent children.
	index := siblings indexOf: anElement ifAbsent: [ 0 ].
	index = 0 ifTrue: [ ^ false ].
	ordinal = #first ifTrue: [ ^ index = 1 ].
	ordinal = #last ifTrue: [ ^ index = siblings size ].
	ordinal = #odd ifTrue: [ ^ index odd ].
	ordinal = #even ifTrue: [ ^ index even ].
	^ false
]

{ #category : 'printing' }
CgtThemeOrdinalPredicate >> displayString [
	ordinal ifNil: [ ^ '' ].
	ordinal = #all ifTrue: [ ^ ':all' ].
	ordinal = #first ifTrue: [ ^ ':first' ].
	ordinal = #last ifTrue: [ ^ ':last' ].
	ordinal = #odd ifTrue: [ ^ ':odd' ].
	ordinal = #even ifTrue: [ ^ ':even' ].
	^ ':', ordinal asString
]
