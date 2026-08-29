Class {
	#name : #CgtAppearanceState,
	#superclass : #CFObject,
	#instVars : [
		'announcer',
		'themeColour',
		'textSelectionColour',
		'lightDirection',
		'useTimeOfDay'
	],
	#classVars : [
		'Default'
	],
	#category : #'BVC-Theme-Core'
}

{ #category : #accessing }
CgtAppearanceState class >> default [
	^ Default ifNil: [ Default := self new ]
]

{ #category : #defaults }
CgtAppearanceState class >> defaultThemeColour [
	^ CgtPalette themeBlue
]

{ #category : #defaults }
CgtAppearanceState class >> defaultLightDirection [
	^ CFLightDirection forCurrentTimeOfDay
]

{ #category : #defaults }
CgtAppearanceState class >> defaultTextSelectionColour [
	^ nil
]

{ #category : #defaults }
CgtAppearanceState class >> defaultUseTimeOfDay [
	^ true
]

{ #category : #'class initialization' }
CgtAppearanceState class >> resetDefault [
	Default := nil
]

{ #category : #accessing }
CgtAppearanceState >> announcer [
	^ announcer
]

{ #category : #private }
CgtAppearanceState >> announceChanged [
	self announcer announce: (CgtAppearanceStateChanged new appearanceState: self)
]

{ #category : #accessing }
CgtAppearanceState >> effectiveLightDirection [
	^ self useTimeOfDay
		ifTrue: [ CFLightDirection forCurrentTimeOfDay ]
		ifFalse: [ self lightDirection ]
]

{ #category : #accessing }
CgtAppearanceState >> themeColour [
	^ themeColour
]

{ #category : #accessing }
CgtAppearanceState >> themeColour: aColor [
	themeColour = aColor ifTrue: [ ^ self ].
	themeColour := aColor.
	self announceChanged
]

{ #category : #'magritte descriptions' }
CgtAppearanceState >> themeColourDescription [
	<magritteDescription>
	^ MASingleOptionDescription new
		accessor: #themeColour;
		label: 'Theme colour';
		group: 'Colours';
		priority: 10;
		options: CgtPalette themeColours;
		autoAccept: true;
		fieldConfigure: [ :field |
			field beColourPicker
				colourBlock: [ :aColour | aColour ];
				labelBlock: [ :aColour |
					CgtPalette themeNameFor: aColour ] ];
		beRequired;
		yourself
]

{ #category : #'magritte descriptions' }
CgtAppearanceState >> iconDescription [
	^ nil
]

{ #category : #initialization }
CgtAppearanceState >> initialize [
	super initialize.
	announcer := Announcer new.
	themeColour := self class defaultThemeColour.
	textSelectionColour := self class defaultTextSelectionColour.
	lightDirection := self class defaultLightDirection.
	useTimeOfDay := self class defaultUseTimeOfDay
]

{ #category : #accessing }
CgtAppearanceState >> lightDirection [
	^ lightDirection
]

{ #category : #accessing }
CgtAppearanceState >> lightDirection: aPointOrVector [
	| aVector |
	aVector := aPointOrVector asBlocVector normalized.
	lightDirection = aVector ifTrue: [ ^ self ].
	lightDirection := aVector.
	self announceChanged
]

{ #category : #accessing }
CgtAppearanceState >> lightDirectionDegrees [
	^ self lightDirection degrees
]

{ #category : #accessing }
CgtAppearanceState >> lightDirectionDegrees: aNumber [
	self lightDirection: (CFLightDirection fromDegrees: aNumber)
]

{ #category : #'magritte descriptions' }
CgtAppearanceState >> lightDirectionDegreesDescription [
	<magritteDescription>
	^ MANumberDescription new
		accessor: #lightDirectionDegrees;
		label: 'Angle';
		group: 'Lighting';
		priority: 30;
		min: 0;
		max: 360;
		autoAccept: true;
		enabledBlock: [ :aState | aState useTimeOfDay not ];
		fieldConfigure: [ :field | field beSlider ];
		yourself
]



{ #category : #accessing }
CgtAppearanceState >> effectiveTextSelectionColour [
	^ self textSelectionColour
		ifNil: [ CgtPalette automaticTextSelectionColourForThemeColour: self themeColour ]
]

{ #category : #accessing }
CgtAppearanceState >> textSelectionColour [
	^ textSelectionColour
]

{ #category : #accessing }
CgtAppearanceState >> textSelectionColour: aColor [
	textSelectionColour = aColor ifTrue: [ ^ self ].
	textSelectionColour := aColor.
	self announceChanged
]

{ #category : #'magritte descriptions' }
CgtAppearanceState >> textSelectionColourDescription [
	<magritteDescription>
	^ MASingleOptionDescription new
		accessor: #textSelectionColour;
		label: 'Text selection';
		group: 'Colours';
		priority: 20;
		options: ({ nil } , CgtPalette textSelectionColours);
		autoAccept: true;
		fieldConfigure: [ :field |
			field bePopup
				displayBlock: [ :aColour |
					CgtPalette textSelectionNameFor: aColour ] ];
		blocOptionIconStencil: [ :aColour |
			aColour
				ifNil: [
					CFMaDetailColourSwatchElement automaticSize: 14 @ 14 ]
				ifNotNil: [
					CFMaDetailColourSwatchElement
						colour: aColour
						size: 14 @ 14 ] ];
		yourself
]

{ #category : #accessing }
CgtAppearanceState >> useTimeOfDay [
	^ useTimeOfDay
]

{ #category : #accessing }
CgtAppearanceState >> useTimeOfDay: aBoolean [
	useTimeOfDay = aBoolean ifTrue: [ ^ self ].
	useTimeOfDay := aBoolean.
	self announceChanged
]

{ #category : #'magritte descriptions' }
CgtAppearanceState >> useTimeOfDayDescription [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: #useTimeOfDay;
		label: 'Time of day';
		comment: 'Automatically derives the light direction from the current local time.';
		group: 'Lighting';
		priority: 40;
		autoAccept: true;
		yourself
]
