Class {
	#name : #CFThemeChooser,
	#superclass : #CFObject,
	#instVars : [
		'announcer',
		'choices',
		'selectedTheme',
		'themeConfiguration',
		'themeElement'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #'instance creation' }
CFThemeChooser class >> forElement: anElement [
	^ self new
		themeElement: anElement;
		yourself
]

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
	super initialize.
	announcer := Announcer new.
	choices := #()
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
	themeElement theme: aChoice theme.
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
	^ CgtAbstractTheme subclasses collect: [ :aThemeClass |
		| aTheme |
		aTheme := aThemeClass = currentTheme class
			ifTrue: [ currentTheme ]
			ifFalse: [ aThemeClass state: currentTheme themeState ].
		CFThemeChoice
			theme: aTheme
			configuration: aTheme themeState ]
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
CFThemeChooser >> themeElement [
	^ themeElement
]

{ #category : #accessing }
CFThemeChooser >> themeElement: anElement [
	| currentTheme |
	themeElement := anElement.
	currentTheme := anElement theme.
	choices := self themeChoicesFor: currentTheme.
	selectedTheme := choices
		detect: [ :aChoice | aChoice theme == currentTheme ]
		ifNone: [ choices first ].
	themeConfiguration := selectedTheme configuration
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
