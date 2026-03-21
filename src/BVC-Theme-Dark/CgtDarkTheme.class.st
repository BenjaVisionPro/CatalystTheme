Class {
    #name : #CgtDarkTheme,
    #superclass : #CgtAbstractTheme,
    #category : #'BVC-Theme-Dark'
}

{ #category : #'class defaults' }
CgtDarkTheme class >> buttonThemeClass [
    ^ BrGlamorousButtonDarkTheme
]

{ #category : #'class defaults' }
CgtDarkTheme class >> colorsClass [
    ^ CgtDarkThemeColors
]

{ #category : #'class defaults' }
CgtDarkTheme class >> defaultThemeClass [
    ^ CgtDarkDefaultTheme
]

{ #category : #'class defaults' }
CgtDarkTheme class >> editorThemeClass [
    ^ CgtDarkEditorTheme
]

{ #category : #'class defaults' }
CgtDarkTheme class >> headerThemeClass [
    ^ CgtDarkHeaderTheme
]

{ #category : #'class defaults' }
CgtDarkTheme class >> itemThemeClass [
    ^ CgtDarkItemTheme
]

{ #category : #initialization }
CgtDarkTheme >> initializeBindings [
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
CgtDarkTheme >> initializePalettes [
    uiPalette := CgtDarkUIPalette new.
    codePalette := CgtDarkCodePalette new
]
