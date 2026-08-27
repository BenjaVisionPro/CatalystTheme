Class {
	#name : #BaselineOfCatalystTheme,
	#superclass : #BaselineOf,
	#category : #BaselineOfCatalystTheme,
	#package : #BaselineOfCatalystTheme
}

{ #category : #baseline }
BaselineOfCatalystTheme >> baseline: spec [
	<baseline>
	spec for: #common do: [
		spec
			package: 'BVC-Theme-Core';
			package: 'BVC-Theme-GT' with: [ spec requires: #('BVC-Theme-Core') ];
			package: 'BVC-Theme-Light' with: [ spec requires: #('BVC-Theme-GT') ];
			package: 'BVC-Theme-Dark' with: [ spec requires: #('BVC-Theme-GT') ] ]
]
