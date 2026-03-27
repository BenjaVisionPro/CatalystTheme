Class {
	#name : 'CgtThemeClassPredicate',
	#superclass : 'CgtThemeSelectorPredicate',
	#instVars : [
		'elementClass'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'instance creation' }
CgtThemeClassPredicate class >> elementClass: aClass [
	^ self new elementClass: aClass; yourself
]

{ #category : 'accessing' }
CgtThemeClassPredicate >> elementClass [ ^ elementClass ]
{ #category : 'accessing' }
CgtThemeClassPredicate >> elementClass: aClass [ elementClass := aClass ]

{ #category : 'testing' }
CgtThemeClassPredicate >> matchesElement: anElement [
	^ anElement notNil and: [ anElement class == elementClass ]
]

{ #category : 'printing' }
CgtThemeClassPredicate >> displayString [
	^ elementClass ifNil: [ '' ] ifNotNil: [ elementClass name ]
]
