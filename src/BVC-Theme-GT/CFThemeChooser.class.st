Class {
	#name : #CFThemeChooser,
	#superclass : #CFObject,
	#instVars : [
		'announcer',
		'choices',
		'selectedTheme',
		'themeConfiguration',
		'themeElement',
		'chooserElement'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #defaults }
CFThemeChooser class >> defaultIcon [
	^ #window
]


{ #category : #accessing }
CFThemeChooser >> label [
	^ 'Theme Chooser'
]

{ #category : #'magritte descriptions' }
CFThemeChooser >> labelDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #label;
		label: 'Label';
		priority: 6;
		beReadOnly;
		yourself
]

{ #category : #accessing }
CFThemeChooser >> comment [
	^ 'Choose Foundation theme.'
]

{ #category : #'magritte descriptions' }
CFThemeChooser >> commentDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #comment;
		label: 'Comment';
		priority: 7;
		beReadOnly;
		yourself
]

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
	chooserElement ifNotNil: [ chooserElement theme: aChoice theme ].
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
	| catalystThemeClasses anAppearanceState catalystChoices gtChoices |
	catalystThemeClasses := CgtTheme subclasses.
	anAppearanceState := (catalystThemeClasses includes: currentTheme class)
		ifTrue: [ currentTheme appearanceState ]
		ifFalse: [ CgtAppearanceState new ].

	catalystChoices := catalystThemeClasses collect: [ :aThemeClass |
		| aTheme |
		aTheme := aThemeClass = currentTheme class
			ifTrue: [ currentTheme ]
			ifFalse: [ aThemeClass appearanceState: anAppearanceState ].
		CFThemeChoice
			theme: aTheme
			configuration: anAppearanceState ].

	gtChoices := {
		CFThemeChoice
			theme: (currentTheme class = BrGlamorousLightTheme
				ifTrue: [ currentTheme ]
				ifFalse: [ BrGlamorousLightTheme new ])
			configuration: nil.
		CFThemeChoice
			theme: (currentTheme class = BrGlamorousDarkTheme
				ifTrue: [ currentTheme ]
				ifFalse: [ BrGlamorousDarkTheme new ])
			configuration: nil }.

	^ catalystChoices , gtChoices
]


{ #category : #'private - presentation' }
CFThemeChooser >> chooserElement: anElement [
	chooserElement := anElement
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
		classes: { CgtAppearanceState };
		beReadOnly;
		fieldConfigure: [ :field |
			field beEmbeddedForm
				hideRelationRow;
				configurePresentation: [ :aPresentation |
					aPresentation
						group: 'Colours' configure: [ :aGroup | aGroup hideLabel ];
						group: 'Lighting' configure: [ :aGroup | aGroup hideLabel ] ] ];
		updateOn: CFThemeChooserChanged from: [ self announcer ];
		yourself
]
