Extension { #name : #BlBorder }

{ #category : #'*BVC-Theme-GT' }
BlBorder >> blocResolveForTheme: aTheme [
	| resolvedPaint |
	resolvedPaint := self paint blocResolveForTheme: aTheme.
	^ resolvedPaint = self paint
		ifTrue: [ self ]
		ifFalse: [ self copyWithPaint: resolvedPaint ]
]
