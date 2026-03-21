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
		(CgtSemanticRole named: #surfaceChromePrimary domain: #ui kind: #color description: 'Primary outer chrome surface').
		(CgtSemanticRole named: #surfaceChromeSecondary domain: #ui kind: #color description: 'Secondary chrome surface').
		(CgtSemanticRole named: #surfaceContentPrimary domain: #ui kind: #color description: 'Primary content surface').
		(CgtSemanticRole named: #surfaceContentSecondary domain: #ui kind: #color description: 'Secondary content surface').
		(CgtSemanticRole named: #textPrimary domain: #ui kind: #color description: 'Primary text color').
		(CgtSemanticRole named: #textSecondary domain: #ui kind: #color description: 'Secondary text color').
		(CgtSemanticRole named: #textMuted domain: #ui kind: #color description: 'Muted text color').
		(CgtSemanticRole named: #borderDefault domain: #ui kind: #color description: 'Default border color').
		(CgtSemanticRole named: #borderFocus domain: #ui kind: #color description: 'Focused border color').
		(CgtSemanticRole named: #itemBackground domain: #ui kind: #color description: 'Default item background').
		(CgtSemanticRole named: #itemBackgroundSelected domain: #ui kind: #color description: 'Selected item background').
		(CgtSemanticRole named: #itemBackgroundHovered domain: #ui kind: #color description: 'Hovered item background').
		(CgtSemanticRole named: #itemText domain: #ui kind: #color description: 'Default item text').
		(CgtSemanticRole named: #itemTextSelected domain: #ui kind: #color description: 'Selected item text').
		(CgtSemanticRole named: #headerBackground domain: #ui kind: #color description: 'Header background').
		(CgtSemanticRole named: #headerText domain: #ui kind: #color description: 'Header text').
		(CgtSemanticRole named: #tabBackgroundActive domain: #ui kind: #color description: 'Active tab background').
		(CgtSemanticRole named: #tabBackgroundInactive domain: #ui kind: #color description: 'Inactive tab background').
		(CgtSemanticRole named: #tabTextActive domain: #ui kind: #color description: 'Active tab text').
		(CgtSemanticRole named: #tabTextInactive domain: #ui kind: #color description: 'Inactive tab text').
		(CgtSemanticRole named: #codeBackground domain: #code kind: #color description: 'Code editor background').
		(CgtSemanticRole named: #codeTextPlain domain: #code kind: #color description: 'Plain code text').
		(CgtSemanticRole named: #codeTextComment domain: #code kind: #color description: 'Code comment text').
		(CgtSemanticRole named: #codeTextKeyword domain: #code kind: #color description: 'Code keyword text').
		(CgtSemanticRole named: #codeTextString domain: #code kind: #color description: 'Code string text') }.
	^ registry
]

{ #category : #private }
CgtSemanticRoleRegistry >> assertRoleNameIsUnique: aSymbol [
	(self hasRoleNamed: aSymbol)
		ifTrue: [ self error: 'Duplicate semantic role: ', aSymbol asString ]
]

{ #category : #accessing }
CgtSemanticRoleRegistry >> codeRoles [
	^ self roles select: [ :each | each isCodeRole ]
]

{ #category : #testing }
CgtSemanticRoleRegistry >> hasRoleNamed: aSymbol [
	^ rolesByName includesKey: aSymbol
]

{ #category : #initialization }
CgtSemanticRoleRegistry >> initialize [
	super initialize.
	rolesByName := Dictionary new
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
