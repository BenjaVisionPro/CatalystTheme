Class {
	#name : #BrGtAbstractTheme,
	#superclass : #BrGlamorousTheme,
	#category : #'BVC-Theme-Core'
}

{ #category : #'class defaults' }
BrGtAbstractTheme class >> buttonThemeClass [
	self subclassResponsibility
]

{ #category : #'class defaults' }
BrGtAbstractTheme class >> colorsClass [
	self subclassResponsibility
]

{ #category : #'class defaults' }
BrGtAbstractTheme class >> defaultThemeClass [
	self subclassResponsibility
]

{ #category : #'class defaults' }
BrGtAbstractTheme class >> editorThemeClass [
	self subclassResponsibility
]

{ #category : #'class defaults' }
BrGtAbstractTheme class >> headerThemeClass [
	self subclassResponsibility
]

{ #category : #'class defaults' }
BrGtAbstractTheme class >> itemThemeClass [
	self subclassResponsibility
]

{ #category : #'class defaults' }
BrGtAbstractTheme class >> labelThemeClass [
	self subclassResponsibility
]

{ #category : #initialization }
BrGtAbstractTheme >> initialize [
	super initialize.

	colors := self class colorsClass theme: self.
	link := BrGlamorousLinkTheme new.
	status := BrGlamorousStatusTheme new.
	default := self class defaultThemeClass theme: self.
	default initializeThemeable.
	editor := self class editorThemeClass theme: self.
	editor initializeThemeable.
	button := self class buttonThemeClass theme: self.
	button initializeThemeable.
	item := self class itemThemeClass
		colors: colors
		theme: self.
	header := self class headerThemeClass theme: self.
	header initializeThemeable.
	label := self class labelThemeClass theme: self.
	label initializeThemeable
]
