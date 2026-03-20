Class {
	#name : #BrGtAbstractThemeColors,
	#superclass : #BrGlamorousThemeColors,
	#instVars : [
		'semanticColors'
	],
	#category : #'BVC-Theme-Core'
}

{ #category : #initialization }
BrGtAbstractThemeColors >> initialize [
	super initialize.
	semanticColors := Dictionary new
]

{ #category : #'private - helpers' }
BrGtAbstractThemeColors >> colorFromXcodeString: aString [
	| parts |
	parts := aString substrings collect: [ :each | each asNumber ].
	^ Color
		r: parts first
		g: parts second
		b: parts third
		alpha: parts fourth
]

{ #category : #'private - helpers' }
BrGtAbstractThemeColors >> initializeGlamorousMappings [
	primaryTextColor := self syntaxPlainTextColor.
	secondaryTextColor := self syntaxCommentDocumentationKeywordColor.
	tertiaryTextColor := self syntaxCommentColor.
	disabledTextColor := self tertiaryTextColor alpha: 0.65.
	invertedTextColor := self isDark
		ifTrue: [ Color black alpha: 0.9 ]
		ifFalse: [ Color white ].

	appBackgroundColor := self consoleBackgroundColor.
	backdropBackgroundColor := self sourceBackgroundColor.
	backdropEmphasisBackgroundColor := self sourceSelectionColor.
	sidebarBackgroundColor := self sourceBackgroundColor.
	contentBackgroundColor := self sourceCurrentLineHighlightColor.
	groupBackgroundColor := self markupBackgroundColor.
	raisedBackgroundColor := self markupBackgroundColor.
	floatBackgroundColor := self markupBackgroundColor.
	sidebarTextColor := self secondaryTextColor.

	self toolbarBackgroundColor: self consoleBackgroundColor.
	"Top document tabs visibly follow the tab background family in GT."
	self tabBackgroundColor: self markupBackgroundColor.
	self tabSelectedBackgroundColor: self sourceCurrentLineHighlightColor.
	self tabTextColor: self syntaxCommentDocumentationKeywordColor.
	self tabSelectedTextColor: self syntaxPlainTextColor.

	self borderColor: self markupBorderColor.
	self subtleBorderColor: self sourceInvisiblesColor.
	self strongBorderColor: self sourceSelectionColor.
	self dividerColor: self markupBorderColor.
	self focusBorderColor: self sourceSelectionColor.

	self itemBackgroundColor: self sourceBackgroundColor.
	self itemDeselectedBackgroundColor: self sourceBackgroundColor.
	self itemSelectedBackgroundColor: self sourceSelectionColor.
	self itemHoveredBackgroundColor: self sourceCurrentLineHighlightColor.
	self itemPressedBackgroundColor: self sourceSelectionColor.
	self itemFocusedBorderColor: self sourceSelectionColor.
	self itemTextColor: self primaryTextColor.
	self itemSelectedTextColor: self primaryTextColor.
	self itemHoveredTextColor: self primaryTextColor.
	self itemPressedTextColor: self primaryTextColor.
	self itemDisabledTextColor: self disabledTextColor.

	self editorBorderColor: self borderColor.
	self focusedEditorBorderColor: self focusBorderColor.
	self headerBackgroundColor: self toolbarBackgroundColor.
	self headerSecondaryBackgroundColor: self tabBackgroundColor.
	self headerTextColor: self syntaxPlainTextColor.
	self headerDisabledTextColor: self syntaxCommentColor.
	self headerTextMarkupColor: self syntaxCommentDocumentationKeywordColor.
	"GT top tabs/buttons are currently consuming the button background path more than the selected-tab path."
	self buttonDefaultBackgroundColor: self tabBackgroundColor.
	self buttonDisabledBackgroundColor: self groupBackgroundColor.
	self buttonDefaultBorderColor: self borderColor.
	self buttonDisabledBorderColor: self subtleBorderColor.
	self buttonPressedBorderColor: self focusBorderColor.
	self buttonHoveredBorderColor: self strongBorderColor.
	self buttonDefaultTextColor: self syntaxCommentDocumentationKeywordColor.
	self buttonDisabledTextColor: self disabledTextColor.
	self buttonPressedTextColor: self syntaxPlainTextColor.
	self buttonHoveredTextColor: self syntaxPlainTextColor.
	self buttonTextHighlightColor: self syntaxURLColor.
	self buttonFadedBackgroundColor: self groupBackgroundColor.
	self buttonFocusedFadedBackgroundColor: self tabSelectedBackgroundColor.
	self defaultShadowColor: (self sourceSelectionColor alpha: 0.12).
	self primaryBorderColor: self borderColor.
	self darkBorderColor: self strongBorderColor.
	self lightBorderColor: self subtleBorderColor.
	self shadowColor: (self sourceSelectionColor alpha: 0.12).
	self newsBackgroundColor: self markupBackgroundColor.
	self expandCollapseTriangleBackgroundColor: self sourceCurrentLineHighlightColor
]

{ #category : #'private - helpers' }
BrGtAbstractThemeColors >> isDark [
	self subclassResponsibility
]

{ #category : #'private - helpers' }
BrGtAbstractThemeColors >> semanticColorAt: aSymbol [
	^ semanticColors at: aSymbol ifAbsent: [ nil ]
]

{ #category : #'private - helpers' }
BrGtAbstractThemeColors >> semanticColorAt: aSymbol put: aColor [
	semanticColors at: aSymbol put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> editorBorderColor [
	^ self semanticColorAt: #editorBorderColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> editorBorderColor: aColor [
	self semanticColorAt: #editorBorderColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> focusedEditorBorderColor [
	^ self semanticColorAt: #focusedEditorBorderColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> focusedEditorBorderColor: aColor [
	self semanticColorAt: #focusedEditorBorderColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> headerBackgroundColor [
	^ self semanticColorAt: #headerBackgroundColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> headerBackgroundColor: aColor [
	self semanticColorAt: #headerBackgroundColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> headerSecondaryBackgroundColor [
	^ self semanticColorAt: #headerSecondaryBackgroundColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> headerSecondaryBackgroundColor: aColor [
	self semanticColorAt: #headerSecondaryBackgroundColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> headerTextColor [
	^ self semanticColorAt: #headerTextColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> headerTextColor: aColor [
	self semanticColorAt: #headerTextColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> headerDisabledTextColor [
	^ self semanticColorAt: #headerDisabledTextColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> headerDisabledTextColor: aColor [
	self semanticColorAt: #headerDisabledTextColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> headerTextMarkupColor [
	^ self semanticColorAt: #headerTextMarkupColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> headerTextMarkupColor: aColor [
	self semanticColorAt: #headerTextMarkupColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> buttonDefaultBackgroundColor [
	^ self semanticColorAt: #buttonDefaultBackgroundColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> buttonDefaultBackgroundColor: aColor [
	self semanticColorAt: #buttonDefaultBackgroundColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> buttonDisabledBackgroundColor [
	^ self semanticColorAt: #buttonDisabledBackgroundColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> buttonDisabledBackgroundColor: aColor [
	self semanticColorAt: #buttonDisabledBackgroundColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> buttonDefaultBorderColor [
	^ self semanticColorAt: #buttonDefaultBorderColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> buttonDefaultBorderColor: aColor [
	self semanticColorAt: #buttonDefaultBorderColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> buttonDisabledBorderColor [
	^ self semanticColorAt: #buttonDisabledBorderColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> buttonDisabledBorderColor: aColor [
	self semanticColorAt: #buttonDisabledBorderColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> buttonPressedBorderColor [
	^ self semanticColorAt: #buttonPressedBorderColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> buttonPressedBorderColor: aColor [
	self semanticColorAt: #buttonPressedBorderColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> buttonHoveredBorderColor [
	^ self semanticColorAt: #buttonHoveredBorderColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> buttonHoveredBorderColor: aColor [
	self semanticColorAt: #buttonHoveredBorderColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> buttonDefaultTextColor [
	^ self semanticColorAt: #buttonDefaultTextColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> buttonDefaultTextColor: aColor [
	self semanticColorAt: #buttonDefaultTextColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> buttonDisabledTextColor [
	^ self semanticColorAt: #buttonDisabledTextColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> buttonDisabledTextColor: aColor [
	self semanticColorAt: #buttonDisabledTextColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> buttonPressedTextColor [
	^ self semanticColorAt: #buttonPressedTextColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> buttonPressedTextColor: aColor [
	self semanticColorAt: #buttonPressedTextColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> buttonHoveredTextColor [
	^ self semanticColorAt: #buttonHoveredTextColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> buttonHoveredTextColor: aColor [
	self semanticColorAt: #buttonHoveredTextColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> buttonTextHighlightColor [
	^ self semanticColorAt: #buttonTextHighlightColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> buttonTextHighlightColor: aColor [
	self semanticColorAt: #buttonTextHighlightColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> buttonFadedBackgroundColor [
	^ self semanticColorAt: #buttonFadedBackgroundColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> buttonFadedBackgroundColor: aColor [
	self semanticColorAt: #buttonFadedBackgroundColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> buttonFocusedFadedBackgroundColor [
	^ self semanticColorAt: #buttonFocusedFadedBackgroundColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> buttonFocusedFadedBackgroundColor: aColor [
	self semanticColorAt: #buttonFocusedFadedBackgroundColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> defaultShadowColor [
	^ self semanticColorAt: #defaultShadowColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> defaultShadowColor: aColor [
	self semanticColorAt: #defaultShadowColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> primaryBorderColor [
	^ self semanticColorAt: #primaryBorderColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> primaryBorderColor: aColor [
	self semanticColorAt: #primaryBorderColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> darkBorderColor [
	^ self semanticColorAt: #darkBorderColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> darkBorderColor: aColor [
	self semanticColorAt: #darkBorderColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> lightBorderColor [
	^ self semanticColorAt: #lightBorderColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> lightBorderColor: aColor [
	self semanticColorAt: #lightBorderColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> shadowColor [
	^ self semanticColorAt: #shadowColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> shadowColor: aColor [
	self semanticColorAt: #shadowColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> newsBackgroundColor [
	^ self semanticColorAt: #newsBackgroundColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> newsBackgroundColor: aColor [
	self semanticColorAt: #newsBackgroundColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> expandCollapseTriangleBackgroundColor [
	^ self semanticColorAt: #expandCollapseTriangleBackgroundColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> expandCollapseTriangleBackgroundColor: aColor [
	self semanticColorAt: #expandCollapseTriangleBackgroundColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> sourceBackgroundColor [
	^ self semanticColorAt: #sourceBackgroundColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> sourceBackgroundColor: aColor [
	self semanticColorAt: #sourceBackgroundColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> sourceBlockDimBackgroundColor [
	^ self semanticColorAt: #sourceBlockDimBackgroundColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> sourceBlockDimBackgroundColor: aColor [
	self semanticColorAt: #sourceBlockDimBackgroundColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> sourceCurrentLineHighlightColor [
	^ self semanticColorAt: #sourceCurrentLineHighlightColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> sourceCurrentLineHighlightColor: aColor [
	self semanticColorAt: #sourceCurrentLineHighlightColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> sourceInsertionPointColor [
	^ self semanticColorAt: #sourceInsertionPointColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> sourceInsertionPointColor: aColor [
	self semanticColorAt: #sourceInsertionPointColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> sourceInvisiblesColor [
	^ self semanticColorAt: #sourceInvisiblesColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> sourceInvisiblesColor: aColor [
	self semanticColorAt: #sourceInvisiblesColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> sourceSelectionColor [
	^ self semanticColorAt: #sourceSelectionColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> sourceSelectionColor: aColor [
	self semanticColorAt: #sourceSelectionColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> consoleInputTextColor [
	^ self semanticColorAt: #consoleInputTextColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> consoleInputTextColor: aColor [
	self semanticColorAt: #consoleInputTextColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> consoleOutputTextColor [
	^ self semanticColorAt: #consoleOutputTextColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> consoleOutputTextColor: aColor [
	self semanticColorAt: #consoleOutputTextColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> consolePromptTextColor [
	^ self semanticColorAt: #consolePromptTextColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> consolePromptTextColor: aColor [
	self semanticColorAt: #consolePromptTextColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> consoleExecutableInputTextColor [
	^ self semanticColorAt: #consoleExecutableInputTextColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> consoleExecutableInputTextColor: aColor [
	self semanticColorAt: #consoleExecutableInputTextColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> consoleExecutableOutputTextColor [
	^ self semanticColorAt: #consoleExecutableOutputTextColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> consoleExecutableOutputTextColor: aColor [
	self semanticColorAt: #consoleExecutableOutputTextColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> consoleBackgroundColor [
	^ self semanticColorAt: #consoleBackgroundColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> consoleBackgroundColor: aColor [
	self semanticColorAt: #consoleBackgroundColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> consoleInsertionPointColor [
	^ self semanticColorAt: #consoleInsertionPointColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> consoleInsertionPointColor: aColor [
	self semanticColorAt: #consoleInsertionPointColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> consoleSelectionColor [
	^ self semanticColorAt: #consoleSelectionColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> consoleSelectionColor: aColor [
	self semanticColorAt: #consoleSelectionColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> markupBackgroundColor [
	^ self semanticColorAt: #markupBackgroundColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> markupBackgroundColor: aColor [
	self semanticColorAt: #markupBackgroundColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> markupBorderColor [
	^ self semanticColorAt: #markupBorderColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> markupBorderColor: aColor [
	self semanticColorAt: #markupBorderColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> markupEmphasisColor [
	^ self semanticColorAt: #markupEmphasisColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> markupEmphasisColor: aColor [
	self semanticColorAt: #markupEmphasisColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> markupInlineCodeColor [
	^ self semanticColorAt: #markupInlineCodeColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> markupInlineCodeColor: aColor [
	self semanticColorAt: #markupInlineCodeColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> markupLinkColor [
	^ self semanticColorAt: #markupLinkColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> markupLinkColor: aColor [
	self semanticColorAt: #markupLinkColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> markupNormalColor [
	^ self semanticColorAt: #markupNormalColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> markupNormalColor: aColor [
	self semanticColorAt: #markupNormalColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> markupOtherHeadingColor [
	^ self semanticColorAt: #markupOtherHeadingColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> markupOtherHeadingColor: aColor [
	self semanticColorAt: #markupOtherHeadingColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> markupPrimaryHeadingColor [
	^ self semanticColorAt: #markupPrimaryHeadingColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> markupPrimaryHeadingColor: aColor [
	self semanticColorAt: #markupPrimaryHeadingColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> markupSecondaryHeadingColor [
	^ self semanticColorAt: #markupSecondaryHeadingColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> markupSecondaryHeadingColor: aColor [
	self semanticColorAt: #markupSecondaryHeadingColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> markupStrongColor [
	^ self semanticColorAt: #markupStrongColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> markupStrongColor: aColor [
	self semanticColorAt: #markupStrongColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> analyzerMarkerColor [
	^ self semanticColorAt: #analyzerMarkerColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> analyzerMarkerColor: aColor [
	self semanticColorAt: #analyzerMarkerColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> breakpointMarkerColor [
	^ self semanticColorAt: #breakpointMarkerColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> breakpointMarkerColor: aColor [
	self semanticColorAt: #breakpointMarkerColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> diffMarkerColor [
	^ self semanticColorAt: #diffMarkerColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> diffMarkerColor: aColor [
	self semanticColorAt: #diffMarkerColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> diffConflictMarkerColor [
	^ self semanticColorAt: #diffConflictMarkerColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> diffConflictMarkerColor: aColor [
	self semanticColorAt: #diffConflictMarkerColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> errorMarkerColor [
	^ self semanticColorAt: #errorMarkerColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> errorMarkerColor: aColor [
	self semanticColorAt: #errorMarkerColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> runtimeIssueMarkerColor [
	^ self semanticColorAt: #runtimeIssueMarkerColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> runtimeIssueMarkerColor: aColor [
	self semanticColorAt: #runtimeIssueMarkerColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> warningMarkerColor [
	^ self semanticColorAt: #warningMarkerColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> warningMarkerColor: aColor [
	self semanticColorAt: #warningMarkerColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxAttributeColor [
	^ self semanticColorAt: #syntaxAttributeColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxAttributeColor: aColor [
	self semanticColorAt: #syntaxAttributeColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxCharacterColor [
	^ self semanticColorAt: #syntaxCharacterColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxCharacterColor: aColor [
	self semanticColorAt: #syntaxCharacterColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxCommentColor [
	^ self semanticColorAt: #syntaxCommentColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxCommentColor: aColor [
	self semanticColorAt: #syntaxCommentColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxCommentDocumentationColor [
	^ self semanticColorAt: #syntaxCommentDocumentationColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxCommentDocumentationColor: aColor [
	self semanticColorAt: #syntaxCommentDocumentationColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxCommentDocumentationKeywordColor [
	^ self semanticColorAt: #syntaxCommentDocumentationKeywordColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxCommentDocumentationKeywordColor: aColor [
	self semanticColorAt: #syntaxCommentDocumentationKeywordColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxDeclarationOtherColor [
	^ self semanticColorAt: #syntaxDeclarationOtherColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxDeclarationOtherColor: aColor [
	self semanticColorAt: #syntaxDeclarationOtherColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxDeclarationTypeColor [
	^ self semanticColorAt: #syntaxDeclarationTypeColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxDeclarationTypeColor: aColor [
	self semanticColorAt: #syntaxDeclarationTypeColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxIdentifierClassColor [
	^ self semanticColorAt: #syntaxIdentifierClassColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxIdentifierClassColor: aColor [
	self semanticColorAt: #syntaxIdentifierClassColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxIdentifierSystemClassColor [
	^ self semanticColorAt: #syntaxIdentifierSystemClassColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxIdentifierSystemClassColor: aColor [
	self semanticColorAt: #syntaxIdentifierSystemClassColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxIdentifierConstantColor [
	^ self semanticColorAt: #syntaxIdentifierConstantColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxIdentifierConstantColor: aColor [
	self semanticColorAt: #syntaxIdentifierConstantColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxIdentifierSystemConstantColor [
	^ self semanticColorAt: #syntaxIdentifierSystemConstantColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxIdentifierSystemConstantColor: aColor [
	self semanticColorAt: #syntaxIdentifierSystemConstantColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxIdentifierFunctionColor [
	^ self semanticColorAt: #syntaxIdentifierFunctionColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxIdentifierFunctionColor: aColor [
	self semanticColorAt: #syntaxIdentifierFunctionColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxIdentifierSystemFunctionColor [
	^ self semanticColorAt: #syntaxIdentifierSystemFunctionColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxIdentifierSystemFunctionColor: aColor [
	self semanticColorAt: #syntaxIdentifierSystemFunctionColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxIdentifierMacroColor [
	^ self semanticColorAt: #syntaxIdentifierMacroColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxIdentifierMacroColor: aColor [
	self semanticColorAt: #syntaxIdentifierMacroColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxIdentifierSystemMacroColor [
	^ self semanticColorAt: #syntaxIdentifierSystemMacroColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxIdentifierSystemMacroColor: aColor [
	self semanticColorAt: #syntaxIdentifierSystemMacroColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxIdentifierTypeColor [
	^ self semanticColorAt: #syntaxIdentifierTypeColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxIdentifierTypeColor: aColor [
	self semanticColorAt: #syntaxIdentifierTypeColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxIdentifierSystemTypeColor [
	^ self semanticColorAt: #syntaxIdentifierSystemTypeColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxIdentifierSystemTypeColor: aColor [
	self semanticColorAt: #syntaxIdentifierSystemTypeColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxIdentifierVariableColor [
	^ self semanticColorAt: #syntaxIdentifierVariableColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxIdentifierVariableColor: aColor [
	self semanticColorAt: #syntaxIdentifierVariableColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxIdentifierSystemVariableColor [
	^ self semanticColorAt: #syntaxIdentifierSystemVariableColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxIdentifierSystemVariableColor: aColor [
	self semanticColorAt: #syntaxIdentifierSystemVariableColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxKeywordColor [
	^ self semanticColorAt: #syntaxKeywordColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxKeywordColor: aColor [
	self semanticColorAt: #syntaxKeywordColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxMarkColor [
	^ self semanticColorAt: #syntaxMarkColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxMarkColor: aColor [
	self semanticColorAt: #syntaxMarkColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxMarkupCodeColor [
	^ self semanticColorAt: #syntaxMarkupCodeColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxMarkupCodeColor: aColor [
	self semanticColorAt: #syntaxMarkupCodeColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxNumberColor [
	^ self semanticColorAt: #syntaxNumberColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxNumberColor: aColor [
	self semanticColorAt: #syntaxNumberColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxPlainTextColor [
	^ self semanticColorAt: #syntaxPlainTextColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxPlainTextColor: aColor [
	self semanticColorAt: #syntaxPlainTextColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxPreprocessorColor [
	^ self semanticColorAt: #syntaxPreprocessorColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxPreprocessorColor: aColor [
	self semanticColorAt: #syntaxPreprocessorColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxRegexColor [
	^ self semanticColorAt: #syntaxRegexColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxRegexColor: aColor [
	self semanticColorAt: #syntaxRegexColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxRegexCaptureNameColor [
	^ self semanticColorAt: #syntaxRegexCaptureNameColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxRegexCaptureNameColor: aColor [
	self semanticColorAt: #syntaxRegexCaptureNameColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxRegexCharacterNameColor [
	^ self semanticColorAt: #syntaxRegexCharacterNameColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxRegexCharacterNameColor: aColor [
	self semanticColorAt: #syntaxRegexCharacterNameColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxRegexNumberColor [
	^ self semanticColorAt: #syntaxRegexNumberColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxRegexNumberColor: aColor [
	self semanticColorAt: #syntaxRegexNumberColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxRegexOtherColor [
	^ self semanticColorAt: #syntaxRegexOtherColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxRegexOtherColor: aColor [
	self semanticColorAt: #syntaxRegexOtherColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxStringColor [
	^ self semanticColorAt: #syntaxStringColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxStringColor: aColor [
	self semanticColorAt: #syntaxStringColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxURLColor [
	^ self semanticColorAt: #syntaxURLColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> syntaxURLColor: aColor [
	self semanticColorAt: #syntaxURLColor put: aColor
]


{ #category : #'private - helpers' }
BrGtAbstractThemeColors >> semanticColorAt: aSymbol ifAbsent: aBlock [
	^ semanticColors at: aSymbol ifAbsent: aBlock
]

{ #category : #accessing }
BrGtAbstractThemeColors >> toolbarBackgroundColor [
	^ self semanticColorAt: #toolbarBackgroundColor ifAbsent: [ self consoleBackgroundColor ]
]

{ #category : #accessing }
BrGtAbstractThemeColors >> toolbarBackgroundColor: aColor [
	self semanticColorAt: #toolbarBackgroundColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> tabBackgroundColor [
	^ self semanticColorAt: #tabBackgroundColor ifAbsent: [ self markupBackgroundColor ]
]

{ #category : #accessing }
BrGtAbstractThemeColors >> tabBackgroundColor: aColor [
	self semanticColorAt: #tabBackgroundColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> tabSelectedBackgroundColor [
	^ self semanticColorAt: #tabSelectedBackgroundColor ifAbsent: [ self sourceCurrentLineHighlightColor ]
]

{ #category : #accessing }
BrGtAbstractThemeColors >> tabSelectedBackgroundColor: aColor [
	self semanticColorAt: #tabSelectedBackgroundColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> tabTextColor [
	^ self semanticColorAt: #tabTextColor ifAbsent: [ self secondaryTextColor ]
]

{ #category : #accessing }
BrGtAbstractThemeColors >> tabTextColor: aColor [
	self semanticColorAt: #tabTextColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> tabSelectedTextColor [
	^ self semanticColorAt: #tabSelectedTextColor ifAbsent: [ self primaryTextColor ]
]

{ #category : #accessing }
BrGtAbstractThemeColors >> tabSelectedTextColor: aColor [
	self semanticColorAt: #tabSelectedTextColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> borderColor [
	^ self semanticColorAt: #borderColor ifAbsent: [ self markupBorderColor ]
]

{ #category : #accessing }
BrGtAbstractThemeColors >> borderColor: aColor [
	self semanticColorAt: #borderColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> subtleBorderColor [
	^ self semanticColorAt: #subtleBorderColor ifAbsent: [ self markupBorderColor ]
]

{ #category : #accessing }
BrGtAbstractThemeColors >> subtleBorderColor: aColor [
	self semanticColorAt: #subtleBorderColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> strongBorderColor [
	^ self semanticColorAt: #strongBorderColor ifAbsent: [ self sourceSelectionColor ]
]

{ #category : #accessing }
BrGtAbstractThemeColors >> strongBorderColor: aColor [
	self semanticColorAt: #strongBorderColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> dividerColor [
	^ self semanticColorAt: #dividerColor ifAbsent: [ self markupBorderColor ]
]

{ #category : #accessing }
BrGtAbstractThemeColors >> dividerColor: aColor [
	self semanticColorAt: #dividerColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> focusBorderColor [
	^ self semanticColorAt: #focusBorderColor ifAbsent: [ self sourceSelectionColor ]
]

{ #category : #accessing }
BrGtAbstractThemeColors >> focusBorderColor: aColor [
	self semanticColorAt: #focusBorderColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> itemBackgroundColor [
	^ self semanticColorAt: #itemBackgroundColor ifAbsent: [ self sourceBackgroundColor ]
]

{ #category : #accessing }
BrGtAbstractThemeColors >> itemBackgroundColor: aColor [
	self semanticColorAt: #itemBackgroundColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> itemDeselectedBackgroundColor [
	^ self semanticColorAt: #itemDeselectedBackgroundColor ifAbsent: [ self itemBackgroundColor ]
]

{ #category : #accessing }
BrGtAbstractThemeColors >> itemDeselectedBackgroundColor: aColor [
	self semanticColorAt: #itemDeselectedBackgroundColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> itemSelectedBackgroundColor [
	^ self semanticColorAt: #itemSelectedBackgroundColor ifAbsent: [ self sourceSelectionColor ]
]

{ #category : #accessing }
BrGtAbstractThemeColors >> itemSelectedBackgroundColor: aColor [
	self semanticColorAt: #itemSelectedBackgroundColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> itemHoveredBackgroundColor [
	^ self semanticColorAt: #itemHoveredBackgroundColor ifAbsent: [ self sourceCurrentLineHighlightColor ]
]

{ #category : #accessing }
BrGtAbstractThemeColors >> itemHoveredBackgroundColor: aColor [
	self semanticColorAt: #itemHoveredBackgroundColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> itemPressedBackgroundColor [
	^ self semanticColorAt: #itemPressedBackgroundColor ifAbsent: [ self itemSelectedBackgroundColor ]
]

{ #category : #accessing }
BrGtAbstractThemeColors >> itemPressedBackgroundColor: aColor [
	self semanticColorAt: #itemPressedBackgroundColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> itemFocusedBorderColor [
	^ self semanticColorAt: #itemFocusedBorderColor ifAbsent: [ self focusBorderColor ]
]

{ #category : #accessing }
BrGtAbstractThemeColors >> itemFocusedBorderColor: aColor [
	self semanticColorAt: #itemFocusedBorderColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> itemTextColor [
	^ self semanticColorAt: #itemTextColor ifAbsent: [ self primaryTextColor ]
]

{ #category : #accessing }
BrGtAbstractThemeColors >> itemTextColor: aColor [
	self semanticColorAt: #itemTextColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> itemSelectedTextColor [
	^ self semanticColorAt: #itemSelectedTextColor ifAbsent: [ self primaryTextColor ]
]

{ #category : #accessing }
BrGtAbstractThemeColors >> itemSelectedTextColor: aColor [
	self semanticColorAt: #itemSelectedTextColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> itemHoveredTextColor [
	^ self semanticColorAt: #itemHoveredTextColor ifAbsent: [ self primaryTextColor ]
]

{ #category : #accessing }
BrGtAbstractThemeColors >> itemHoveredTextColor: aColor [
	self semanticColorAt: #itemHoveredTextColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> itemPressedTextColor [
	^ self semanticColorAt: #itemPressedTextColor ifAbsent: [ self primaryTextColor ]
]

{ #category : #accessing }
BrGtAbstractThemeColors >> itemPressedTextColor: aColor [
	self semanticColorAt: #itemPressedTextColor put: aColor
]

{ #category : #accessing }
BrGtAbstractThemeColors >> itemDisabledTextColor [
	^ self semanticColorAt: #itemDisabledTextColor ifAbsent: [ self disabledTextColor ]
]

{ #category : #accessing }
BrGtAbstractThemeColors >> itemDisabledTextColor: aColor [
	self semanticColorAt: #itemDisabledTextColor put: aColor
]
