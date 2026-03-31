"
#Matcher Visibility State
I hold temporary matcher visibility state such as which compacted gaps are currently revealed and whether other-rule context should be shown. I remain editor-side state only and never leak into selector rules.
"
Class {
	#name : 'CgtMatcherVisibilityState',
	#superclass : 'Object',
	#instVars : [
		'expandedGapKeys',
		'showsOtherRuleContext'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'initialization' }
CgtMatcherVisibilityState >> initialize [
	super initialize.
	expandedGapKeys := OrderedCollection new.
	showsOtherRuleContext := false
]

{ #category : 'private' }
CgtMatcherVisibilityState >> gapIdentityForElements: aCollection [
	^ ((aCollection ifNil: [ #() ]) collect: [ :each |
		(each respondsTo: #id)
			ifTrue: [ each id ]
			ifFalse: [ each identityHash ] ]) asArray
]

{ #category : 'accessing' }
CgtMatcherVisibilityState >> showsOtherRuleContext [
	^ showsOtherRuleContext
]

{ #category : 'accessing' }
CgtMatcherVisibilityState >> showsOtherRuleContext: aBoolean [
	showsOtherRuleContext := aBoolean.
	^ self
]

{ #category : 'testing' }
CgtMatcherVisibilityState >> isExpandedForElements: aCollection [
	^ self isExpandedForGapIdentity: (self gapIdentityForElements: aCollection)
]

{ #category : 'mutating' }
CgtMatcherVisibilityState >> expandElements: aCollection [
	^ self expandGapIdentity: (self gapIdentityForElements: aCollection)
]

{ #category : 'mutating' }
CgtMatcherVisibilityState >> collapseElements: aCollection [
	^ self collapseGapIdentity: (self gapIdentityForElements: aCollection)
]


{ #category : 'testing' }
CgtMatcherVisibilityState >> hasExpandedGaps [
	^ expandedGapKeys isNotEmpty
]

{ #category : 'mutating' }
CgtMatcherVisibilityState >> clearExpandedGaps [
	expandedGapKeys removeAll.
	^ self
]


{ #category : 'testing' }
CgtMatcherVisibilityState >> isExpandedForGapIdentity: aGapIdentity [
	^ expandedGapKeys includes: aGapIdentity
]

{ #category : 'mutating' }
CgtMatcherVisibilityState >> expandGapIdentity: aGapIdentity [
	(aGapIdentity isNil or: [ aGapIdentity isEmpty ]) ifTrue: [ ^ self ].
	(expandedGapKeys includes: aGapIdentity) ifFalse: [ expandedGapKeys add: aGapIdentity ].
	^ self
]

{ #category : 'mutating' }
CgtMatcherVisibilityState >> collapseGapIdentity: aGapIdentity [
	expandedGapKeys remove: aGapIdentity ifAbsent: [ ].
	^ self
]
