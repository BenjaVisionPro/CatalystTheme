Class {
    #name : #CgtSemanticRoleRegistry,
    #superclass : #Object,
    #instVars : [
        'rolesByName'
    ],
    #category : #'BVC-Theme-Core'
}

{ #category : #'instance creation' }
CgtSemanticRoleRegistry class >> phaseOneDefault [
    | registry |
    registry := self new.

    registry registerRoles: {
        (CgtSemanticRole named: #surfaceWorldBackground domain: #ui kind: #background).
        (CgtSemanticRole named: #surfaceChromePrimary domain: #ui kind: #color).
        (CgtSemanticRole named: #surfaceChromeSecondary domain: #ui kind: #color).
        (CgtSemanticRole named: #surfaceTabBarBackground domain: #ui kind: #color).
        (CgtSemanticRole named: #surfaceTabContentBackground domain: #ui kind: #color).
        (CgtSemanticRole named: #surfaceContentPrimary domain: #ui kind: #color).
        (CgtSemanticRole named: #surfaceContentSecondary domain: #ui kind: #color).
        (CgtSemanticRole named: #textPrimary domain: #ui kind: #color).
        (CgtSemanticRole named: #textSecondary domain: #ui kind: #color).
        (CgtSemanticRole named: #textMuted domain: #ui kind: #color).
        (CgtSemanticRole named: #borderDefault domain: #ui kind: #color).
        (CgtSemanticRole named: #borderFocus domain: #ui kind: #color).
        (CgtSemanticRole named: #itemBackground domain: #ui kind: #color).
        (CgtSemanticRole named: #itemBackgroundSelected domain: #ui kind: #color).
        (CgtSemanticRole named: #itemBackgroundHovered domain: #ui kind: #color).
        (CgtSemanticRole named: #itemText domain: #ui kind: #color).
        (CgtSemanticRole named: #itemTextSelected domain: #ui kind: #color).
        (CgtSemanticRole named: #headerBackground domain: #ui kind: #color).
        (CgtSemanticRole named: #headerText domain: #ui kind: #color).
        (CgtSemanticRole named: #tabBackgroundActive domain: #ui kind: #color).
        (CgtSemanticRole named: #tabBackgroundInactive domain: #ui kind: #color).
        (CgtSemanticRole named: #tabTextActive domain: #ui kind: #color).
        (CgtSemanticRole named: #tabTextInactive domain: #ui kind: #color).
        (CgtSemanticRole named: #codeBackground domain: #code kind: #color).
        (CgtSemanticRole named: #codeTextPlain domain: #code kind: #color).
        (CgtSemanticRole named: #codeTextComment domain: #code kind: #color).
        (CgtSemanticRole named: #codeTextKeyword domain: #code kind: #color).
        (CgtSemanticRole named: #codeTextString domain: #code kind: #color)
    }.

    ^ registry
]

{ #category : #initialization }
CgtSemanticRoleRegistry >> initialize [
    super initialize.
    rolesByName := Dictionary new
]

{ #category : #accessing }
CgtSemanticRoleRegistry >> codeRoles [
    ^ self roles select: [ :each | each isCodeRole ]
]

{ #category : #testing }
CgtSemanticRoleRegistry >> hasRoleNamed: aSymbol [
    ^ rolesByName includesKey: aSymbol
]

{ #category : #private }
CgtSemanticRoleRegistry >> assertRoleNameIsUnique: aSymbol [
    (self hasRoleNamed: aSymbol)
        ifTrue: [ self error: 'Duplicate semantic role: ', aSymbol asString ]
]

{ #category : #registering }
CgtSemanticRoleRegistry >> registerRole: aRole [
    self assertRoleNameIsUnique: aRole name.
    rolesByName at: aRole name put: aRole
]

{ #category : #registering }
CgtSemanticRoleRegistry >> registerRoles: aCollection [
    aCollection do: [ :each | self registerRole: each ]
]

{ #category : #accessing }
CgtSemanticRoleRegistry >> roleNamed: aSymbol [
    ^ rolesByName
        at: aSymbol
        ifAbsent: [ self error: 'Unknown semantic role: ', aSymbol asString ]
]

{ #category : #accessing }
CgtSemanticRoleRegistry >> roles [
    ^ rolesByName values asArray
]

{ #category : #accessing }
CgtSemanticRoleRegistry >> uiRoles [
    ^ self roles select: [ :each | each isUiRole ]
]
