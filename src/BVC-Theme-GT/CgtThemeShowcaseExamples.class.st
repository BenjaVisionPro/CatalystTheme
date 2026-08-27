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

{ #category : #examples }
CgtThemeShowcaseExamples class >> realDropdownMenu [
	| aMenuItems aButton |
	aMenuItems := BrMenuItems new.
	aMenuItems
		addItemId: #'theme-menu-first'
		label: 'First action'
		preview: 'preview'
		action: [ ];
		addItemId: #'theme-menu-second'
		label: 'Second action'
		shortcut: 'CMD+2'
		action: [ ].

	aButton := BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude;
		label: 'Open menu';
		addAptitude:
			(BrGlamorousWithExplicitDropdownAptitude new
				withoutHandle;
				menu: aMenuItems;
				yourself);
		theme: CgtDarkTheme new;
		yourself.

	self assert: aMenuItems items size equals: 2.
	^ aButton
]

{ #category : #examples }
CgtThemeShowcaseExamples class >> menuThemeStructure [
	| aLightTheme aDarkTheme aVanillaTheme |
	aLightTheme := CgtLightTheme new.
	aDarkTheme := CgtDarkTheme new.
	aVanillaTheme := BrGlamorousLightTheme new.

	self assert: aLightTheme menu menuCornerRadius equals: 10.
	self assert: aDarkTheme menu menuCornerRadius equals: 10.
	self assert: aLightTheme menu itemCornerRadius equals: 6.
	self assert: aDarkTheme menu itemCornerRadius equals: 6.
	self assert: aLightTheme menu containerShadowWidth equals: 0.
	self assert: aDarkTheme menu containerShadowWidth equals: 0.
	self assert: aLightTheme menu menuShadowWidth equals: 8.
	self assert: aDarkTheme menu menuShadowWidth equals: 8.

	"Vanilla Glamorous keeps its existing ownership model."
	self assert: aVanillaTheme menu menuCornerRadius equals: BrMenuConstants cornerRadius.
	self assert: aVanillaTheme menu containerShadowWidth equals: 2.
	self assert: aVanillaTheme menu menuShadowWidth equals: 0.
	^ aDarkTheme
]

{ #category : #examples }
CgtThemeShowcaseExamples class >> popoverUsesAnchorTheme [
	| aTheme anAnchor anAptitude anEvent aMenuContainer |
	aTheme := CgtDarkTheme new.
	anAnchor := BrButton new
		theme: aTheme;
		yourself.
	aMenuContainer := BrMenuSteppedElement new.
	anAptitude := BrGlamorousWithExplicitDropdownAptitude new.

	anEvent := BrPopoverAboutToShowEvent new
		anchorElement: anAnchor;
		menuContainer: aMenuContainer;
		yourself.
	anAptitude dispatchEvent: anEvent.

	self assert: aMenuContainer theme identicalTo: aTheme.
	^ aMenuContainer
]
