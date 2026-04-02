
"
#Matcher Chip Element Tests
I verify matcher-chip interaction behavior. I am responsible for checking that class and element-id chips emit explicit matcher toggle events and keep their display contract narrow enough for the upcoming custom selector rows.
"
Class {
	#name : 'CgtMatcherChipElementTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtMatcherChipElementTests >> testClassChipTogglePublishesClassMatchToggledEvent [
	<gtExample>
	| node element event |
	node := (CgtMatcherProjectionNode kind: #selectedElement)
		className: 'SelectedElement';
		matchByClass: false;
		yourself.
	element := CgtMatcherChipElement new
		chipKind: #class;
		projectionNode: node;
		enabled: false;
		yourself.
	element when: CgtMatcherClassMatchToggledEvent do: [ :anEvent | event := anEvent ].
	element toggleEnabled.
	self assert: event notNil.
	self assert: event projectionNode identicalTo: node.
	self assert: event shouldMatch.
	^ element
]

{ #category : 'tests' }
CgtMatcherChipElementTests >> testElementIdChipTogglePublishesIdMatchToggledEvent [
	<gtExample>
	| node element event |
	node := (CgtMatcherProjectionNode kind: #selectedElement)
		elementId: (BlElementId named: #'selected-node');
		matchById: true;
		yourself.
	element := CgtMatcherChipElement new
		chipKind: #elementId;
		projectionNode: node;
		enabled: true;
		yourself.
	element when: CgtMatcherIdMatchToggledEvent do: [ :anEvent | event := anEvent ].
	element toggleEnabled.
	self assert: event notNil.
	self assert: event projectionNode identicalTo: node.
	self deny: event shouldMatch.
	^ element
]

{ #category : 'tests' }
CgtMatcherChipElementTests >> testDefaultLabelUsesChipKind [
	<gtExample>
	| classChip idChip |
	classChip := CgtMatcherChipElement new chipKind: #class; yourself.
	idChip := CgtMatcherChipElement new chipKind: #elementId; yourself.
	self assert: classChip displayLabel equals: 'Class'.
	self assert: idChip displayLabel equals: 'Element id'.
	^ classChip
]

{ #category : 'tests' }
CgtMatcherChipElementTests >> testLayoutPolicyProvidesMinimumChipWidth [
	<gtExample>
	self assert: CgtMatcherLayoutPolicy new chipMinimumWidth equals: 56.
	^ CgtMatcherLayoutPolicy new
]
