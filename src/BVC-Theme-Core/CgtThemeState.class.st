Class {
	#name : #CgtThemeState,
	#superclass : #CFObject,
	#instVars : [
		'announcer',
		'highlightColor',
		'textHighlightColor',
		'lightDirection',
		'useTimeOfDay'
	],
	#classVars : [
		'Default'
	],
	#category : #'BVC-Theme-Core'
}

{ #category : #accessing }
CgtThemeState class >> default [
	^ Default ifNil: [ Default := self new ]
]

{ #category : #defaults }
CgtThemeState class >> defaultHighlightColor [
	^ CgtPalette highlightBlue
]

{ #category : #defaults }
CgtThemeState class >> defaultLightDirection [
	^ CFLightDirection forCurrentTimeOfDay
]

{ #category : #defaults }
CgtThemeState class >> defaultTextHighlightColor [
	^ CgtPalette textHighlightBlue
]

{ #category : #defaults }
CgtThemeState class >> defaultUseTimeOfDay [
	^ true
]

{ #category : #'class initialization' }
CgtThemeState class >> resetDefault [
	Default := nil
]

{ #category : #accessing }
CgtThemeState >> announcer [
	^ announcer
]

{ #category : #private }
CgtThemeState >> announceChanged [
	self announcer announce: (CgtThemeStateChanged new state: self)
]

{ #category : #accessing }
CgtThemeState >> effectiveLightDirection [
	^ self useTimeOfDay
		ifTrue: [ CFLightDirection forCurrentTimeOfDay ]
		ifFalse: [ self lightDirection ]
]

{ #category : #accessing }
CgtThemeState >> highlightColor [
	^ highlightColor
]

{ #category : #accessing }
CgtThemeState >> highlightColor: aColor [
	highlightColor = aColor ifTrue: [ ^ self ].
	highlightColor := aColor.
	self announceChanged
]

{ #category : #'magritte descriptions' }
CgtThemeState >> highlightColorDescription [
	<magritteDescription>
	^ MASingleOptionDescription new
		accessor: #highlightColor;
		label: 'Highlight';
		priority: 10;
		options: CgtPalette highlightColours;
		autoAccept: true;
		fieldConfigure: [ :field |
			field beColourPicker
				colourBlock: [ :aColour | aColour ];
				labelBlock: [ :aColour |
					CgtPalette highlightNameFor: aColour ] ];
		beRequired;
		yourself
]

{ #category : #'magritte descriptions' }
CgtThemeState >> iconDescription [
	^ nil
]

{ #category : #initialization }
CgtThemeState >> initialize [
	super initialize.
	announcer := Announcer new.
	highlightColor := self class defaultHighlightColor.
	textHighlightColor := self class defaultTextHighlightColor.
	lightDirection := self class defaultLightDirection.
	useTimeOfDay := self class defaultUseTimeOfDay
]

{ #category : #accessing }
CgtThemeState >> lightDirection [
	^ lightDirection
]

{ #category : #accessing }
CgtThemeState >> lightDirection: aPointOrVector [
	| aVector |
	aVector := aPointOrVector asBlocVector normalized.
	lightDirection = aVector ifTrue: [ ^ self ].
	lightDirection := aVector.
	self announceChanged
]

{ #category : #accessing }
CgtThemeState >> lightDirectionDegrees [
	^ self lightDirection degrees
]

{ #category : #accessing }
CgtThemeState >> lightDirectionDegrees: aNumber [
	self lightDirection: (CFLightDirection fromDegrees: aNumber)
]

{ #category : #'magritte descriptions' }
CgtThemeState >> lightDirectionDegreesDescription [
	<magritteDescription>
	^ MANumberDescription new
		accessor: #lightDirectionDegrees;
		label: 'Angle';
		priority: 40;
		min: 0;
		max: 360;
		autoAccept: true;
		enabledBlock: [ :aState | aState useTimeOfDay not ];
		fieldConfigure: [ :field | field beSlider ];
		yourself
]

{ #category : #accessing }
CgtThemeState >> textHighlightColor [
	^ textHighlightColor
]

{ #category : #accessing }
CgtThemeState >> textHighlightColor: aColor [
	textHighlightColor = aColor ifTrue: [ ^ self ].
	textHighlightColor := aColor.
	self announceChanged
]

{ #category : #'magritte descriptions' }
CgtThemeState >> textHighlightColorDescription [
	<magritteDescription>
	^ MASingleOptionDescription new
		accessor: #textHighlightColor;
		label: 'Text highlight';
		priority: 20;
		options: ({ nil } , CgtPalette textHighlightColours);
		autoAccept: true;
		fieldConfigure: [ :field |
			field bePopup
				displayBlock: [ :aColour |
					CgtPalette textHighlightNameFor: aColour ] ];
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
CgtThemeState >> useTimeOfDay [
	^ useTimeOfDay
]

{ #category : #accessing }
CgtThemeState >> useTimeOfDay: aBoolean [
	useTimeOfDay = aBoolean ifTrue: [ ^ self ].
	useTimeOfDay := aBoolean.
	self announceChanged
]

{ #category : #'magritte descriptions' }
CgtThemeState >> useTimeOfDayDescription [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: #useTimeOfDay;
		label: 'Time of day';
		priority: 30;
		autoAccept: true;
		yourself
]
