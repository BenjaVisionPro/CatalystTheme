"
#Theme Id Predicate
I match an element by identifier. I am responsible for expressing id-based selector matching.
"
Class {
	#name : 'CgtThemeIdPredicate',
	#superclass : 'CgtThemeSelectorPredicate',
	#instVars : [
		'elementId'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'instance creation' }
CgtThemeIdPredicate class >> elementId: anElementId [
	^ self new elementId: anElementId; yourself
]

{ #category : 'accessing' }
CgtThemeIdPredicate >> elementId [ ^ elementId ]
{ #category : 'accessing' }
CgtThemeIdPredicate >> elementId: anElementId [ elementId := anElementId ]

{ #category : 'testing' }
CgtThemeIdPredicate >> matchesElement: anElement [
	^ anElement notNil
		and: [
			(anElement id ~= BlElementId noId)
				and: [ anElement id = elementId ] ]
]

{ #category : 'printing' }
CgtThemeIdPredicate >> displayString [
	^ '#', elementId asString
]
