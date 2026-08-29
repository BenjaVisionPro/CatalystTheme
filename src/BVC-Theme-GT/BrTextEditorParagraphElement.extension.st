Extension { #name : #BrTextEditorParagraphElement }

{ #category : #'*BVC-Theme-GT' }
BrTextEditorParagraphElement >> addText: aBlText toBuilder: aParagraphBuilder selectedTextColor: aTextColor [
	| anIterator |
	anIterator := aBlText iterator.
	[ anIterator hasNext ]
		whileTrue: [ | eachSpan |
			eachSpan := anIterator nextSpan.

			eachSpan attributes
				ifNotEmpty: [ :theAttributes |
					| aFontAndStyleBuilder |
					aFontAndStyleBuilder := BlTextFontAndStyleBuilder new.
					theAttributes
						do: [ :eachAttribute | eachAttribute applyOnFontAndStyleBuilder: aFontAndStyleBuilder theme: self theme ].

					SkiaParagraphTextStyle
						newDuring: [ :aTextStyle |
							aFontAndStyleBuilder hasCustomFontStyle
								ifTrue: [ | aFontWeight aFontStretch aFontSlant |
									aFontWeight := aFontAndStyleBuilder hasCustomFontWeight
										ifTrue: [ aFontAndStyleBuilder fontWeight ]
										ifFalse: [ BlFontWeight normal ].
									aFontStretch := aFontAndStyleBuilder hasCustomFontStretch
										ifTrue: [ aFontAndStyleBuilder fontStretch ]
										ifFalse: [ BlFontStretch normal ].
									aFontSlant := aFontAndStyleBuilder hasCustomFontSlant
										ifTrue: [ aFontAndStyleBuilder fontSlant ]
										ifFalse: [ BlFontSlant normal ].

									SkiaFontStyle
										weight: aFontWeight value
										width: (self class fontStretchToSkia: aFontStretch)
										slant: (self class fontSlantToSkia: aFontSlant)
										during: [ :aSkiaFontStyle | aTextStyle fontStyle: aSkiaFontStyle ] ].

							aFontAndStyleBuilder hasCustomFontSize
								ifTrue: [ aTextStyle fontSize: aFontAndStyleBuilder resolvedFontSize value asFloat ]
								ifFalse: [ aTextStyle fontSize: self defaultFontSize ].

							aFontAndStyleBuilder hasCustomFamilyName
								ifTrue: [ aTextStyle fontFamily: aFontAndStyleBuilder resolvedFontFamilyName ].

							aTextStyle color: (aTextColor blocResolveColorForTheme: self theme).

							aFontAndStyleBuilder hasCustomDecoration
								ifTrue: [ SkiaTextDecoration
										newDuring: [ :aSkiaDecoration |
											aFontAndStyleBuilder decoration applyOnSkiaDecoration: aSkiaDecoration.
											aTextStyle decoration: aSkiaDecoration ] ].

							aParagraphBuilder
								pushStyle: aTextStyle;
								addString: eachSpan asString;
								popStyle ] ]
				ifEmpty: [
					SkiaParagraphTextStyle
						newDuring: [ :aTextStyle |
							aTextStyle color: (aTextColor blocResolveColorForTheme: self theme).
							aParagraphBuilder
								pushStyle: aTextStyle;
								addString: eachSpan asString;
								popStyle ] ] ]
]

{ #category : #'*BVC-Theme-GT' }
BrTextEditorParagraphElement >> buildParagraphForSelectedTextColor: aTextColor [
	| aBuilder |
	aBuilder := SkiaParagraphBuilder
		style: (SkiaParagraphStyle new
			textStyle: (SkiaParagraphTextStyle new
				color: (aTextColor blocResolveColorForTheme: self theme);
				fontSize: self defaultFontSize))
		fontCollection: SkiaFontCollection default
		tabSize: BrEditorElement editorTabSize.

	self childrenDo: [ :eachElement |
		eachElement visibility isGone ifFalse: [
			(self canAddTextToParagraph: eachElement)
				ifTrue: [ self addText: eachElement text toBuilder: aBuilder selectedTextColor: aTextColor ]
				ifFalse: [
					(eachElement userData at: #brickEditorOverlay ifAbsent: [ false ])
						ifTrue: [
							aBuilder
								addPlaceholder: (SkiaParagraphPlaceholderStyle new
									alignTop;
									extent: 0 @ eachElement measuredExtent y)
								charLength: 0 ]
						ifFalse: [
							(eachElement isKindOf: BrCursorElement) ifFalse: [
								| placeholder |
								placeholder := SkiaParagraphPlaceholderStyle new.
								eachElement supportsBaseline
									ifTrue: [ placeholder baselineOffset: eachElement baselineOffset ]
									ifFalse: [ placeholder perform: eachElement placeholderAlignment ].
								placeholder extent: eachElement measuredExtent.
								aBuilder
									addPlaceholder: placeholder
									charLength: (eachElement userData at: #brickEditorCharLength ifAbsent: [ 0 ]) ] ] ] ] ].
	^ aBuilder build
]

{ #category : #'*BVC-Theme-GT' }
BrTextEditorParagraphElement >> defaultSelectedTextColor [
	^ self theme editor selectedTextForeground
]

{ #category : #'*BVC-Theme-GT' }
BrTextEditorParagraphElement >> drawChildrenOnSpartaCanvas: aCanvas [
	aCanvas clip
		when: [ self clipChildren ]
		by: [ self geometry pathOnSpartaCanvas: aCanvas of: self ]
		during: [
			paragraph
				valueDo: [ :aParagraph | aParagraph paintOn: aCanvas at: self padding topLeft ]
				ifNone: [ self requestLayout ].

			self drawSelectionOnSpartaCanvas: aCanvas.
			self drawSelectedTextOnSpartaCanvas: aCanvas at: self padding topLeft.

			self children sortedByElevation
				do: [ :anElement |
					(self canAddTextToParagraph: anElement)
						ifFalse: [ anElement fullDrawOnSpartaCanvas: aCanvas ] ] ]
]

{ #category : #'*BVC-Theme-GT' }
BrTextEditorParagraphElement >> drawSelectedTextOnSpartaCanvas: aCanvas at: anOrigin [
	selection isEmpty ifTrue: [ ^ self ].

	paragraph valueDo: [ :aParagraph |
		| aSelectedParagraph aSelectionPath textChildren |
		textChildren := self children select: [ :each | self canAddTextToParagraph: each ].
		aSelectedParagraph := self buildParagraphForSelectedTextColor: self defaultSelectedTextColor.
		aSelectedParagraph layoutWithWidth: aParagraph maxWidth.
		aSelectionPath := self selectionPathFor: aParagraph onSpartaCanvas: aCanvas.

		Transcript
			show: 'selected repaint text children: '; show: textChildren size printString; cr;
			show: 'selected repaint source chars: '; show: (textChildren sum: [ :each | each text size ]) printString; cr;
			show: 'source paragraph maxWidth/height/longestLine: ';
				show: aParagraph maxWidth printString; show: ' / ';
				show: aParagraph height printString; show: ' / ';
				show: aParagraph longestLine printString; cr;
			show: 'selected paragraph maxWidth/height/longestLine: ';
				show: aSelectedParagraph maxWidth printString; show: ' / ';
				show: aSelectedParagraph height printString; show: ' / ';
				show: aSelectedParagraph longestLine printString; cr;
			show: 'selected repaint origin: '; show: anOrigin printString; cr.

		aCanvas clip
			by: aSelectionPath
			during: [ aSelectedParagraph paintOn: aCanvas at: anOrigin ] ]
]

{ #category : #'*BVC-Theme-GT' }
BrTextEditorParagraphElement >> paintSelectionOn: aCompositorPainter offset: anOffset [
	| aSelectedTextForeground |
	selection isEmpty ifTrue: [ ^ self ].

	aSelectedTextForeground := self defaultSelectedTextColor blocResolveColorForTheme: self theme.
	Transcript
		cr;
		show: '--- BrTextEditorParagraphElement selected-text trace ---'; cr;
		show: 'paragraph theme: '; show: self theme printString; cr;
		show: 'theme class: '; show: self theme class name; cr;
		show: 'editor subtheme: '; show: self theme editor class name; cr;
		show: 'typography subtheme: '; show: self theme typography class name; cr;
		show: 'editor selectedTextForeground: '; show: self theme editor selectedTextForeground printString; cr;
		show: 'resolved selected text colour: '; show: aSelectedTextForeground printString; cr;
		show: 'selection: '; show: selection printString; cr;
		show: 'paint offset: '; show: anOffset printString; cr;
		show: '--- end selected-text trace ---'; cr.

	aCompositorPainter canvas transform
		by: [ :t | t translateBy: anOffset ]
		during: [
			self drawSelectionOnSpartaCanvas: aCompositorPainter canvas.
			self
				drawSelectedTextOnSpartaCanvas: aCompositorPainter canvas
				at: 0 @ 0 ]
]

{ #category : #'*BVC-Theme-GT' }
BrTextEditorParagraphElement >> selectionPathFor: aParagraph onSpartaCanvas: aCanvas [
	| aPathBuilder |
	aPathBuilder := aCanvas path.
	selection do: [ :eachMonotoneSelection |
		(aParagraph
			rectanglesForChars: (eachMonotoneSelection from to: eachMonotoneSelection to)
			width: SkiaParagraphRectWidthStyle Max
			height: SkiaParagraphRectHeightStyle Max)
			do: [ :eachRectangle |
				aPathBuilder
					moveTo: eachRectangle topLeft;
					lineTo: eachRectangle topRight;
					lineTo: eachRectangle bottomRight;
					lineTo: eachRectangle bottomLeft;
					lineTo: eachRectangle topLeft;
					close ] ].
	^ aPathBuilder build
]
