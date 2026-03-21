Class {
    #name : #CgtDarkHighContrastThemeExamples,
    #superclass : #Object,
    #category : #'BVC-Theme-DarkHighContrast'
}

{ #category : #examples }
CgtDarkHighContrastThemeExamples class >> inspectTheme [
    ^ self theme inspect
]

{ #category : #examples }
CgtDarkHighContrastThemeExamples class >> openThemeEditor [
    ^ GtBlocThemeEditorElement new editTheme: self theme
]


{ #category : #examples }
CgtDarkHighContrastThemeExamples class >> worldSurfaceBackground [
    ^ self theme default appBackground
]

{ #category : #examples }
CgtDarkHighContrastThemeExamples class >> worldSurfaceBackgroundColor [
    ^ self theme colors appBackgroundColor
]

{ #category : #examples }
CgtDarkHighContrastThemeExamples class >> theme [
    ^ CgtDarkHighContrastTheme new
]
