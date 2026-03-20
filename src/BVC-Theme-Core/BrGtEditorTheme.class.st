Class {
	#name : #BrGtEditorTheme,
	#superclass : #BrGlamorousEditorTheme,
	#category : #'BVC-Theme-Core'
}

{ #category : #initialization }
BrGtEditorTheme >> initialize [
	super initialize.
	borderColor := Color transparent.
	focusedBorderColor := Color transparent
]

{ #category : #initialization }
BrGtEditorTheme >> initializeThemeable [
	super initializeThemeable.

	borderColor := self
			color: [ :aTheme | aTheme colors editorBorderColor ]
			source: [ :aTheme | aTheme editor borderColor ].

	focusedBorderColor := self
			color: [ :aTheme | aTheme colors focusedEditorBorderColor ]
			source: [ :aTheme | aTheme editor focusedBorderColor ].

	defaultTextForeground := self
			color: [ :aTheme | aTheme colors primaryTextColor ]
			source: [ :aTheme | aTheme editor defaultTextForeground ].

	pharoDeclaredVariableForeground := self
			color: [ :aTheme | aTheme colors syntaxIdentifierVariableColor ]
			source: [ :aTheme | aTheme editor pharoDeclaredVariableForeground ].

	pharoUndeclaredVariableForeground := self
			color: [ :aTheme | aTheme colors syntaxIdentifierVariableColor ]
			source: [ :aTheme | aTheme editor pharoUndeclaredVariableForeground ].

	pharoSelfVariableForeground := self
			color: [ :aTheme | aTheme colors syntaxIdentifierClassColor ]
			source: [ :aTheme | aTheme editor pharoSelfVariableForeground ].

	pharoSuperVariableForeground := self
			color: [ :aTheme | aTheme colors syntaxIdentifierSystemClassColor ]
			source: [ :aTheme | aTheme editor pharoSuperVariableForeground ].

	pharoThisContextVariableForeground := self
			color: [ :aTheme | aTheme colors syntaxIdentifierSystemClassColor ]
			source: [ :aTheme | aTheme editor pharoThisContextVariableForeground ].

	pharoPragmaForeground := self
			color: [ :aTheme | aTheme colors syntaxAttributeColor ]
			source: [ :aTheme | aTheme editor pharoPragmaForeground ].

	pharoReturnArrowForeground := self
			color: [ :aTheme | aTheme colors syntaxKeywordColor ]
			source: [ :aTheme | aTheme editor pharoReturnArrowForeground ].

	pharoStringLiteralForeground := self
			color: [ :aTheme | aTheme colors syntaxStringColor ]
			source: [ :aTheme | aTheme editor pharoStringLiteralForeground ].

	pharoSymbolLiteralForeground := self
			color: [ :aTheme | aTheme colors syntaxStringColor ]
			source: [ :aTheme | aTheme editor pharoSymbolLiteralForeground ].

	pharoNumberLiteralForeground := self
			color: [ :aTheme | aTheme colors syntaxNumberColor ]
			source: [ :aTheme | aTheme editor pharoNumberLiteralForeground ].

	pharoNilLiteralForeground := self
			color: [ :aTheme | aTheme colors syntaxNumberColor ]
			source: [ :aTheme | aTheme editor pharoNilLiteralForeground ].

	pharoBooleanLiteralForeground := self
			color: [ :aTheme | aTheme colors syntaxNumberColor ]
			source: [ :aTheme | aTheme editor pharoBooleanLiteralForeground ].

	pharoCharacterLiteralForeground := self
			color: [ :aTheme | aTheme colors syntaxCharacterColor ]
			source: [ :aTheme | aTheme editor pharoCharacterLiteralForeground ].

	pharoCommentForeground := self
			color: [ :aTheme | aTheme colors syntaxCommentColor ]
			source: [ :aTheme | aTheme editor pharoCommentForeground ].

	pharoErrorTokenForeground := self
			color: [ :aTheme | aTheme colors errorMarkerColor ]
			source: [ :aTheme | aTheme editor pharoErrorTokenForeground ]
]
