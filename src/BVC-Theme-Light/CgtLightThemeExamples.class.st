Class {
    #name : #CgtLightThemeExamples,
    #superclass : #Object,
    #category : #'BVC-Theme-Light'
}

{ #category : #examples }
CgtLightThemeExamples class >> inspectTheme [
    ^ self theme inspect
]

{ #category : #examples }
CgtLightThemeExamples class >> openThemeEditor [
    ^ GtBlocThemeEditorElement new editTheme: self theme
]


{ #category : #examples }
CgtLightThemeExamples class >> worldSurfaceBackground [
    ^ self theme default appBackground
]

{ #category : #examples }
CgtLightThemeExamples class >> worldSurfaceBackgroundColor [
    ^ self theme colors appBackgroundColor
]

{ #category : #examples }
CgtLightThemeExamples class >> worldSurfaceBackgroundValue [
    ^ self theme bindings valueForConsumerSelector: #appBackground fromPalette: self theme uiPalette
]

{ #category : #examples }
CgtLightThemeExamples class >> theme [
    ^ CgtLightTheme new
]
