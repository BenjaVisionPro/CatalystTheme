Extension { #name : #BrMenuTextLabelElement }

{ #category : #'*BVC-Theme-GT' }
BrMenuTextLabelElement >> applyThemeToShortcut [
	shortcutElement border:
		(BlBorder
			paint: (self theme typography quaternaryForeground
				blocResolveColorForTheme: self theme)
			width: 0.5).
	shortcutLabel aptitude foreground:
		(self theme typography tertiaryForeground
			blocResolveColorForTheme: self theme)
]

{ #category : #'*BVC-Theme-GT' }
BrMenuTextLabelElement >> initializeCommonStyling [
	self
		addAptitude:
			(BrStyleCommonAptitude new @ labelElement / #label
				default: [ :aStyle |
					aStyle foreground: self theme label defaultTextForeground ];
				selected: [ :aStyle |
					aStyle foreground: self theme highlight foregroundColor ];
				disabled: [ :aStyle |
					aStyle
						do: [ self updateLabelElement ]
						after: [ self updateLabelElement ] ])
]

{ #category : #'*BVC-Theme-GT' }
BrMenuTextLabelElement >> labelText [
	| aFormatedText |
	aFormatedText := nil.
	self labelModel textDo: [ :aText |
		aFormatedText := aText asRopedText glamorousRegularFont.
		self labelModel previewDo: [ :aPreview |
			aFormatedText append:
			((' ' , aPreview asString) asRopedText
				glamorousCodeFont;
				foreground:
					(self theme typography tertiaryForeground
						blocResolveColorForTheme: self theme);
				glamorousCodeTinySize) ] ].

	aFormatedText ifNotNil: [
		self isDisabled ifTrue: [
			aFormatedText foreground:
				(self theme typography disabledForeground
					blocResolveColorForTheme: self theme) ] ].

	^ aFormatedText ifNil: [ '' ]
]

{ #category : #'*BVC-Theme-GT' }
BrMenuTextLabelElement >> onThemeChanged [
	super onThemeChanged.
	self applyThemeToShortcut.
	self updateElement
]
