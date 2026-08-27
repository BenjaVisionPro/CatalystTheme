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
		background: (self resolvedColor: self theme surfaces baseBackground).

	self
		addChild: self buildTypographySection;
		addChild: self buildSurfaceSection;
		addChild: self buildInteractionSection;
		addChild: self buildHighlightSection;
		addChild: self buildBrickSection.
	^ self
]

{ #category : #'building - sections' }
CgtThemeShowcaseElement >> buildBrickSection [
	| aSection aRow |
	aSection := self newSectionNamed: 'Brick controls'.
	aRow := BrHorizontalPane new
		vFitContent;
		cellSpacing: 10;
		yourself.
	aSection addChild: aRow.
	aRow
		addChild: (BrButton new
			aptitude: BrGlamorousButtonWithLabelAptitude;
			label: 'Button';
			yourself);
		addChild: (BrEditor new
			aptitude: BrGlamorousEditorAptitude + BrGlamorousInputFieldSpacingAptitude;
			text: 'Editor';
			fitContent;
			yourself).
	^ aSection
]

{ #category : #'building - sections' }
CgtThemeShowcaseElement >> buildHighlightSection [
	| aSection |
	aSection := self newSectionNamed: 'Highlight'.
	aSection
		addChild: (self swatchNamed: 'Highlight' color: self theme highlight color);
		addChild: (self swatchNamed: 'Text highlight' color: self theme highlight textColor);
		addChild: (self swatchNamed: 'Inactive text highlight' color: self theme highlight inactiveTextColor).
	^ aSection
]

{ #category : #'building - sections' }
CgtThemeShowcaseElement >> buildInteractionSection [
	| aSection |
	aSection := self newSectionNamed: 'Interaction'.
	aSection
		addChild: (self swatchNamed: 'Subtle' color: self theme interaction subtleBackgroundTint);
		addChild: (self swatchNamed: 'Control' color: self theme interaction controlBackgroundTint);
		addChild: (self swatchNamed: 'Popup' color: self theme interaction popupBackgroundTint);
		addChild: (self swatchNamed: 'Hovered' color: self theme interaction hoveredBackgroundTint);
		addChild: (self swatchNamed: 'Pressed' color: self theme interaction pressedBackgroundTint);
		addChild: (self swatchNamed: 'Focus' color: self theme interaction focusedBorderColor).
	^ aSection
]

{ #category : #'building - sections' }
CgtThemeShowcaseElement >> buildSurfaceSection [
	| aSection aBase aCard aSeparator |
	aSection := self newSectionNamed: 'Surfaces'.
	aBase := BrVerticalPane new
		hMatchParent;
		vFitContent;
		padding: (BlInsets all: 12);
		cellSpacing: 8;
		background: (self resolvedColor: self theme surfaces baseBackground);
		yourself.
	aSection addChild: aBase.
	aCard := BlElement new
		constraintsDo: [ :c | c horizontal matchParent ];
		height: 44;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 6);
		background: (self resolvedColor: self theme surfaces cardTint);
		yourself.
	aBase addChild: aCard.
	aSeparator := BlElement new
		constraintsDo: [ :c | c horizontal matchParent ];
		height: 1;
		background: (self resolvedColor: self theme surfaces separatorTint);
		yourself.
	aBase addChild: aSeparator.
	^ aSection
]

{ #category : #'building - sections' }
CgtThemeShowcaseElement >> buildTypographySection [
	| aSection |
	aSection := self newSectionNamed: 'Typography'.
	aSection
		addChild: (self typographySample: 'Title' size: self theme typography titleFontSize color: self theme typography titleForeground);
		addChild: (self typographySample: 'Group heading' size: self theme typography groupHeadingFontSize color: self theme typography primaryForeground);
		addChild: (self typographySample: 'Body' size: self theme typography bodyFontSize color: self theme typography primaryForeground);
		addChild: (self typographySample: 'Secondary' size: self theme typography bodyFontSize color: self theme typography secondaryForeground);
		addChild: (self typographySample: 'Supporting' size: self theme typography supportingFontSize color: self theme typography tertiaryForeground);
		addChild: (self typographySample: 'Metadata' size: self theme typography metadataFontSize color: self theme typography metadataForeground).
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
			foreground: (self resolvedColor: self theme typography primaryForeground);
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
			foreground: (self resolvedColor: self theme typography secondaryForeground);
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
