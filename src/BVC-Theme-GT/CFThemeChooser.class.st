Class {
	#name : #CFThemeChooser,
	#superclass : #CFObject,
	#instVars : [
		'announcer',
		'choices',
		'selectedTheme',
		'themeConfiguration',
		'worldElement'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CFThemeChooser >> announcer [
	^ announcer
]

{ #category : #'magritte descriptions' }
CFThemeChooser >> descriptionContainerDetail: aDescription [
	<magritteContainer>
	^ aDescription
		blocPresentationStencil: [ :aMemento | CFMaDetailPresentation new ];
		yourself
]

{ #category : #initialization }
CFThemeChooser >> initialize [
	| currentTheme |
	super initialize.
	announcer := Announcer new.
	currentTheme := BlTheme default.
	choices := self themeChoicesFor: currentTheme.
	selectedTheme := choices
		detect: [ :aChoice | aChoice theme == currentTheme ]
		ifNone: [ choices first ].
	themeConfiguration := selectedTheme configuration
]


{ #category : #'magritte actions' }
CFThemeChooser >> magritteAcceptAction [
	<magritteActionDescription>
	^ nil
]

{ #category : #'magritte actions' }
CFThemeChooser >> magritteCancelAction [
	<magritteActionDescription>
	^ nil
]

{ #category : #accessing }
CFThemeChooser >> selectedTheme [
	^ selectedTheme
]

{ #category : #accessing }
CFThemeChooser >> selectedTheme: aChoice [
	selectedTheme == aChoice ifTrue: [ ^ self ].
	selectedTheme := aChoice.
	themeConfiguration := aChoice configuration.
	BlTheme default: aChoice theme.
	worldElement ifNotNil: [ worldElement theme: aChoice theme ].
	self announcer announce: CFThemeChooserChanged new
]

{ #category : #'magritte descriptions' }
CFThemeChooser >> selectedThemeDescription [
	<magritteDescription>
	^ MASingleOptionDescription new
		accessor: #selectedTheme;
		label: 'Theme';
		priority: 10;
		options: choices;
		autoAccept: true;
		fieldConfigure: [ :field |
			field bePopup
				displayBlock: [ :aChoice | aChoice label ] ];
		beRequired;
		yourself
]

{ #category : #private }
CFThemeChooser >> themeChoicesFor: currentTheme [
	| defaultChoices catalystChoices |
	defaultChoices := (BlTheme allSubclasses
		select: [ :aThemeClass | aThemeClass canBeDefault ])
		collect: [ :aThemeClass |
			CFThemeChoice
				theme: (aThemeClass = currentTheme class
					ifTrue: [ currentTheme ]
					ifFalse: [ aThemeClass new ])
				configuration: nil ].

	catalystChoices := CgtAbstractTheme subclasses collect: [ :aThemeClass |
		| aTheme |
		aTheme := aThemeClass = currentTheme class
			ifTrue: [ currentTheme ]
			ifFalse: [ aThemeClass new ].
		CFThemeChoice
			theme: aTheme
			configuration: aTheme themeState ].

	^ defaultChoices , catalystChoices
]

{ #category : #accessing }
CFThemeChooser >> themeConfiguration [
	^ themeConfiguration
]

{ #category : #accessing }
CFThemeChooser >> themeConfiguration: aModel [
	themeConfiguration := aModel
]

{ #category : #accessing }
CFThemeChooser >> worldElement: anElement [
	worldElement := anElement
]

{ #category : #'magritte descriptions' }
CFThemeChooser >> themeConfigurationDescription [
	<magritteDescription>
	^ MAToOneRelationDescription new
		accessor: #themeConfiguration;
		label: '';
		priority: 20;
		classes: { CgtThemeState };
		beReadOnly;
		fieldConfigure: [ :field | field beEmbeddedForms ];
		updateOn: CFThemeChooserChanged from: [ self announcer ];
		yourself
]
