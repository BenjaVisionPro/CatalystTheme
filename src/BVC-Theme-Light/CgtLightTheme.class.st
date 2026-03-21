Class {
    #name : #CgtLightTheme,
    #superclass : #CgtAbstractTheme,
    #category : #'BVC-Theme-Light'
}

{ #category : #'class defaults' }
CgtLightTheme class >> buttonThemeClass [
    ^ BrGlamorousButtonLightTheme
]

{ #category : #'class defaults' }
CgtLightTheme class >> colorsClass [
    ^ CgtLightThemeColors
]

{ #category : #'class defaults' }
CgtLightTheme class >> defaultThemeClass [
    ^ CgtLightDefaultTheme
]

{ #category : #'class defaults' }
CgtLightTheme class >> editorThemeClass [
    ^ CgtLightEditorTheme
]

{ #category : #'class defaults' }
CgtLightTheme class >> headerThemeClass [
    ^ CgtLightHeaderTheme
]

{ #category : #'class defaults' }
CgtLightTheme class >> itemThemeClass [
    ^ CgtLightItemTheme
]

{ #category : #initialization }
CgtLightTheme >> initializeBindings [
    super initializeBindings.
    bindings addBindings: {
        (CgtAbstractBinding roleNamed: #surfaceWorldBackground consumerSelector: #appBackground).
        (CgtAbstractBinding roleNamed: #surfaceTabBarBackground consumerSelector: #backdropBackgroundColor).
        (CgtAbstractBinding roleNamed: #surfaceTabContentBackground consumerSelector: #contentBackgroundColor).
        (CgtAbstractBinding roleNamed: #surfaceChromePrimary consumerSelector: #appBackgroundColor).
        (CgtAbstractBinding roleNamed: #surfaceChromeSecondary consumerSelector: #backdropBackgroundColor).
        (CgtAbstractBinding roleNamed: #surfaceContentPrimary consumerSelector: #contentBackgroundColor).
        (CgtAbstractBinding roleNamed: #textPrimary consumerSelector: #primaryTextColor).
        (CgtAbstractBinding roleNamed: #borderDefault consumerSelector: #borderColor).
        (CgtAbstractBinding roleNamed: #codeTextKeyword consumerSelector: #pharoPragmaForeground)
    }
]

{ #category : #initialization }
CgtLightTheme >> initializePalettes [
    uiPalette := CgtLightUIPalette new.
    codePalette := CgtLightCodePalette new
]
