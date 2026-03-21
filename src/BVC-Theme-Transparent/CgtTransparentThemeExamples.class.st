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
CgtTransparentThemeExamples class >> openThemeEditorOrangeTealSpace [
    ^ GtBlocThemeEditorElement new editTheme: self themeOrangeTealSpace
]

{ #category : #examples }
CgtTransparentThemeExamples class >> openThemeEditorPurpleSpace [
    ^ GtBlocThemeEditorElement new editTheme: self themePurpleSpace
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
CgtTransparentThemeExamples class >> worldSurfaceBackgroundValue [
    ^ self theme bindings valueForConsumerSelector: #appBackground fromPalette: self theme uiPalette
]

{ #category : #examples }
CgtTransparentThemeExamples class >> worldSurfaceBackgroundValueOrangeTealSpace [
    ^ self themeOrangeTealSpace bindings valueForConsumerSelector: #appBackground fromPalette: self themeOrangeTealSpace uiPalette
]

{ #category : #examples }
CgtTransparentThemeExamples class >> worldSurfaceBackgroundValuePurpleSpace [
    ^ self themePurpleSpace bindings valueForConsumerSelector: #appBackground fromPalette: self themePurpleSpace uiPalette
]

{ #category : #examples }
CgtTransparentThemeExamples class >> theme [
    ^ self themeOrangeTealSpace
]

{ #category : #examples }
CgtTransparentThemeExamples class >> themeOrangeTealSpace [
    | theme |
    theme := CgtTransparentTheme new.
    theme useOrangeTealSpaceWorldBackground.
    ^ theme
]

{ #category : #examples }
CgtTransparentThemeExamples class >> themePurpleSpace [
    | theme |
    theme := CgtTransparentTheme new.
    theme usePurpleSpaceWorldBackground.
    ^ theme
]
