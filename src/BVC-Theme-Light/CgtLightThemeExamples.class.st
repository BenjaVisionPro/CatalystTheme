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
CgtLightThemeExamples class >> theme [
    ^ CgtLightTheme new
]
