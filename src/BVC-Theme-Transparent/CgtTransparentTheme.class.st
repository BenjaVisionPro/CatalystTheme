Class {
    #name : #CgtTransparentTheme,
    #superclass : #CgtAbstractTheme,
    #category : #'BVC-Theme-Transparent'
}

{ #category : #'class defaults' }
CgtTransparentTheme class >> buttonThemeClass [
    ^ BrGlamorousButtonDarkTheme
]

{ #category : #'class defaults' }
CgtTransparentTheme class >> colorsClass [
    ^ CgtTransparentThemeColors
]

{ #category : #'class defaults' }
CgtTransparentTheme class >> defaultThemeClass [
    ^ CgtTransparentDefaultTheme
]

{ #category : #'class defaults' }
CgtTransparentTheme class >> editorThemeClass [
    ^ CgtTransparentEditorTheme
]

{ #category : #'class defaults' }
CgtTransparentTheme class >> headerThemeClass [
    ^ CgtTransparentHeaderTheme
]

{ #category : #'class defaults' }
CgtTransparentTheme class >> itemThemeClass [
    ^ CgtTransparentItemTheme
]

{ #category : #initialization }
CgtTransparentTheme >> initializeBindings [
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
CgtTransparentTheme >> initializePalettes [
    uiPalette := CgtTransparentUIPalette new.
    codePalette := CgtTransparentCodePalette new
]

{ #category : #backgrounds }
CgtTransparentTheme >> useOrangeTealSpaceWorldBackground [
    self uiPalette useOrangeTealSpaceWorldBackground.
    self onThemeModified
]

{ #category : #backgrounds }
CgtTransparentTheme >> usePurpleSpaceWorldBackground [
    self uiPalette usePurpleSpaceWorldBackground.
    self onThemeModified
]
