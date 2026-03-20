Class {
	#name : #BrGtDarkThemeColorsHighContrast,
	#superclass : #BrGtAbstractThemeColors,
	#category : #'BVC-Theme-DarkHighContrast'
}
{ #category : #'private - helpers' }
BrGtDarkThemeColorsHighContrast >> isDark [
	^ true
]
{ #category : #initialization }
BrGtDarkThemeColorsHighContrast >> initialize [
	super initialize.
	self consoleInputTextColor: (self colorFromXcodeString: '1 1 1 1').
	self consoleOutputTextColor: (self colorFromXcodeString: '1 1 1 1').
	self consolePromptTextColor: (self colorFromXcodeString: '0.255 0.714 0.27 1').
	self consoleExecutableInputTextColor: (self colorFromXcodeString: '1 1 1 1').
	self consoleExecutableOutputTextColor: (self colorFromXcodeString: '1 1 1 1').
	self consoleBackgroundColor: (self colorFromXcodeString: '0.0922006 0.0917242 0.106091 1').
	self consoleInsertionPointColor: (self colorFromXcodeString: '1 1 1 1').
	self consoleSelectionColor: (self colorFromXcodeString: '0.317647 0.356862 0.439215 1').
	self markupBackgroundColor: (self colorFromXcodeString: '0.18856 0.195 0.22444 1').
	self markupBorderColor: (self colorFromXcodeString: '0.253475 0.2594 0.286485 1').
	self markupEmphasisColor: (self colorFromXcodeString: '1 1 1 1').
	self markupInlineCodeColor: (self colorFromXcodeString: '1 1 1 0.7').
	self markupLinkColor: (self colorFromXcodeString: '0.33 0.247124 0.894195 1').
	self markupNormalColor: (self colorFromXcodeString: '1 1 1 1').
	self markupOtherHeadingColor: (self colorFromXcodeString: '1 1 1 0.5').
	self markupPrimaryHeadingColor: (self colorFromXcodeString: '1 1 1 1').
	self markupSecondaryHeadingColor: (self colorFromXcodeString: '1 1 1 1').
	self markupStrongColor: (self colorFromXcodeString: '1 1 1 1').
	self analyzerMarkerColor: (self colorFromXcodeString: '0.403922 0.372549 1 1').
	self breakpointMarkerColor: (self colorFromXcodeString: '0.290196 0.290196 0.968627 1').
	self diffMarkerColor: (self colorFromXcodeString: '0.556863 0.556863 0.556863 1').
	self diffConflictMarkerColor: (self colorFromXcodeString: '0.968627 0.290196 0.290196 1').
	self errorMarkerColor: (self colorFromXcodeString: '0.968627 0.290196 0.290196 1').
	self runtimeIssueMarkerColor: (self colorFromXcodeString: '0.643137 0.509804 1 1').
	self warningMarkerColor: (self colorFromXcodeString: '0.937255 0.717647 0.34902 1').
	self sourceBlockDimBackgroundColor: (self colorFromXcodeString: '0.5 0.5 0.5 1').
	self sourceCurrentLineHighlightColor: (self colorFromXcodeString: '0.138526 0.146864 0.169283 1').
	self sourceInsertionPointColor: (self colorFromXcodeString: '1 1 1 1').
	self sourceInvisiblesColor: (self colorFromXcodeString: '0.258298 0.300954 0.355207 1').
	self sourceSelectionColor: (self colorFromXcodeString: '0.205867 0.234061 0.296016 1').
	self sourceBackgroundColor: (self colorFromXcodeString: '0.094118 0.090196 0.105882 1').
	self syntaxAttributeColor: (self colorFromXcodeString: '0.882718 0.655963 0.472558 1').
	self syntaxCharacterColor: (self colorFromXcodeString: '0.814725 0.736529 0.335488 1').
	self syntaxCommentColor: (self colorFromXcodeString: '0.486721 0.709574 0.330699 1').
	self syntaxCommentDocumentationColor: (self colorFromXcodeString: '0.486721 0.709574 0.330699 1').
	self syntaxCommentDocumentationKeywordColor: (self colorFromXcodeString: '0.67451 0.941176 0.482353 1').
	self syntaxDeclarationOtherColor: (self colorFromXcodeString: '0.258594 0.719796 0.877076 1').
	self syntaxDeclarationTypeColor: (self colorFromXcodeString: '0.364706 0.847059 1 1').
	self syntaxIdentifierClassColor: (self colorFromXcodeString: '0.644022 0.983529 0.901838 1').
	self syntaxIdentifierSystemClassColor: (self colorFromXcodeString: '0.870275 0.758393 0.999463 1').
	self syntaxIdentifierConstantColor: (self colorFromXcodeString: '0.448484 0.748715 0.682313 1').
	self syntaxIdentifierSystemConstantColor: (self colorFromXcodeString: '0.75482 0.539479 0.99907 1').
	self syntaxIdentifierFunctionColor: (self colorFromXcodeString: '0.448484 0.748715 0.682313 1').
	self syntaxIdentifierSystemFunctionColor: (self colorFromXcodeString: '0.75482 0.539479 0.99907 1').
	self syntaxIdentifierMacroColor: (self colorFromXcodeString: '0.991311 0.560764 0.246107 1').
	self syntaxIdentifierSystemMacroColor: (self colorFromXcodeString: '0.991311 0.560764 0.246107 1').
	self syntaxIdentifierTypeColor: (self colorFromXcodeString: '0.644022 0.983529 0.901838 1').
	self syntaxIdentifierSystemTypeColor: (self colorFromXcodeString: '0.870275 0.758393 0.999463 1').
	self syntaxIdentifierVariableColor: (self colorFromXcodeString: '0.448484 0.748715 0.682313 1').
	self syntaxIdentifierSystemVariableColor: (self colorFromXcodeString: '0.75482 0.539479 0.99907 1').
	self syntaxKeywordColor: (self colorFromXcodeString: '0.988964 0.421135 0.664991 1').
	self syntaxMarkColor: (self colorFromXcodeString: '0.67451 0.941176 0.482353 1').
	self syntaxMarkupCodeColor: (self colorFromXcodeString: '0.665 0.052 0.569 1').
	self syntaxNumberColor: (self colorFromXcodeString: '0.814725 0.736529 0.335488 1').
	self syntaxPlainTextColor: (self colorFromXcodeString: '1 1 1 1').
	self syntaxPreprocessorColor: (self colorFromXcodeString: '0.991311 0.560764 0.246107 1').
	self syntaxRegexColor: (self colorFromXcodeString: '0.989608 0.453865 0.404471 1').
	self syntaxRegexCaptureNameColor: (self colorFromXcodeString: '0.448484 0.748715 0.682313 1').
	self syntaxRegexCharacterNameColor: (self colorFromXcodeString: '0.75482 0.539479 0.99907 1').
	self syntaxRegexNumberColor: (self colorFromXcodeString: '0.814725 0.736529 0.335488 1').
	self syntaxRegexOtherColor: (self colorFromXcodeString: '1 1 1 1').
	self syntaxStringColor: (self colorFromXcodeString: '0.989608 0.453865 0.404471 1').
	self syntaxURLColor: (self colorFromXcodeString: '0.450366 0.602412 0.998771 1').
	self initializeGlamorousMappings
]
