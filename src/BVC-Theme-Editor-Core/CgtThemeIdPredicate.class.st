Class {
	#name : 'CgtThemeIdPredicate',
	#superclass : 'CgtThemeSelectorPredicate',
	#instVars : [
		'elementId'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
	#comment : 'I am responsible for matching elements by id within the theme selector model. I represent that one predicate explicitly so selector intent stays readable and composable.'
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
		and: [ anElement id ~= BlElementId noId ]
		and: [ anElement id = elementId ]
]

{ #category : 'printing' }
CgtThemeIdPredicate >> displayString [
	^ '#', elementId asString
]
