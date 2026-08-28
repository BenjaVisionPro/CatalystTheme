Class {
	#name : #CFThemeChooser,
	#superclass : #CFObject,
	#instVars : [
		'announcer',
		'selectedTheme',
		'themeConfiguration'
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
	BlSpace allOpenSpacesDo: [ :aSpace | aSpace theme: aTheme ].
	self announcer announce: CFThemeChooserChanged new
]

{ #category : #'magritte descriptions' }
CFThemeChooser >> selectedThemeDescription [
	<magritteDescription>
	^ MASingleOptionDescription new
		accessor: #selectedTheme;
		label: 'Theme';
		priority: 10;
		options: (BlTheme allSubclasses
			select: [ :aThemeClass | aThemeClass canBeDefault ]
			thenCollect: [ :aThemeClass | aThemeClass new ]);
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

{ #category : #'magritte descriptions' }
CFThemeChooser >> themeConfigurationDescription [
	<magritteDescription>
	^ MAToOneRelationDescription new
		accessor: #themeConfiguration;
		label: 'Configuration';
		priority: 20;
		fieldConfigure: [ :field | field beEmbeddedForms ];
		updateOn: CFThemeChooserChanged from: [ self announcer ];
		yourself
]
