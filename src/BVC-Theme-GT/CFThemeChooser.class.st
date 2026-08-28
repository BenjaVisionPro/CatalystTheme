Class {
	#name : #CFThemeChooser,
	#superclass : #CFObject,
	#instVars : [
		'announcer',
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
	super initialize.
	announcer := Announcer new.
	selectedTheme := BlTheme default.
	themeConfiguration := selectedTheme themeState
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
CFThemeChooser >> selectedTheme: aTheme [
	selectedTheme == aTheme ifTrue: [ ^ self ].
	selectedTheme := aTheme.
	themeConfiguration := aTheme themeState.
	BlTheme default: aTheme.
	worldElement ifNotNil: [ worldElement theme: aTheme ].
	self announcer announce: CFThemeChooserChanged new
]

{ #category : #'magritte descriptions' }
CFThemeChooser >> selectedThemeDescription [
	<magritteDescription>
	| theThemeClasses theThemes |
	theThemeClasses := BlTheme allSubclasses
		select: [ :aThemeClass | aThemeClass canBeDefault ].
	(theThemeClasses includes: selectedTheme class) ifFalse: [
		theThemeClasses := { selectedTheme class } , theThemeClasses ].
	theThemes := theThemeClasses collect: [ :aThemeClass |
		aThemeClass = selectedTheme class
			ifTrue: [ selectedTheme ]
			ifFalse: [ aThemeClass new ] ].

	^ MASingleOptionDescription new
		accessor: #selectedTheme;
		label: 'Theme';
		priority: 10;
		options: theThemes;
		autoAccept: true;
		fieldConfigure: [ :field |
			field bePopup
				displayBlock: [ :aTheme | aTheme class name ] ];
		beRequired;
		yourself
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
