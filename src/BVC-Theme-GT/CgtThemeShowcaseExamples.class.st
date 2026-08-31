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
			theme: CgtDetailLightTheme new;
			constraintsDo: [ :c | c horizontal matchParent ];
			build);
		addChild: (CgtThemeShowcaseElement new
			theme: CgtDetailDarkTheme new;
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
	aTheme := CgtDetailLightTheme new.
	anAptitude := BrGlamorousButtonExteriorAptitude new.
	anAptitude theme: aTheme.
	self assert: anAptitude backgroundPaint class equals: Color.
	self assert: anAptitude borderPaint class equals: Color.
	^ anAptitude
]

{ #category : #examples }
CgtThemeShowcaseExamples class >> standardControlPaintValuesAreConcrete [
	| aTheme |
	aTheme := CgtDetailDarkTheme new.
	self assert: aTheme item defaultColor class equals: Color.
	self assert: aTheme item hoveredColor class equals: Color.
	self assert: aTheme item selectedColor class equals: Color.
	self assert: aTheme item pressedColor class equals: Color.
	self assert:
		(aTheme appearanceState themeColour blocResolveColorForTheme: aTheme) class
		equals: Color.
	^ aTheme
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
		theme: CgtDetailDarkTheme new;
		yourself.

	self assert: aMenuItems items size equals: 2.
	^ aButton
]

{ #category : #examples }
CgtThemeShowcaseExamples class >> menuThemeChrome [
	| aLightTheme aDarkTheme aVanillaTheme resolve |
	aLightTheme := CgtDetailLightTheme new.
	aDarkTheme := CgtDetailDarkTheme new.
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
	self
		assert: (resolve value: aLightTheme tooltip borderColor value: aLightTheme)
		equals: (resolve value: aLightTheme interaction pressedBackgroundTint value: aLightTheme).
	self
		assert: (resolve value: aDarkTheme tooltip borderColor value: aDarkTheme)
		equals: (resolve value: aDarkTheme interaction pressedBackgroundTint value: aDarkTheme).
	self assert: aLightTheme tooltip cornerRadius equals: aLightTheme menu cornerRadius.
	self assert: aDarkTheme tooltip cornerRadius equals: aDarkTheme menu cornerRadius.
	self assert: aLightTheme tooltip fontSize equals: aLightTheme typography bodyFontSize.
	self assert: aDarkTheme tooltip fontSize equals: aDarkTheme typography bodyFontSize.
	self
		assert: (resolve value: aLightTheme tooltip foreground value: aLightTheme)
		equals: (resolve value: aLightTheme typography primaryForeground value: aLightTheme).
	self
		assert: (resolve value: aDarkTheme tooltip foreground value: aDarkTheme)
		equals: (resolve value: aDarkTheme typography primaryForeground value: aDarkTheme).

	"The Glamorous projection reproduces the stock BrPopoverContainerAptitude values."
	self assert: aVanillaTheme menu cornerRadius equals: BrMenuConstants cornerRadius.
	self assert: aVanillaTheme menu borderColor equals: Color veryLightGray.
	self assert: aVanillaTheme menu shadowWidth equals: 2.
	^ aDarkTheme
]

{ #category : #examples }
CgtThemeShowcaseExamples class >> popoverUsesAnchorTheme [
	| aTheme anAnchor anAptitude anEvent aMenuContainer |
	aTheme := CgtDetailDarkTheme new.
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
	aTheme := CgtDetailDarkTheme new.
	self assert: aTheme menu cornerRadius equals: 12.
	self assert: aTheme menu contentInset equals: 5.
	self assert: aTheme menu itemCornerRadius equals: 7.
	^ aTheme
]

{ #category : #examples }
CgtThemeShowcaseExamples class >> menuInsetIsAppliedToSimpleList [
	| aMenuElement aList |
	aMenuElement := BrMenuItemsListElement new
		theme: CgtDetailDarkTheme new;
		yourself.
	aList := aMenuElement childWithId: #'menu--list'.
	self assert: aList padding equals: (BlInsets all: 5).
	self assert: aMenuElement padding equals: BlInsets empty.
	^ aMenuElement
]

{ #category : #examples }
CgtThemeShowcaseExamples class >> menuItemGeometryFollowsInheritedTheme [
	| aTheme anItem anAptitude |
	aTheme := CgtDetailDarkTheme new.
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
CgtThemeShowcaseExamples class >> menuSelectionUsesExactThemeColour [
	| aTheme |
	aTheme := CgtDetailDarkTheme new.
	self
		assert:
			(aTheme appearanceState themeColour
				blocResolveColorForTheme: aTheme)
		equals: aTheme appearanceState themeColour.
	^ aTheme
]

{ #category : #examples }
CgtThemeShowcaseExamples class >> menuShortcutUsesSupportingTypography [
	| aTheme |
	aTheme := CgtDetailDarkTheme new.
	self
		assert:
			(aTheme typography tertiaryForeground
				blocResolveColorForTheme: aTheme)
		equals: (Color white alpha: 0.55).
	^ aTheme
]

{ #category : #examples }
CgtThemeShowcaseExamples >> stockGlamorousThemesProvideTooltipSemantics [
	| themes |
	themes := {
		BrGlamorousLightTheme new.
		BrGlamorousDarkTheme new }.

	themes do: [ :aTheme |
		self assert: aTheme tooltip borderColor isNotNil.
		self assert: aTheme tooltip borderColor equals: aTheme interaction pressedBackgroundTint.
		self assert: aTheme tooltip cornerRadius equals: aTheme menu cornerRadius.
		self assert: aTheme tooltip foreground equals: aTheme typography tertiaryForeground.
		self assert: aTheme tooltip fontSize equals: aTheme typography supportingFontSize ]
]
