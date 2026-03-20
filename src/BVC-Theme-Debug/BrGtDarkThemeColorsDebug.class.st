Class {
	#name : #BrGtDarkThemeColorsDebug,
	#superclass : #BrGtDarkThemeColors,
	#category : #'BVC-Theme-Debug'
}

{ #category : #'class utilities' }
BrGtDarkThemeColorsDebug class >> debugLegend [
	^ {
		#primaryTextColor -> 'yellow'.
		#secondaryTextColor -> 'cyan'.
		#tertiaryTextColor -> 'magenta'.
		#disabledTextColor -> 'green'.
		#sidebarTextColor -> 'orange'.
		#appBackgroundColor -> 'deep blue'.
		#contentBackgroundColor -> 'deep red'.
		#sidebarBackgroundColor -> 'purple'.
		#backdropBackgroundColor -> 'brown'.
		#backdropEmphasisBackgroundColor -> 'lime'.
		#groupBackgroundColor -> 'olive'.
		#raisedBackgroundColor -> 'teal'.
		#floatBackgroundColor -> 'pink'.
		#editorBorderColor -> 'white'.
		#focusedEditorBorderColor -> 'orange'.
		#headerBackgroundColor -> 'dark cyan'.
		#headerSecondaryBackgroundColor -> 'dark magenta'.
		#buttonDefaultBackgroundColor -> 'blue'.
		#buttonDisabledBackgroundColor -> 'green'.
		#buttonDefaultBorderColor -> 'yellow'.
		#buttonPressedBorderColor -> 'red'.
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

	self syntaxPlainTextColor: (Color r: 1 g: 1 b: 0).
	self syntaxCommentColor: (Color r: 0 g: 1 b: 1).
	self syntaxCommentDocumentationColor: (Color r: 0 g: 1 b: 1).
	self syntaxCommentDocumentationKeywordColor: (Color r: 0.2 g: 0.8 b: 1).
	self syntaxKeywordColor: (Color r: 1 g: 0 b: 0.7).
	self syntaxStringColor: (Color r: 1 g: 0.5 b: 0).
	self syntaxNumberColor: (Color r: 0.5 g: 1 b: 0).
	self syntaxCharacterColor: (Color r: 0.3 g: 1 b: 0.3).
	self syntaxAttributeColor: (Color r: 0.8 g: 0.5 b: 0).
	self syntaxIdentifierClassColor: (Color r: 0.7 g: 0.3 b: 1).
	self syntaxIdentifierSystemClassColor: (Color r: 0.5 g: 0.2 b: 1).
	self syntaxIdentifierVariableColor: (Color r: 1 g: 1 b: 0.2).
	self syntaxIdentifierSystemVariableColor: (Color r: 1 g: 0.6 b: 0.2).
	self syntaxIdentifierConstantColor: (Color r: 1 g: 0.9 b: 0.3).
	self syntaxIdentifierSystemConstantColor: (Color r: 0.9 g: 0.6 b: 0.2).
	self syntaxIdentifierFunctionColor: (Color r: 0.1 g: 1 b: 0.5).
	self syntaxIdentifierSystemFunctionColor: (Color r: 0 g: 0.8 b: 0.4).
	self syntaxIdentifierTypeColor: (Color r: 0.5 g: 0.3 b: 1).
	self syntaxIdentifierSystemTypeColor: (Color r: 0.3 g: 0.1 b: 1).
	self syntaxURLColor: (Color r: 1 g: 0.4 b: 0).
	self errorMarkerColor: (Color r: 1 g: 0 b: 0).

	self primaryTextColor: (Color r: 1 g: 1 b: 0).
	self secondaryTextColor: (Color r: 0 g: 1 b: 1).
	self tertiaryTextColor: (Color r: 1 g: 0 b: 1).
	self disabledTextColor: (Color r: 0.2 g: 1 b: 0.2).
	self invertedTextColor: Color black.
	self sidebarTextColor: (Color r: 1 g: 0.6 b: 0).

	self appBackgroundColor: (Color r: 0 g: 0 b: 0.5).
	self contentBackgroundColor: (Color r: 0.45 g: 0 b: 0).
	self sidebarBackgroundColor: (Color r: 0.35 g: 0 b: 0.45).
	self backdropBackgroundColor: (Color r: 0.35 g: 0.2 b: 0).
	self backdropEmphasisBackgroundColor: (Color r: 0.5 g: 1 b: 0).
	self groupBackgroundColor: (Color r: 0.35 g: 0.35 b: 0).
	self raisedBackgroundColor: (Color r: 0 g: 0.35 b: 0.35).
	self floatBackgroundColor: (Color r: 0.8 g: 0.3 b: 0.6).

	self editorBorderColor: Color white.
	self focusedEditorBorderColor: (Color r: 1 g: 0.4 b: 0).

	self headerBackgroundColor: (Color r: 0 g: 0.4 b: 0.4).
	self headerSecondaryBackgroundColor: (Color r: 0.4 g: 0 b: 0.4).
	self headerTextColor: (Color r: 1 g: 1 b: 0).
	self headerDisabledTextColor: (Color r: 1 g: 0 b: 1).
	self headerTextMarkupColor: (Color r: 0 g: 1 b: 1).

	self buttonDefaultBackgroundColor: (Color r: 0 g: 0 b: 1).
	self buttonDisabledBackgroundColor: (Color r: 0 g: 0.6 b: 0).
	self buttonDefaultBorderColor: (Color r: 1 g: 1 b: 0).
	self buttonDisabledBorderColor: (Color r: 1 g: 0 b: 1).
	self buttonPressedBorderColor: (Color r: 1 g: 0 b: 0).
	self buttonHoveredBorderColor: (Color r: 1 g: 0.5 b: 0).
	self buttonDefaultTextColor: Color white.
	self buttonDisabledTextColor: Color black.
	self buttonPressedTextColor: Color white.
	self buttonHoveredTextColor: Color white.
	self buttonTextHighlightColor: (Color r: 1 g: 0.5 b: 0).
	self buttonFadedBackgroundColor: (Color r: 0.2 g: 0.2 b: 0.8).
	self buttonFocusedFadedBackgroundColor: (Color r: 1 g: 0.5 b: 0).

	self defaultShadowColor: (Color r: 1 g: 1 b: 1 alpha: 0.4).
	self primaryBorderColor: Color white.
	self darkBorderColor: (Color r: 0 g: 1 b: 0).
	self lightBorderColor: (Color r: 1 g: 0 b: 1).
	self shadowColor: (Color r: 1 g: 1 b: 1 alpha: 0.4).
	self newsBackgroundColor: (Color r: 0.2 g: 0 b: 0.5).
	self expandCollapseTriangleBackgroundColor: (Color r: 0 g: 0.3 b: 0.7)
]
