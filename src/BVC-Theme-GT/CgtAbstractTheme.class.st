Class {
	#name : #CgtAbstractTheme,
	#superclass : #BrGlamorousTheme,
	#instVars : [
		'uiPalette',
		'codePalette',
		'bindings'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #'class defaults' }
CgtAbstractTheme class >> buttonThemeClass [
	self subclassResponsibility
]

{ #category : #'class defaults' }
CgtAbstractTheme class >> colorsClass [
	self subclassResponsibility
]

{ #category : #'class defaults' }
CgtAbstractTheme class >> defaultThemeClass [
	self subclassResponsibility
]

{ #category : #'class defaults' }
CgtAbstractTheme class >> editorThemeClass [
	self subclassResponsibility
]

{ #category : #'class defaults' }
CgtAbstractTheme class >> headerThemeClass [
	self subclassResponsibility
]

{ #category : #'class defaults' }
CgtAbstractTheme class >> itemThemeClass [
	self subclassResponsibility
]

{ #category : #accessing }
CgtAbstractTheme >> bindings [
	^ bindings
]

{ #category : #accessing }
CgtAbstractTheme >> bindings: anObject [
	bindings := anObject
]

{ #category : #accessing }
CgtAbstractTheme >> codePalette [
	^ codePalette
]

{ #category : #accessing }
CgtAbstractTheme >> codePalette: anObject [
	codePalette := anObject
]

{ #category : #initialization }
CgtAbstractTheme >> initialize [
	super initialize.
	self initializePalettes.
	self initializeBindings.
	self initializeSubthemes
]

{ #category : #initialization }
CgtAbstractTheme >> initializeBindings [
	bindings := CgtBindingSet new
]

{ #category : #initialization }
CgtAbstractTheme >> initializePalettes [
	self subclassResponsibility
]

{ #category : #initialization }
CgtAbstractTheme >> initializeSubthemes [
	colors := self class colorsClass theme: self.
	link := BrGlamorousLinkTheme new.
	status := BrGlamorousStatusTheme new.
	default := self class defaultThemeClass theme: self.
	default initializeThemeable.
	editor := self class editorThemeClass theme: self.
	editor initializeThemeable.
	button := self class buttonThemeClass theme: self.
	button initializeThemeable.
	item := self class itemThemeClass theme: self.
	item initializeThemeable.
	header := self class headerThemeClass theme: self.
	header initializeThemeable.
	label := BrGlamorousLabelTheme theme: self.
	label initializeThemeable
]

{ #category : #'theme lifecycle' }
CgtAbstractTheme >> onThemeModified [
	super onThemeModified.
	item ifNotNil: [ item initializeThemeable ]
]

{ #category : #accessing }
CgtAbstractTheme >> uiPalette [
	^ uiPalette
]

{ #category : #accessing }
CgtAbstractTheme >> uiPalette: anObject [
	uiPalette := anObject
]
