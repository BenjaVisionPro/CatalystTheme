Class {
	#name : #BrGtDarkThemeColorsDebug,
	#superclass : #BrGtDarkThemeColors,
	#category : #'BVC-Theme-Debug'
}

{ #category : #'class utilities' }
BrGtDarkThemeColorsDebug class >> debugLegend [
	^ {
		#appBackgroundColor -> 'navy'.
		#backdropBackgroundColor -> 'brown'.
		#contentBackgroundColor -> 'crimson'.
		#sidebarBackgroundColor -> 'purple'.
		#groupBackgroundColor -> 'olive'.
		#raisedBackgroundColor -> 'teal'.
		#floatBackgroundColor -> 'pink'.
		#toolbarBackgroundColor -> 'indigo'.
		#headerBackgroundColor -> 'emerald'.
		#headerSecondaryBackgroundColor -> 'plum'.
		#tabBackgroundColor -> 'orange'.
		#tabSelectedBackgroundColor -> 'sky blue'.
		#tabTextColor -> 'gold'.
		#tabSelectedTextColor -> 'mint'.
		#borderColor -> 'white'.
		#subtleBorderColor -> 'rose'.
		#strongBorderColor -> 'lime'.
		#dividerColor -> 'aqua'.
		#focusBorderColor -> 'amber'.
		#itemBackgroundColor -> 'violet'.
		#itemDeselectedBackgroundColor -> 'lavender'.
		#itemHoveredBackgroundColor -> 'turquoise'.
		#itemSelectedBackgroundColor -> 'electric blue'.
		#itemPressedBackgroundColor -> 'red'.
		#itemFocusedBorderColor -> 'yellow'.
		#itemTextColor -> 'peach'.
		#itemSelectedTextColor -> 'ice'.
		#itemHoveredTextColor -> 'black'.
		#itemPressedTextColor -> 'white'.
		#itemDisabledTextColor -> 'chartreuse'.
		#primaryTextColor -> 'yellow'.
		#secondaryTextColor -> 'cyan'.
		#tertiaryTextColor -> 'magenta'.
		#disabledTextColor -> 'green'.
		#sidebarTextColor -> 'orange'.
		#headerTextColor -> 'lemon'.
		#headerDisabledTextColor -> 'fuchsia'.
		#headerTextMarkupColor -> 'turquoise'.
		#buttonDefaultBackgroundColor -> 'cobalt'.
		#buttonDisabledBackgroundColor -> 'forest'.
		#buttonDefaultBorderColor -> 'sand'.
		#buttonDisabledBorderColor -> 'orchid'.
		#buttonPressedBorderColor -> 'scarlet'.
		#buttonHoveredBorderColor -> 'tangerine'.
		#buttonDefaultTextColor -> 'cream'.
		#buttonDisabledTextColor -> 'charcoal'.
		#buttonPressedTextColor -> 'snow'.
		#buttonHoveredTextColor -> 'silver'.
		#navigationTextForeground -> 'salmon'.
		#editorBorderColor -> 'ivory'.
		#focusedEditorBorderColor -> 'amber'.
		#syntaxKeywordColor -> 'hot pink'.
		#syntaxStringColor -> 'orange'.
		#syntaxNumberColor -> 'acid green'.
		#syntaxCommentColor -> 'cyan'.
		#syntaxIdentifierClassColor -> 'violet'.
		#syntaxIdentifierVariableColor -> 'yellow'.
		#errorMarkerColor -> 'red' }
]

{ #category : #initialization }
BrGtDarkThemeColorsDebug >> initialize [
	super initialize.

	"syntax"
	self syntaxPlainTextColor: (Color r: 1.0 g: 1.0 b: 0.0).
	self syntaxCommentColor: (Color r: 0.0 g: 1.0 b: 1.0).
	self syntaxCommentDocumentationColor: (Color r: 0.0 g: 0.9 b: 0.9).
	self syntaxCommentDocumentationKeywordColor: (Color r: 0.1 g: 0.8 b: 1.0).
	self syntaxKeywordColor: (Color r: 1.0 g: 0.0 b: 0.7).
	self syntaxStringColor: (Color r: 1.0 g: 0.5 b: 0.0).
	self syntaxNumberColor: (Color r: 0.5 g: 1.0 b: 0.0).
	self syntaxCharacterColor: (Color r: 0.2 g: 1.0 b: 0.2).
	self syntaxAttributeColor: (Color r: 0.8 g: 0.5 b: 0.0).
	self syntaxIdentifierClassColor: (Color r: 0.6 g: 0.2 b: 1.0).
	self syntaxIdentifierSystemClassColor: (Color r: 0.4 g: 0.1 b: 1.0).
	self syntaxIdentifierVariableColor: (Color r: 1.0 g: 1.0 b: 0.2).
	self syntaxIdentifierSystemVariableColor: (Color r: 1.0 g: 0.7 b: 0.1).
	self syntaxIdentifierConstantColor: (Color r: 1.0 g: 0.9 b: 0.3).
	self syntaxIdentifierSystemConstantColor: (Color r: 0.9 g: 0.6 b: 0.2).
	self syntaxIdentifierFunctionColor: (Color r: 0.1 g: 1.0 b: 0.5).
	self syntaxIdentifierSystemFunctionColor: (Color r: 0.0 g: 0.8 b: 0.4).
	self syntaxIdentifierTypeColor: (Color r: 0.4 g: 0.3 b: 1.0).
	self syntaxIdentifierSystemTypeColor: (Color r: 0.2 g: 0.1 b: 1.0).
	self syntaxURLColor: (Color r: 1.0 g: 0.4 b: 0.0).
	self errorMarkerColor: (Color r: 1.0 g: 0.0 b: 0.0).

	"text"
	self primaryTextColor: (Color r: 1.0 g: 1.0 b: 0.0).
	self secondaryTextColor: (Color r: 0.0 g: 1.0 b: 1.0).
	self tertiaryTextColor: (Color r: 1.0 g: 0.0 b: 1.0).
	self disabledTextColor: (Color r: 0.2 g: 1.0 b: 0.2).
	self invertedTextColor: Color black.
	self sidebarTextColor: (Color r: 1.0 g: 0.55 b: 0.0).

	"core surfaces"
	self appBackgroundColor: (Color r: 0.0 g: 0.0 b: 0.50).
	self backdropBackgroundColor: (Color r: 0.40 g: 0.24 b: 0.0).
	self contentBackgroundColor: (Color r: 0.55 g: 0.0 b: 0.0).
	self sidebarBackgroundColor: (Color r: 0.35 g: 0.0 b: 0.50).
	self groupBackgroundColor: (Color r: 0.35 g: 0.35 b: 0.0).
	self raisedBackgroundColor: (Color r: 0.0 g: 0.45 b: 0.45).
	self floatBackgroundColor: (Color r: 0.95 g: 0.25 b: 0.65).
	self backdropEmphasisBackgroundColor: (Color r: 0.6 g: 1.0 b: 0.0).

	"header/tab/toolbar"
	self toolbarBackgroundColor: (Color r: 0.12 g: 0.0 b: 0.70).
	self headerBackgroundColor: (Color r: 0.0 g: 0.55 b: 0.25).
	self headerSecondaryBackgroundColor: (Color r: 0.55 g: 0.0 b: 0.55).
	self tabBackgroundColor: (Color r: 0.95 g: 0.45 b: 0.0).
	self tabSelectedBackgroundColor: (Color r: 0.0 g: 0.55 b: 1.0).
	self tabTextColor: (Color r: 1.0 g: 0.85 b: 0.15).
	self tabSelectedTextColor: (Color r: 0.7 g: 1.0 b: 0.8).

	"borders"
	self borderColor: (Color r: 1.0 g: 1.0 b: 1.0).
	self subtleBorderColor: (Color r: 1.0 g: 0.45 b: 0.7).
	self strongBorderColor: (Color r: 0.4 g: 1.0 b: 0.0).
	self dividerColor: (Color r: 0.2 g: 1.0 b: 1.0).
	self focusBorderColor: (Color r: 1.0 g: 0.65 b: 0.0).

	"item states"
	self itemBackgroundColor: (Color r: 0.45 g: 0.1 b: 0.65).
	self itemDeselectedBackgroundColor: (Color r: 0.72 g: 0.55 b: 0.85).
	self itemHoveredBackgroundColor: (Color r: 0.0 g: 0.85 b: 0.75).
	self itemSelectedBackgroundColor: (Color r: 0.0 g: 0.1 b: 1.0).
	self itemPressedBackgroundColor: (Color r: 1.0 g: 0.0 b: 0.0).
	self itemFocusedBorderColor: (Color r: 1.0 g: 1.0 b: 0.0).
	self itemTextColor: (Color r: 1.0 g: 0.72 b: 0.55).
	self itemSelectedTextColor: (Color r: 0.85 g: 0.95 b: 1.0).
	self itemHoveredTextColor: Color black.
	self itemPressedTextColor: Color white.
	self itemDisabledTextColor: (Color r: 0.55 g: 1.0 b: 0.0).

	"editor/header/button miscellany"
	self editorBorderColor: (Color r: 1.0 g: 1.0 b: 0.92).
	self focusedEditorBorderColor: (Color r: 1.0 g: 0.65 b: 0.0).
	self headerTextColor: (Color r: 1.0 g: 1.0 b: 0.2).
	self headerDisabledTextColor: (Color r: 1.0 g: 0.1 b: 0.85).
	self headerTextMarkupColor: (Color r: 0.2 g: 0.95 b: 0.95).
	self buttonDefaultBackgroundColor: (Color r: 0.1 g: 0.2 b: 0.95).
	self buttonDisabledBackgroundColor: (Color r: 0.0 g: 0.55 b: 0.0).
	self buttonDefaultBorderColor: (Color r: 0.95 g: 0.85 b: 0.55).
	self buttonDisabledBorderColor: (Color r: 0.85 g: 0.35 b: 0.9).
	self buttonPressedBorderColor: (Color r: 1.0 g: 0.15 b: 0.15).
	self buttonHoveredBorderColor: (Color r: 1.0 g: 0.55 b: 0.1).
	self buttonDefaultTextColor: (Color r: 1.0 g: 0.98 b: 0.88).
	self buttonDisabledTextColor: (Color r: 0.15 g: 0.15 b: 0.15).
	self buttonPressedTextColor: (Color r: 1.0 g: 1.0 b: 1.0).
	self buttonHoveredTextColor: (Color r: 0.78 g: 0.78 b: 0.78).
	self buttonTextHighlightColor: (Color r: 1.0 g: 0.5 b: 0.0).
	self buttonFadedBackgroundColor: (Color r: 0.2 g: 0.2 b: 0.8).
	self buttonFocusedFadedBackgroundColor: (Color r: 1.0 g: 0.5 b: 0.0).

	"default theme extras"
	self defaultShadowColor: (Color r: 1.0 g: 1.0 b: 1.0 alpha: 0.4).
	self primaryBorderColor: (Color r: 0.98 g: 0.98 b: 0.98).
	self darkBorderColor: (Color r: 0.1 g: 1.0 b: 0.1).
	self lightBorderColor: (Color r: 1.0 g: 0.1 b: 0.9).
	self shadowColor: (Color r: 1.0 g: 1.0 b: 1.0 alpha: 0.4).
	self newsBackgroundColor: (Color r: 0.2 g: 0.0 b: 0.5).
	self expandCollapseTriangleBackgroundColor: (Color r: 0.0 g: 0.3 b: 0.7)
]
