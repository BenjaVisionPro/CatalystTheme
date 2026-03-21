Class {
    #name : #CgtDarkHighContrastTheme,
    #superclass : #CgtAbstractTheme,
    #category : #'BVC-Theme-DarkHighContrast'
}

{ #category : #'class defaults' }
CgtDarkHighContrastTheme class >> buttonThemeClass [
    ^ BrGlamorousButtonDarkTheme
]

{ #category : #'class defaults' }
CgtDarkHighContrastTheme class >> colorsClass [
    ^ CgtDarkHighContrastThemeColors
]

{ #category : #'class defaults' }
CgtDarkHighContrastTheme class >> defaultThemeClass [
    ^ CgtDarkHighContrastDefaultTheme
]

{ #category : #'class defaults' }
CgtDarkHighContrastTheme class >> editorThemeClass [
    ^ CgtDarkHighContrastEditorTheme
]

{ #category : #'class defaults' }
CgtDarkHighContrastTheme class >> headerThemeClass [
    ^ CgtDarkHighContrastHeaderTheme
]

{ #category : #'class defaults' }
CgtDarkHighContrastTheme class >> itemThemeClass [
    ^ CgtDarkHighContrastItemTheme
]

{ #category : #initialization }
CgtDarkHighContrastTheme >> initializeBindings [
    super initializeBindings.
    bindings addBindings: {
        (CgtAbstractBinding roleNamed: #surfaceWorldBackground consumerSelector: #appBackgroundColor).
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
CgtDarkHighContrastTheme >> initializePalettes [
    uiPalette := CgtDarkHighContrastUIPalette new.
    codePalette := CgtDarkHighContrastCodePalette new
]
