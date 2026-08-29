Extension { #name : #BrGlamorousEditorTheme }

{ #category : #'*BVC-Theme-GT' }
BrGlamorousEditorTheme >> defaultBackground [
	^ self theme default contentBackground
]

{ #category : #'*BVC-Theme-GT' }
BrGlamorousEditorTheme >> selectedTextForeground [
	^ self defaultTextForeground
]

{ #category : #'*BVC-Theme-GT' }
BrGlamorousEditorTheme >> textSelectionColor [
	^ (Color r: 0 g: 112 b: 252 range: 255) alpha: 0.3
]
