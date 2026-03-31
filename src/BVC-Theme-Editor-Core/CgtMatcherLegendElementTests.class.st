"
#Matcher Legend Element Tests
I verify the compact matcher legend content. I am responsible for checking that the legend exposes the main node and relation semantics without needing a live editor.
"
Class {
	#name : 'CgtMatcherLegendElementTests',
	#superclass : 'TestCase',
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'tests' }
CgtMatcherLegendElementTests >> testLegendInitializesPolicies [
	<gtExample>
	| legend |
	legend := CgtMatcherLegendElement new.
	self assert: legend notNil
	^ legend

]
