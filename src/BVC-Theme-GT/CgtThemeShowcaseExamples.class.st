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
CgtThemeShowcaseExamples class >> menuThemeChrome [
	| aLightTheme aDarkTheme aVanillaTheme resolve |
	aLightTheme := CgtLightTheme new.
	aDarkTheme := CgtDarkTheme new.
	aVanillaTheme := BrGlamorousLightTheme new.
	resolve := [ :aColor :aTheme | aColor blocResolveColorForTheme: aTheme ].

	self assert: aLightTheme menu cornerRadius equals: 12.
	self assert: aDarkTheme menu cornerRadius equals: 12.
	self
		assert: (resolve value: aLightTheme menu background value: aLightTheme)
		equals: (resolve value: aLightTheme surfaces baseBackground value: aLightTheme).
	self
		assert: (resolve value: aDarkTheme menu background value: aDarkTheme)
		equals: (resolve value: aDarkTheme surfaces baseBackground value: aDarkTheme).
	self
		assert: (resolve value: aLightTheme menu borderColor value: aLightTheme)
		equals: (resolve value: aLightTheme interaction pressedBackgroundTint value: aLightTheme).
	self
		assert: (resolve value: aDarkTheme menu borderColor value: aDarkTheme)
		equals: (resolve value: aDarkTheme interaction pressedBackgroundTint value: aDarkTheme).
	self assert: aLightTheme menu shadowWidth equals: 2.
	self assert: aDarkTheme menu shadowWidth equals: 2.

	"The Glamorous projection reproduces the stock BrPopoverContainerAptitude values."
	self assert: aVanillaTheme menu cornerRadius equals: BrMenuConstants cornerRadius.
	self assert: aVanillaTheme menu borderColor equals: Color veryLightGray.
	self assert: aVanillaTheme menu shadowWidth equals: 2.
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

{ #category : #examples }
CgtThemeShowcaseExamples class >> menuInsetMatchesDetailReference [
	| aTheme |
	aTheme := CgtDarkTheme new.
	self assert: aTheme menu cornerRadius equals: 12.
	self assert: aTheme menu contentInset equals: 5.
	self assert: aTheme menu itemCornerRadius equals: 7.
	^ aTheme
]

{ #category : #examples }
CgtThemeShowcaseExamples class >> menuInsetIsAppliedToSimpleList [
	| aMenuElement aList |
	aMenuElement := BrMenuItemsListElement new
		theme: CgtDarkTheme new;
		yourself.
	aList := aMenuElement childWithId: #'menu--list'.
	self assert: aList padding equals: (BlInsets all: 5).
	self assert: aMenuElement padding equals: BlInsets empty.
	^ aMenuElement
]

{ #category : #examples }
CgtThemeShowcaseExamples class >> menuItemGeometryFollowsInheritedTheme [
	| aTheme anItem anAptitude |
	aTheme := CgtDarkTheme new.
	anItem := BrMenuActionItemElement new.
	anAptitude := BrMenuItemAptitude new.
	anItem addAptitude: anAptitude.
	anItem theme: aTheme.

	self
		assert: anItem geometry cornerRadius
		equals: aTheme menu itemCornerRadius.
	^ anItem
]

{ #category : #examples }
CgtThemeShowcaseExamples class >> menuSelectionUsesExactHighlight [
	| aTheme |
	aTheme := CgtDarkTheme new.
	self
		assert:
			(aTheme highlight color
				blocResolveColorForTheme: aTheme)
		equals: aTheme themeState highlightColor.
	^ aTheme
]

{ #category : #examples }
CgtThemeShowcaseExamples class >> menuShortcutUsesSupportingTypography [
	| aTheme |
	aTheme := CgtDarkTheme new.
	self
		assert:
			(aTheme typography tertiaryForeground
				blocResolveColorForTheme: aTheme)
		equals: (Color white alpha: 0.55).
	^ aTheme
]
