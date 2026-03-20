Class {
	#name : #BrGtDarkThemeColors,
	#superclass : #BrGtAbstractThemeColors,
	#category : #'BVC-Theme-Dark'
}
{ #category : #'private - helpers' }
BrGtDarkThemeColors >> isDark [
	^ true
]
{ #category : #initialization }
BrGtDarkThemeColors >> initialize [
	super initialize.
	self consoleInputTextColor: (self colorFromXcodeString: '1 1 1 1').
	self consoleOutputTextColor: (self colorFromXcodeString: '1 1 1 1').
	self consolePromptTextColor: (self colorFromXcodeString: '0.309804 0.788235 0.254902 1').
	self consoleExecutableInputTextColor: (self colorFromXcodeString: '1 1 1 1').
	self consoleExecutableOutputTextColor: (self colorFromXcodeString: '1 1 1 1').
	self consoleBackgroundColor: (self colorFromXcodeString: '0.120543 0.122844 0.141312 1').
	self consoleInsertionPointColor: (self colorFromXcodeString: '0.0408148 0.374814 0.998368 1').
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
	self sourceInsertionPointColor: (self colorFromXcodeString: '0.0408148 0.374814 0.998368 1').
	self sourceInvisiblesColor: (self colorFromXcodeString: '0.258298 0.300954 0.355207 1').
	self sourceSelectionColor: (self colorFromXcodeString: '0.317647 0.356862 0.439215 1').
	self sourceBackgroundColor: (self colorFromXcodeString: '0.117647 0.129412 0.133333 1').
	self syntaxAttributeColor: (self colorFromXcodeString: '0.74902 0.521569 0.333333 1').
	self syntaxCharacterColor: (self colorFromXcodeString: '0.815686 0.74902 0.411765 1').
	self syntaxCommentColor: (self colorFromXcodeString: '0.423943 0.474618 0.525183 1').
	self syntaxCommentDocumentationColor: (self colorFromXcodeString: '0.423943 0.474618 0.525183 1').
	self syntaxCommentDocumentationKeywordColor: (self colorFromXcodeString: '0.572549 0.631373 0.694118 1').
	self syntaxDeclarationOtherColor: (self colorFromXcodeString: '0.254902 0.631373 0.752941 1').
	self syntaxDeclarationTypeColor: (self colorFromXcodeString: '0.362946 0.846428 0.998966 1').
	self syntaxIdentifierClassColor: (self colorFromXcodeString: '0.619608 0.945098 0.866667 1').
	self syntaxIdentifierSystemClassColor: (self colorFromXcodeString: '0.815686 0.658824 1 1').
	self syntaxIdentifierConstantColor: (self colorFromXcodeString: '0.405383 0.717051 0.642088 1').
	self syntaxIdentifierSystemConstantColor: (self colorFromXcodeString: '0.632318 0.402193 0.901151 1').
	self syntaxIdentifierFunctionColor: (self colorFromXcodeString: '0.403922 0.717647 0.643137 1').
	self syntaxIdentifierSystemFunctionColor: (self colorFromXcodeString: '0.631373 0.403922 0.901961 1').
	self syntaxIdentifierMacroColor: (self colorFromXcodeString: '0.554335 0.559738 0.559522 1').
	self syntaxIdentifierSystemMacroColor: (self colorFromXcodeString: '0.992157 0.560784 0.247059 1').
	self syntaxIdentifierTypeColor: (self colorFromXcodeString: '0.621449 0.943864 0.868194 1').
	self syntaxIdentifierSystemTypeColor: (self colorFromXcodeString: '0.816806 0.656917 0.999271 1').
	self syntaxIdentifierVariableColor: (self colorFromXcodeString: '0.405383 0.717051 0.642088 1').
	self syntaxIdentifierSystemVariableColor: (self colorFromXcodeString: '0.632318 0.402193 0.901151 1').
	self syntaxKeywordColor: (self colorFromXcodeString: '0.988394 0.37355 0.638329 1').
	self syntaxMarkColor: (self colorFromXcodeString: '0.572549 0.631373 0.694118 1').
	self syntaxMarkupCodeColor: (self colorFromXcodeString: '0.665 0.052 0.569 1').
	self syntaxNumberColor: (self colorFromXcodeString: '0.814983 0.749393 0.412334 1').
	self syntaxPlainTextColor: (self colorFromXcodeString: '1 1 1 0.85').
	self syntaxPreprocessorColor: (self colorFromXcodeString: '0.991311 0.560764 0.246107 1').
	self syntaxRegexColor: (self colorFromXcodeString: '0.989117 0.41558 0.365684 1').
	self syntaxRegexCaptureNameColor: (self colorFromXcodeString: '0.405383 0.717051 0.642088 1').
	self syntaxRegexCharacterNameColor: (self colorFromXcodeString: '0.632318 0.402193 0.901151 1').
	self syntaxRegexNumberColor: (self colorFromXcodeString: '0.814983 0.749393 0.412334 1').
	self syntaxRegexOtherColor: (self colorFromXcodeString: '1 1 1 0.85').
	self syntaxStringColor: (self colorFromXcodeString: '0.988235 0.415686 0.364706 1').
	self syntaxURLColor: (self colorFromXcodeString: '0.330191 0.511266 0.998589 1').
	self initializeGlamorousMappings
]
