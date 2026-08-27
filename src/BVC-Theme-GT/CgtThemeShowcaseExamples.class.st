Class {
	#name : #CgtThemeShowcaseExamples,
	#superclass : #Object,
	#category : #'BVC-Theme-GT'
}

{ #category : #examples }
CgtThemeShowcaseExamples class >> lightAndDark [
	| aRow |
	aRow := BrHorizontalPane new
		hMatchParent;
		vFitContent;
		cellSpacing: 16;
		padding: (BlInsets all: 16);
		yourself.
	aRow
		addChild: (CgtThemeShowcaseElement new
			theme: CgtLightTheme new;
			constraintsDo: [ :c | c horizontal matchParent ];
			build);
		addChild: (CgtThemeShowcaseElement new
			theme: CgtDarkTheme new;
			constraintsDo: [ :c | c horizontal matchParent ];
			build).
	^ BrScrollPane new
		aptitude: BrScrollPaneAptitude + BrGlamorousWithVerticalScrollbarAptitude;
		matchParent;
		content: aRow;
		yourself
]

{ #category : #examples }
CgtThemeShowcaseExamples class >> buttonExteriorResolvesThemeablePaints [
	| aTheme anAptitude |
	aTheme := CgtLightTheme new.
	anAptitude := BrGlamorousButtonExteriorAptitude new.
	anAptitude theme: aTheme.
	self assert: anAptitude backgroundPaint class equals: Color.
	self assert: anAptitude borderPaint class equals: Color.
	^ anAptitude
]

{ #category : #examples }
CgtThemeShowcaseExamples class >> standardControlPaintValuesAreConcrete [
	| aTheme |
	aTheme := CgtDarkTheme new.
	self assert: aTheme item defaultColor class equals: Color.
	self assert: aTheme item hoveredColor class equals: Color.
	self assert: aTheme item selectedColor class equals: Color.
	self assert: aTheme item pressedColor class equals: Color.
	self assert:
		(aTheme highlight color blocResolveColorForTheme: aTheme) class
		equals: Color.
	^ aTheme
]

{ #category : #examples }
CgtThemeShowcaseExamples class >> toggleSemanticForegrounds [
	| aLightTheme aDarkTheme resolve |
	aLightTheme := CgtLightTheme new.
	aDarkTheme := CgtDarkTheme new.
	resolve := [ :aColor :aTheme | aColor blocResolveColorForTheme: aTheme ].

	self
		assert: (resolve value: aLightTheme label defaultTextForeground value: aLightTheme)
		equals: (resolve value: aLightTheme typography primaryForeground value: aLightTheme).
	self
		assert: (resolve value: aDarkTheme label defaultTextForeground value: aDarkTheme)
		equals: (resolve value: aDarkTheme typography primaryForeground value: aDarkTheme).
	self
		assert: (resolve value: aDarkTheme highlight foregroundColor value: aDarkTheme)
		equals: Color white.
	^ aDarkTheme
]
