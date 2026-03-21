Class {
    #name : #CgtTransparentThemeExamples,
    #superclass : #Object,
    #category : #'BVC-Theme-Transparent'
}

{ #category : #examples }
CgtTransparentThemeExamples class >> inspectTheme [
    ^ self theme inspect
]

{ #category : #examples }
CgtTransparentThemeExamples class >> openThemeEditor [
    ^ GtBlocThemeEditorElement new editTheme: self theme
]


{ #category : #examples }
CgtTransparentThemeExamples class >> worldSurfaceBackground [
    ^ self theme default appBackground
]

{ #category : #examples }
CgtTransparentThemeExamples class >> worldSurfaceBackgroundColor [
    ^ self theme colors appBackgroundColor
]

{ #category : #examples }
CgtTransparentThemeExamples class >> theme [
    ^ CgtTransparentTheme new
]
