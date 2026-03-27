Class {
	#name : 'CgtThemeCombinatorSelector',
	#superclass : 'CgtThemeSelector',
	#instVars : [
		'leftSelector',
		'combinator',
		'rightSelector'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'instance creation' }
CgtThemeCombinatorSelector class >> left: aLeftSelector combinator: aSymbol right: aRightSelector [
	^ self new
		leftSelector: aLeftSelector;
		combinator: aSymbol;
		rightSelector: aRightSelector;
		yourself
]

{ #category : 'accessing' }
CgtThemeCombinatorSelector >> leftSelector [ ^ leftSelector ]
{ #category : 'accessing' }
CgtThemeCombinatorSelector >> leftSelector: aSelector [ leftSelector := aSelector ]
{ #category : 'accessing' }
CgtThemeCombinatorSelector >> combinator [ ^ combinator ]
{ #category : 'accessing' }
CgtThemeCombinatorSelector >> combinator: aSymbol [ combinator := aSymbol ]
{ #category : 'accessing' }
CgtThemeCombinatorSelector >> rightSelector [ ^ rightSelector ]
{ #category : 'accessing' }
CgtThemeCombinatorSelector >> rightSelector: aSelector [ rightSelector := aSelector ]

{ #category : 'testing' }
CgtThemeCombinatorSelector >> matchesElement: anElement [
	rightSelector ifNil: [ ^ false ].
	(rightSelector matchesElement: anElement) ifFalse: [ ^ false ].
	combinator = #child ifTrue: [ ^ anElement parent notNil and: [ leftSelector matchesElement: anElement parent ] ].
	combinator = #descendant ifTrue: [
		| current |
		current := anElement parent.
		[current notNil] whileTrue: [
			(leftSelector matchesElement: current) ifTrue: [ ^ true ].
			current := current parent ].
		^ false ].
	^ false
]
