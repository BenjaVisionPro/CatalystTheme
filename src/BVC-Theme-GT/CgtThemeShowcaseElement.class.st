Class {
	#name : #CgtThemeShowcaseElement,
	#superclass : #BrVerticalPane,
	#category : #'BVC-Theme-GT'
}

{ #category : #building }
CgtThemeShowcaseElement >> build [
	self removeChildren.
	self
		hMatchParent;
		vFitContent;
		cellSpacing: 16;
		padding: (BlInsets all: 20);
		background: (self resolvedColor: self theme default contentBackground).

	self
		addChild: self buildTypographySection;
		addChild: self buildBrickSection.
	^ self
]

{ #category : #'building - sections' }
CgtThemeShowcaseElement >> buildBrickSection [
	| aSection aRow aMenuItems aDropdown |
	aSection := self newSectionNamed: 'Brick controls'.
	aRow := BrHorizontalPane new
		hMatchParent;
		vFitContent;
		cellSpacing: 10;
		yourself.
	aSection addChild: aRow.
	aRow
		addChild: (BrButton new
			aptitude: BrGlamorousButtonWithLabelAptitude;
			label: 'Button';
			hFitContent;
			yourself);
		addChild: (BrEditor new
			aptitude: BrGlamorousEditorAptitude + BrGlamorousInputFieldSpacingAptitude;
			text: 'Editor';
			hExact: 160;
			vFitContent;
			yourself);
		addChild: (BrCheckbox new
			aptitude: BrGlamorousCheckboxAptitude;
			check;
			yourself).

	aSection addChild: (BrToggleGroup new
		aptitude: BrGlamorousToggleGroupAptitude new;
		addToggle: (BrToggle new
			aptitude: BrGlamorousToggleWithLabelAptitude new;
			label: 'One';
			activate;
			yourself);
		addToggle: (BrToggle new
			aptitude: BrGlamorousToggleWithLabelAptitude new;
			label: 'Two';
			yourself);
		yourself).

	aMenuItems := BrMenuItems new.
	aMenuItems
		addItemId: #'theme-menu-first'
		label: 'First action'
		preview: 'preview'
		action: [ ];
		addItemId: #'theme-menu-second'
		label: 'Second action'
		shortcut: 'CMD+2'
		action: [ ];
		addItemId: #'theme-menu-third'
		label: 'Third action'
		action: [ ].

	aDropdown := BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude;
		label: 'Open menu';
		hFitContent;
		addAptitude:
			(BrGlamorousWithExplicitDropdownAptitude new
				withoutHandle;
				menu: aMenuItems;
				yourself);
		yourself.
	aSection addChild: aDropdown.

	aSection
		addChild: (self swatchNamed: 'Menu default' color: self theme item defaultColor);
		addChild: (self swatchNamed: 'Menu hovered' color: self theme item hoveredColor);
		addChild: (self swatchNamed: 'Menu selected' color: self theme item selectedColor);
		addChild: (self swatchNamed: 'Menu pressed' color: self theme item pressedColor).
	^ aSection
]

{ #category : #'building - sections' }
CgtThemeShowcaseElement >> buildTypographySection [
	| aSection |
	aSection := self newSectionNamed: 'Typography'.
	aSection
		addChild: (self typographySample: 'Title' size: self theme typography titleFontSize color: self theme label defaultTextForeground);
		addChild: (self typographySample: 'Group heading' size: self theme typography groupHeadingFontSize color: self theme label defaultTextForeground);
		addChild: (self typographySample: 'Body' size: self theme typography bodyFontSize color: self theme label defaultTextForeground);
		addChild: (self typographySample: 'Summary' size: self theme typography bodyFontSize color: self theme label summaryTextForeground);
		addChild: (self typographySample: 'Supporting' size: self theme typography supportingFontSize color: self theme label summaryTextForeground);
		addChild: (self typographySample: 'Metadata' size: self theme typography metadataFontSize color: self theme label metadataTextForeground).
	^ aSection
]

{ #category : #'building - helpers' }
CgtThemeShowcaseElement >> newSectionNamed: aString [
	| aSection aLabel |
	aSection := BrVerticalPane new
		hMatchParent;
		vFitContent;
		cellSpacing: 8;
		yourself.
	aLabel := BrLabel new
		text: aString;
		aptitude: (BrGlamorousLabelAptitude new
			foreground: (self resolvedColor: self theme label defaultTextForeground);
			fontSize: self theme typography groupHeadingFontSize;
			bold);
		fitContent;
		yourself.
	aSection addChild: aLabel.
	^ aSection
]

{ #category : #'building - helpers' }
CgtThemeShowcaseElement >> resolvedColor: aThemeableColor [
	^ aThemeableColor blocResolveColorForTheme: self theme
]

{ #category : #'building - helpers' }
CgtThemeShowcaseElement >> swatchNamed: aString color: aThemeableColor [
	| aRow aSwatch aLabel |
	aRow := BrHorizontalPane new
		hMatchParent;
		vFitContent;
		cellSpacing: 8;
		yourself.
	aSwatch := BlElement new
		size: 36 @ 18;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		background: (self resolvedColor: aThemeableColor);
		yourself.
	aLabel := BrLabel new
		text: aString;
		aptitude: (BrGlamorousLabelAptitude new
			foreground: (self resolvedColor: self theme label summaryTextForeground);
			fontSize: self theme typography bodyFontSize);
		fitContent;
		yourself.
	aRow addChildren: { aSwatch. aLabel }.
	^ aRow
]

{ #category : #'building - helpers' }
CgtThemeShowcaseElement >> typographySample: aString size: aFontSize color: aThemeableColor [
	^ BrLabel new
		text: aString;
		aptitude: (BrGlamorousLabelAptitude new
			foreground: (self resolvedColor: aThemeableColor);
			fontSize: aFontSize);
		fitContent;
		yourself
]
