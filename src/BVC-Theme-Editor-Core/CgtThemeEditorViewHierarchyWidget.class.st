Class {
	#name : 'CgtThemeEditorViewHierarchyWidget',
	#superclass : 'BrSimpleTree',
	#instVars : [
		'editor'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'instance creation' }
CgtThemeEditorViewHierarchyWidget class >> on: aThemeEditor [
	^ self new
		editor: aThemeEditor;
		initializeForEditor;
		yourself
]

{ #category : 'private - binding' }
CgtThemeEditorViewHierarchyWidget >> bindElementTreeValue: eachElement toRowElement: aRowElement [
	aRowElement childWithId: #elementLabel ifFound: [ :anElementLabel |
		anElementLabel text: eachElement class name ] ifNone: [ ].

	aRowElement childWithId: #elementId ifFound: [ :anElementIdButton |
		eachElement id = BlElementId noId
			ifTrue: [
				anElementIdButton model: nil.
				anElementIdButton label: ''.
				anElementIdButton visibility: BlVisibility gone ]
			ifFalse: [
				anElementIdButton model: eachElement id.
				anElementIdButton label: eachElement id asSymbol printString.
				anElementIdButton visibility: BlVisibility visible ] ] ifNone: [ ].

	aRowElement childWithId: #elementResizers ifFound: [ :anElementResizersLabel |
		anElementResizersLabel text: (String streamContents: [ :aStream |
			aStream
				nextPutAll: 'h: ';
				nextPutAll: eachElement constraints horizontal resizer asString asLowercase;
				nextPutAll: ' ';
				nextPutAll: 'v: ';
				nextPutAll: eachElement constraints vertical resizer asString asLowercase ]) ] ifNone: [ ]
]

{ #category : 'accessing' }
CgtThemeEditorViewHierarchyWidget >> editor [
	^ editor
]

{ #category : 'accessing' }
CgtThemeEditorViewHierarchyWidget >> editor: aThemeEditor [
	editor := aThemeEditor
]

{ #category : 'initialization' }
CgtThemeEditorViewHierarchyWidget >> initializeForEditor [
	self matchParent;
		padding: (BlInsets top: 5);
		rowStencil: (CgtThemeEditorTreeRowStencilBuilder new
			whenHovered: [ :anEvent | | thisRow thisRowValue |
				thisRow := anEvent currentTarget.
				thisRowValue := (self nodeAt: thisRow constraints infinite holder dataSourcePosition) value.
				editor highlightedElement: thisRowValue ];
			whenUnhovered: [ :anEvent |
				editor highlightedElement: editor selectedElement ]);
		addEventHandler: (GtPhlowListToSelectHandler new
			transformation: (GtPhlowSendTransformation object: [ :aTreeNode | aTreeNode value ]));
		when: GtPhlowObjectEvent do: [ :anEvent |
			(anEvent object isKindOf: BlElement)
				ifTrue: [ editor selectedElement: anEvent object ] ];
		nodeStencil: [ self newTreeRowElement ];
		nodeDataBinder: [ :eachRow :eachElement | self bindElementTreeValue: eachElement toRowElement: eachRow ];
		yourself.
	self refreshItems
]

{ #category : 'instance creation' }
CgtThemeEditorViewHierarchyWidget >> newTreeRowElement [
	^ BrHorizontalPane new
		hMatchParent;
		vFitContent;
		alignCenterLeft;
		addChildren: {
			BrLabel new
				beSmallSize;
				id: #elementLabel;
				aptitude: BrGlamorousLabelAptitude new.
			BrButton new
				beTinySize;
				id: #elementId;
				aptitude: (BrGlamorousButtonLabelAptitude new hoveredColor: Color black; pressedColor: Color black)
					+ (BrGlamorousButtonRectangularAptitude paddingScale: 0.8 heightScale: 0.85 cornerRadius: 3)
					+ (BrStyleCommonAptitude new
						default: [ :s | s background: (Color gray alpha: 0.1) ];
						hovered: [ :s | s background: (Color gray alpha: 0.2) ];
						pressed: [ :s | s background: (Color gray alpha: 0.3) ]);
				action: [ :aButtonElement | aButtonElement phlow spawnObject: aButtonElement model ].
			BrLabel new
				beSmallSize;
				id: #elementResizers;
				aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray) }
]

{ #category : 'accessing' }
CgtThemeEditorViewHierarchyWidget >> refreshItems [
	self items: editor targetElement children lazy: [ :each | each children ]
]

{ #category : 'accessing' }
CgtThemeEditorViewHierarchyWidget >> selectElement: anElement [
	anElement ifNil: [ ^ self ].
	self refreshItems.
	self expandSuchThat: [ :aTreeNode |
		(anElement hasParent: aTreeNode value) or: [ anElement == aTreeNode value ] ].
	self selectAndScrollTo: anElement
]
