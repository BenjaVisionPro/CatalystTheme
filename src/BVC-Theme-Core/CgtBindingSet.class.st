Class {
	#name : #CgtBindingSet,
	#superclass : #Object,
	#instVars : [
		'bindings'
	],
	#category : #'BVC-Theme-Core'
}

{ #category : #adding }
CgtBindingSet >> addBinding: aBinding [
	bindings add: aBinding
]

{ #category : #adding }
CgtBindingSet >> addBindings: aCollection [
	bindings addAll: aCollection
]

{ #category : #accessing }
CgtBindingSet >> bindingForConsumerSelector: aSelector [
	^ bindings
		detect: [ :each | each consumerSelector = aSelector ]
		ifNone: [ nil ]
]

{ #category : #accessing }
CgtBindingSet >> bindings [
	^ bindings asArray
]

{ #category : #accessing }
CgtBindingSet >> bindingsForConsumerSelector: aSelector [
	^ bindings select: [ :each | each consumerSelector = aSelector ]
]

{ #category : #testing }
CgtBindingSet >> hasBindingForConsumerSelector: aSelector [
	^ (self bindingForConsumerSelector: aSelector) isNotNil
]

{ #category : #initialization }
CgtBindingSet >> initialize [
	super initialize.
	bindings := OrderedCollection new
]

{ #category : #resolving }
CgtBindingSet >> valueForConsumerSelector: aSelector fromPalette: aPalette [
	| binding |
	binding := self bindingForConsumerSelector: aSelector.
	binding ifNil: [ self error: 'No binding for consumer selector: ', aSelector asString ].
	^ binding valueFromPalette: aPalette
]
