Class {
	#name : #BrGtLightThemeColors,
	#superclass : #BrGtAbstractThemeColors,
	#category : #'BVC-Theme-Light'
}
{ #category : #'private - helpers' }
BrGtLightThemeColors >> isDark [
	^ false
]
{ #category : #initialization }
BrGtLightThemeColors >> initialize [
	super initialize.
	self consoleInputTextColor: (self colorFromXcodeString: '0 0 0 1').
	self consoleOutputTextColor: (self colorFromXcodeString: '0 0 0 1').
	self consolePromptTextColor: (self colorFromXcodeString: '0.152941 0.494118 0.117647 1').
	self consoleExecutableInputTextColor: (self colorFromXcodeString: '0 0 0 1').
	self consoleExecutableOutputTextColor: (self colorFromXcodeString: '0 0 0 1').
	self consoleBackgroundColor: (self colorFromXcodeString: '1 1 1 1').
	self consoleInsertionPointColor: (self colorFromXcodeString: '0.0408148 0.374814 0.998368 1').
	self consoleSelectionColor: (self colorFromXcodeString: '0.642038 0.802669 0.999195 1').
	self markupBackgroundColor: (self colorFromXcodeString: '0.96 0.96 0.96 1').
	self markupBorderColor: (self colorFromXcodeString: '0.8832 0.8832 0.8832 1').
	self markupEmphasisColor: (self colorFromXcodeString: '0 0 0 1').
	self markupInlineCodeColor: (self colorFromXcodeString: '0 0 0 0.7').
	self markupLinkColor: (self colorFromXcodeString: '0.055 0.055 1 1').
	self markupNormalColor: (self colorFromXcodeString: '0 0 0 1').
	self markupOtherHeadingColor: (self colorFromXcodeString: '0 0 0 0.5').
	self markupPrimaryHeadingColor: (self colorFromXcodeString: '0 0 0 1').
	self markupSecondaryHeadingColor: (self colorFromXcodeString: '0 0 0 1').
	self markupStrongColor: (self colorFromXcodeString: '0 0 0 1').
	self analyzerMarkerColor: (self colorFromXcodeString: '0.403922 0.372549 1 1').
	self breakpointMarkerColor: (self colorFromXcodeString: '0.290196 0.290196 0.968627 1').
	self diffMarkerColor: (self colorFromXcodeString: '0.556863 0.556863 0.556863 1').
	self diffConflictMarkerColor: (self colorFromXcodeString: '0.968627 0.290196 0.290196 1').
	self errorMarkerColor: (self colorFromXcodeString: '0.968627 0.290196 0.290196 1').
	self runtimeIssueMarkerColor: (self colorFromXcodeString: '0.643137 0.509804 1 1').
	self warningMarkerColor: (self colorFromXcodeString: '0.937255 0.717647 0.34902 1').
	self sourceBlockDimBackgroundColor: (self colorFromXcodeString: '0.424672 0.424672 0.424672 1').
	self sourceCurrentLineHighlightColor: (self colorFromXcodeString: '0.909804 0.94902 1 1').
	self sourceInsertionPointColor: (self colorFromXcodeString: '0.0408148 0.374814 0.998368 1').
	self sourceInvisiblesColor: (self colorFromXcodeString: '0.8 0.8 0.8 1').
	self sourceSelectionColor: (self colorFromXcodeString: '0.642038 0.802669 0.999195 1').
	self sourceBackgroundColor: (self colorFromXcodeString: '1 1 1 1').
	self syntaxAttributeColor: (self colorFromXcodeString: '0.505801 0.371396 0.012096 1').
	self syntaxCharacterColor: (self colorFromXcodeString: '0.11 0 0.81 1').
	self syntaxCommentColor: (self colorFromXcodeString: '0.36526 0.421879 0.475154 1').
	self syntaxCommentDocumentationColor: (self colorFromXcodeString: '0.36526 0.421879 0.475154 1').
	self syntaxCommentDocumentationKeywordColor: (self colorFromXcodeString: '0.290196 0.333333 0.376471 1').
	self syntaxDeclarationOtherColor: (self colorFromXcodeString: '0.0588235 0.407843 0.627451 1').
	self syntaxDeclarationTypeColor: (self colorFromXcodeString: '0.0431373 0.309804 0.47451 1').
	self syntaxIdentifierClassColor: (self colorFromXcodeString: '0.109812 0.272761 0.288691 1').
	self syntaxIdentifierSystemClassColor: (self colorFromXcodeString: '0.224543 0 0.628029 1').
	self syntaxIdentifierConstantColor: (self colorFromXcodeString: '0.194184 0.429349 0.454553 1').
	self syntaxIdentifierSystemConstantColor: (self colorFromXcodeString: '0.421903 0.212783 0.663785 1').
	self syntaxIdentifierFunctionColor: (self colorFromXcodeString: '0.194184 0.429349 0.454553 1').
	self syntaxIdentifierSystemFunctionColor: (self colorFromXcodeString: '0.421903 0.212783 0.663785 1').
	self syntaxIdentifierMacroColor: (self colorFromXcodeString: '0.391471 0.220311 0.124457 1').
	self syntaxIdentifierSystemMacroColor: (self colorFromXcodeString: '0.391471 0.220311 0.124457 1').
	self syntaxIdentifierTypeColor: (self colorFromXcodeString: '0.109812 0.272761 0.288691 1').
	self syntaxIdentifierSystemTypeColor: (self colorFromXcodeString: '0.224543 0 0.628029 1').
	self syntaxIdentifierVariableColor: (self colorFromXcodeString: '0.194184 0.429349 0.454553 1').
	self syntaxIdentifierSystemVariableColor: (self colorFromXcodeString: '0.421903 0.212783 0.663785 1').
	self syntaxKeywordColor: (self colorFromXcodeString: '0.607592 0.137526 0.576284 1').
	self syntaxMarkColor: (self colorFromXcodeString: '0.290196 0.333333 0.376471 1').
	self syntaxMarkupCodeColor: (self colorFromXcodeString: '0.665 0.052 0.569 1').
	self syntaxNumberColor: (self colorFromXcodeString: '0.11 0 0.81 1').
	self syntaxPlainTextColor: (self colorFromXcodeString: '0 0 0 0.85').
	self syntaxPreprocessorColor: (self colorFromXcodeString: '0.391471 0.220311 0.124457 1').
	self syntaxRegexColor: (self colorFromXcodeString: '0.77 0.102 0.086 1').
	self syntaxRegexCaptureNameColor: (self colorFromXcodeString: '0.194184 0.429349 0.454553 1').
	self syntaxRegexCharacterNameColor: (self colorFromXcodeString: '0.421903 0.212783 0.663785 1').
	self syntaxRegexNumberColor: (self colorFromXcodeString: '0.11 0 0.81 1').
	self syntaxRegexOtherColor: (self colorFromXcodeString: '0 0 0 0.85').
	self syntaxStringColor: (self colorFromXcodeString: '0.77 0.102 0.086 1').
	self syntaxURLColor: (self colorFromXcodeString: '0.055 0.055 1 1').
	self initializeGlamorousMappings
]
